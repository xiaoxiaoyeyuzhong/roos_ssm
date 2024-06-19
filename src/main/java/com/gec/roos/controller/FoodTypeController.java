package com.gec.roos.controller;

import com.gec.roos.pojo.FoodType;
import com.gec.roos.service.FoodTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.util.List;

@Controller
public class FoodTypeController {

    @Autowired
    private FoodTypeService foodTypeService;

    //查询所有的菜品分类
    @RequestMapping("/queryAllfoodType")
    public String queryAllfoodType(Model model){
        //总行数
        int count = foodTypeService.selectTypeSumCount();
        //总页数
        int countPage = count%15==0?count/15:count/15+1;
//        List<Food> foods = foodService.queryAllfood(0);
        List<FoodType> ftlist = foodTypeService.queryAllfoodType();

//        model.addAttribute("typeid", typeid);
//        model.addAttribute("foods", foods);
        model.addAttribute("ftlist", ftlist);
        model.addAttribute("countPage", countPage);
        return "back/foodTypeInfo";
    }

    //进入添加菜品分类页面
    @RequestMapping("/openType")
    public String openType(HttpServletRequest request){
        List<FoodType> ftlist= foodTypeService.queryAllfoodType();
        request.setAttribute("ftlist", ftlist);
        return "back/addtype";
    }

    //添加菜品分类
    @RequestMapping("/addfoodType")
    public String addfoodtype(HttpServletRequest request, @RequestParam("file") MultipartFile photo, FoodType foodType){
        String msg = null;
        //获取文件名称
        String filename = photo.getOriginalFilename();

        //日志打印
//        Logger log = LoggerFactory.getLogger(FoodController.class);
//        log.info("filename is"+filename);
        // 文件上传的路径
        String path =  request.getSession().getServletContext().getRealPath("/upload/food");
        try {
            File file = new File(path, filename);
            //调用transferTo将上传的文件保存到指定的地址
            photo.transferTo(file);
            //设置图片路径
            foodType.setPicurl("upload/food/"+filename);
            //添加菜品
            foodTypeService.addFoodType(foodType);
            msg = "1";
        } catch (Exception e) {
            msg = "0";
        }
        request.setAttribute("msg", msg);
        return "back/addtype";
    }

    //查询要修改的菜品分类
    @RequestMapping("/openupdatefoodType")
    public String openupdatefoodType(Model model,int typeid){
//        Food food = foodService.queryfoodById(fid);
        FoodType foodType = foodTypeService.queryfoodTypeById(typeid);
//        model.addAttribute("food", food);
        model.addAttribute("ft",foodType);
//        model.addAttribute("ftlist", ftlist);
        model.addAttribute("typeid", typeid);
        return "back/updatefoodType";
    }

    //修改菜品分类信息
    @RequestMapping("/updatefoodTypeInfo")
    public String updatefoodTypeInfo(HttpServletRequest request, @RequestParam("file") MultipartFile photo, FoodType foodType){
        String msg = null;
        try {
            if(!photo.isEmpty()){
                //获取文件名称
                String filename = photo.getOriginalFilename();
                // 文件上传的路径
                String path =  request.getSession().getServletContext().getRealPath("/upload/food");
                assert filename != null;
                File file = new File(path, filename);
                //完成文件上传
                photo.transferTo(file);
                //设置图片路径
                foodType.setPicurl("upload/food/"+filename);
            }
            foodTypeService.updatefoodTypeInfo(foodType);
            msg = "1";
        } catch (Exception e) {
            msg = "0";
        }
        request.setAttribute("msg", msg);
        return "back/updatefoodType";
    }

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
