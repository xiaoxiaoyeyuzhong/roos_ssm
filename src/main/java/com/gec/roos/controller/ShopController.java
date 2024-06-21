package com.gec.roos.controller;

import com.gec.roos.pojo.Address;
import com.gec.roos.pojo.FoodType;
import com.gec.roos.pojo.Gift;
import com.gec.roos.pojo.User;
import com.gec.roos.service.*;
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
}
