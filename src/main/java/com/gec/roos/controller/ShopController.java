package com.gec.roos.controller;

import com.gec.roos.pojo.*;
import com.gec.roos.service.*;
import com.gec.roos.vo.PayVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.util.List;

@Controller
public class ShopController {
    @Autowired
    private UserService userService;
    @Autowired
    private AddressService addressService;

    @Autowired
    private GiftService giftService;

    @Autowired
    private FoodTypeService foodTypeService;

    @Autowired
    private GiftOrderService giftOrderService;


    @Autowired
    private ShopService shopService;

    //兑换详情
    @RequestMapping("/exchange")
    public String exchange(Model model, String openid, int pid){
        // 获取所有的菜品分类名称
        List<FoodType> ftlist = foodTypeService.queryAllfoodType();

        //获取当前的礼品信息
        Gift gift = giftService.queryGiftInfoById(pid);
        //获取用户的积分总数
        User user = userService.queryUser(openid);
        //获取用户的收货信息
        Address address = addressService.queryAddressInfo(openid);
        if(address==null){
            model.addAttribute("haveAdd", "no");
        }
        int user_integral = user.getIntegral();
        int gift_integral = gift.getIntegral();
        if(user_integral<gift_integral){
            model.addAttribute("msg", "不足");
        }
        model.addAttribute("user", user);
        model.addAttribute("gift", gift);
        model.addAttribute("address", address);
        model.addAttribute("openid", openid);
        model.addAttribute("ftlist", ftlist);
        return "shop/exchange";
    }

    //查询用户是否有默认地址
    @RequestMapping("/queryAddress")
    @ResponseBody
    public String queryAddress(Model model,String openid) {
        String success = null;
        Address address = addressService.queryAddressInfo(openid);
        if (address != null) {//有收件地址
            success = "ok";
        } else {
            success = "no";
        }
        return success;
    }

    //编辑收货地址
    @RequestMapping("/getUserAddress")
    @ResponseBody
    public Address queryAddressById(String openid){
        //根据openid获取收货地址
        Address address = addressService.queryAddressInfo(openid);
        return address;
    }

    //删除收件地址
    @RequestMapping("/delAddressInfo")
    @ResponseBody
    public String delAddressInfo(Model model, String openid){
        int result= addressService.delAddressInfo(openid);
        model.addAttribute("openid", openid);
//        model.addAttribute("data",data);
        String msg = Integer.toString(result);
        return msg;
    }

    //运费支付成功回调请求
    @RequestMapping("postagePaymentSuccessed")
    public String postagePaymentSuccessed(String openid , int pid , PayVo payVo){
        //1.执行运费支付成功在gift_order 插入记录
        GiftOrder giftOrder = new GiftOrder();
        giftOrder.setOpenid(openid);
        giftOrder.setPid(pid);
        giftOrder.setState("已提交订单,待发货");
        giftOrderService.addGiftOrder(giftOrder);
        Gift gift =new Gift();
        gift=giftService.queryGiftInfoById(pid);

        userService.updateUserIntegralByopenid(-gift.getIntegral(),openid);
        //重定向到 用户已兑换请求
        return "redirect:queryMyGift?openid="+openid;
    }

    //查看分店信息
    @RequestMapping("/queryShopInfo")
    public String queryShopInfo(HttpServletRequest request){
        List<Shop> shops = shopService.queryAllShopInfo();
        request.setAttribute("shops", shops);
        return "back/shopInfo";
    }



    //进入添加分店信息页面
    @RequestMapping("/openAddShop")
    public String openAddShop(){
        return "back/addshopInfo";
    }

    //添加分店信息
    @RequestMapping("/addShopInfo")
    public String addShopInfo(HttpServletRequest request, @RequestParam("file") MultipartFile photo, Shop shop){
        String msg = null;
        // 文件上传的路径
        String path =  request.getSession().getServletContext().getRealPath("/upload/shop");
        try {
            if(photo != null&& !photo.isEmpty()){
                //获取文件名称
                String filename = photo.getOriginalFilename();

                assert filename != null;
                File file = new File(path, filename);
                //完成文件上传
                photo.transferTo(file);
                //设置图片路径
                shop.setImgurl("upload/shop/"+filename);
            }
            //添加礼品
            shopService.addShop(shop);
            msg = "1";
        } catch (Exception e) {
            e.printStackTrace();
            msg = "0";
        }
        request.setAttribute("msg", msg);
        return "back/addshopInfo";
    }


    //进入修改分店信息页面
    @RequestMapping("/openUpdateShop")
    public String openUpdateShop(HttpServletRequest request,int id){
        //首先根据id查询出要修改的分店信息
        Shop shop = shopService.queryShopById(id);
        request.setAttribute("shop", shop);
        return "back/updateshopInfo";
    }

    //修改分店信息
    @RequestMapping("/updateShopInfo")
    public String updateShopInfo(HttpServletRequest request,@RequestParam("file") MultipartFile photo,Shop shop){
        String msg = null;
        //获取文件名称
        String filename = photo.getOriginalFilename();
        // 文件上传的路径
        String path =  request.getSession().getServletContext().getRealPath("/upload/shop");
        try {
            if (photo!=null && !photo.isEmpty()){
                assert filename != null;
                File file = new File(path, filename);
                //完成文件上传
                photo.transferTo(file);
                //设置图片路径
                shop.setImgurl("upload/shop/"+filename);
            }
            //添加礼品
            shopService.updateShop(shop);
            msg = "1";
        } catch (Exception e) {
            e.printStackTrace();
            msg = "0";
        }
        request.setAttribute("msg", msg);
        return "back/updateshopInfo";
    }

    //删除分店信息
    @RequestMapping("/deleteShopInfo")
    @ResponseBody
    public String deleteShopInfo(int id){
        String msg = null;
        try {
            shopService.deleteShopInfo(id);
            msg = "1";
        } catch (Exception e) {
            msg = "0";
        }
        return msg;
    }
}
