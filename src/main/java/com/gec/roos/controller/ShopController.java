package com.gec.roos.controller;

import com.gec.roos.pojo.*;
import com.gec.roos.service.*;
import com.gec.roos.vo.PayVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

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
        //重定向到 用户已兑换请求
        return "redirect:queryMyGift?openid="+openid;
    }
}
