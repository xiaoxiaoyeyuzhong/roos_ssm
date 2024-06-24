package com.gec.roos.controller;

import com.alipay.api.AlipayApiException;
import com.gec.roos.config.AlipayTemplate;
import com.gec.roos.pojo.Address;
import com.gec.roos.pojo.FoodType;
import com.gec.roos.pojo.Gift;
import com.gec.roos.pojo.GiftOrder;
import com.gec.roos.service.AddressService;
import com.gec.roos.service.FoodTypeService;
import com.gec.roos.service.GiftService;
import com.gec.roos.vo.PayVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Random;

@Controller
public class IntegralShopConttroller {
    @Autowired
    private FoodTypeService foodTypeService;
    @Autowired
    private GiftService giftService;

    @Autowired
    private AddressService addressService;

    @Autowired
    private AlipayTemplate alipayTemplate;

    @Autowired
    private GiftService giftOrderService;

    //进入礼品商城
    @RequestMapping("/goToIntegralShop")
    public String goToIntegralShop(Model model, String openid){
        // 获取所有的菜品分类名称
        List<FoodType> ftlist = foodTypeService.queryAllfoodType();
        //获取所有的礼品信息
        List<Gift> gifts = giftService.queryAllGiftInfo();
        if(gifts.size()==0){
            model.addAttribute("msg", "0");
        }
        model.addAttribute("gifts", gifts);
        model.addAttribute("ftlist", ftlist);
        model.addAttribute("openid", openid);
        return "shop/integralshop";
    }

    //添加收件地址信息
    @RequestMapping("/addAddressInfo")
    @ResponseBody
    public String addAddress(String openid,String userName,String mobile,String address){
        String msg = null;
        //校验数据是否完整
        if(userName==null||mobile==null||address==null||"".equals(userName)||"".equals(mobile)||"".equals(address))
            return "null";

        Address addressInfo = new Address();
        addressInfo.setOpenid(openid);
        addressInfo.setUserName(userName);
        addressInfo.setMobile(mobile);
        addressInfo.setAddress(address);
        //判断收货地址是否存在
        Address address1 = addressService.queryAddressInfo(openid);
        if(address1==null){
            //添加收货地址
            int result = addressService.addAddressInfo(addressInfo);
            if(result>0){
                msg="1";
            }else{
                msg="0";
            }
        }else{
            //修改收货地址
            int result = addressService.updateAddressInfo(addressInfo);
            if(result>0){
                msg="1";
            }else{
                msg="0";
            }
        }
        return msg;
    }

    //去兑换展示页面
    @RequestMapping("/openorder")
    public String openorder(HttpServletRequest request, String openid, int pid){
        //查询收货地址
        Address address = addressService.queryAddressInfo(openid);
        //查询礼品信息
        Gift gift = giftService.queryGiftInfoById(pid);
        request.setAttribute("address", address);
        request.setAttribute("gift", gift);
        request.setAttribute("openid", openid);
        return "shop/order";
    }

    //支付宝生成运费支付页面
    @RequestMapping(value = "/payPostage")
    public void alipay(HttpServletResponse response, String openid, int pid) throws AlipayApiException {

        //1.根据礼品id查询礼品信息
        Gift gift = giftService.queryGiftInfoById(pid);

        //2.补充支付需要参数调用支付宝模板返回响应 字符串
        PayVo payVo = new PayVo();
        Date currentDate = new Date();
        Long outTradeNo = Long.parseLong(new SimpleDateFormat("yyyyMMddHHmmssSSS").format(currentDate)+new Random().nextInt(10));
        payVo.setOut_trade_no(outTradeNo.toString());
        payVo.setTotal_amount(gift.getPostage());//运费
        payVo.setSubject("积分兑换礼品运费");
        payVo.setBody("积分兑换礼品运费");
        //用于拼接回调请求参数
        String args ="?openid="+openid+"&pid="+pid;
        //请求支付宝生成 支付页面 字符串
        String result = alipayTemplate.payPostage(payVo, args);
        //由于生成内容为 支付页面的html字符串 需要让页面直接响应成HTML内容
        PrintWriter pw =null;
        //设置响应头 响应内容为 HTML文本内容
        response.setHeader("Content-Type","text/html;charset=UTF-8");
        try {
            pw = response.getWriter();
            pw.write(result);
            pw.flush();
        } catch (IOException e) {
            e.printStackTrace();
        }
        finally {
            pw.close();
        }
    }

    //查询我的礼品兑换记录
    @RequestMapping("/queryMyGift")
    public String queryMyGift(Model model,String openid){
        //1.查看所有菜品分类
        List<FoodType> ftlist = foodTypeService.queryAllfoodType();
        //2.该看该用户所有兑换记录
        List<GiftOrder> giftorder = giftOrderService.queryAll(openid);

        if(giftorder.size()==0){
            model.addAttribute("msg", "null");
        }
        model.addAttribute("giftorder", giftorder);
        model.addAttribute("openid", openid);
        model.addAttribute("ftlist", ftlist);
        return "shop/mygift";
    }
}
