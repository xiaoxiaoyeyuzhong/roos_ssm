package com.gec.roos.controller;

import com.gec.roos.pojo.FoodType;
import com.gec.roos.pojo.Gift;
import com.gec.roos.service.FoodTypeService;
import com.gec.roos.service.GiftService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
public class IntegralShopConttroller {
    @Autowired
    private FoodTypeService foodTypeService;
    @Autowired
    private GiftService giftService;

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
}
