package com.gec.roos.controller;

import com.gec.roos.pojo.FoodType;
import com.gec.roos.pojo.User;
import com.gec.roos.service.FoodTypeService;
import com.gec.roos.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
public class UserController {

    @Autowired
    private UserService userService;

    @Autowired
    private FoodTypeService foodTypeService;

    @RequestMapping("/queryUserInfo")
    public String queryUserInfo(Model model, String openid){
        String msg = null;
        //通过openid查询用户
        User user = userService.queryUser(openid);
        if(user==null){
            msg = "0";
        }
        model.addAttribute("msg",msg);
        model.addAttribute("user",user);
        return "back/userInfo";
    }

    //进入会员卡中心
    @RequestMapping("/openmember")
    public String openmember(Model model, String openid) {
        String url = null;
        // 获取所有的菜品分类名称
        List<FoodType> ftlist = foodTypeService.queryAllfoodType();
        // 判断当前用户是否是会员
        User user = userService.queryUser(openid);
        if (user == null) {
            model.addAttribute("msg", "0");
            url = "front/register";
        } else {

            model.addAttribute("user",user);
            url = "front/card";
        }
        model.addAttribute("ftlist", ftlist);
        model.addAttribute("openid", openid);
        return url;
    }
}