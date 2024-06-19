package com.gec.roos.controller;

import com.gec.roos.service.FoodTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class FoodTypeController {

    @Autowired
    private FoodTypeService foodTypeService;

    //删除菜品分类
    @RequestMapping("/deletefoodTypeInfo")
    public String deletefoodTypeInfo(Model model,int typeid)
    {
        String msg = null;
        try {
            foodTypeService.deletefoodTypeInfo(typeid);
            msg = "1";
        } catch (Exception e) {
            msg = "0";
        }
        model.addAttribute("msg", msg);
        return "back/foodTypeInfo";
    }
}
