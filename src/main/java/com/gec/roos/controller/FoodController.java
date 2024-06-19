package com.gec.roos.controller;

import com.gec.roos.pojo.Food;
import com.gec.roos.pojo.FoodType;
import com.gec.roos.service.FoodService;
import com.gec.roos.service.FoodTypeService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
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
public class FoodController {

    @Autowired
    private FoodService foodService;
    @Autowired
    private FoodTypeService foodTypeService;


    //查询所有的菜品
    @RequestMapping("/queryAllfood")
    public String queryAllfood(Model model, int typeid){
        //总行数
        int count = foodService.selectSumCount();
        //总页数
        int countPage = count%15==0?count/15:count/15+1;
        List<Food> foods = foodService.queryAllfood(0);
        List<FoodType> ftlist = foodTypeService.queryAllfoodType();

        model.addAttribute("typeid", typeid);
        model.addAttribute("foods", foods);
        model.addAttribute("ftlist", ftlist);
        model.addAttribute("countPage", countPage);
        return "back/foodsInfo";
    }

    //分页查询
    @RequestMapping("/pagequery")
    @ResponseBody
    public List<Food> pageFind(int typeid,int page){
        List<Food> foods=null;
        int start  = (page-1)*15;//计算查询起始下标
        if(typeid==0){
            foods = foodService.queryAllfood(start);
        }else{
            //根据分类分页查询菜品
            foods = foodService.selectFoodPage(typeid,start);
        }
        return foods;
    }

    //根据 typid查询所有的菜品与及菜品类型名称
    @RequestMapping("/queryfoodByTypeid")
    public String queryfoodByTypeid(Model model, int typeid){
        //1.当前菜品分类下的菜品总行数
        int count = foodService.selectSumCountBytypeId(typeid);
        //2.当前分类下的菜品总页数
        int countPage = count%15==0?count/15:count/15+1;
        //3.查询该分类下首页菜品
        List<Food> foods = foodService.selectFoodPage(typeid,0);
        //4.查询所有分类
        List<FoodType> ftlist = foodTypeService.queryAllfoodType();

        //5.数据转发
        model.addAttribute("foods", foods);
        model.addAttribute("ftlist", ftlist);
        model.addAttribute("typeid", typeid);
        model.addAttribute("countPage", countPage);
        return "back/foodsInfo";
    }

    //进入添加菜品页面
    @RequestMapping("/openAddfood")
    public String openAddfood(HttpServletRequest request){
        List<FoodType> ftlist= foodTypeService.queryAllfoodType();
        request.setAttribute("ftlist", ftlist);
        return "back/addfoods";
    }

    //添加菜品
    @RequestMapping("/addfood")
    public String addfood(HttpServletRequest request, @RequestParam("file") MultipartFile photo, Food food){
        String msg = null;
        //获取文件名称
        String filename = photo.getOriginalFilename();
        // 文件上传的路径
        String path =  request.getSession().getServletContext().getRealPath("/upload/food");
        try {

            File file = new File(path, filename);
            //调用transferTo将上传的文件保存到指定的地址
            photo.transferTo(file);
            //设置图片路径
            food.setPicurl("upload/food/"+filename);
            //添加菜品
            foodService.addFood(food);
            msg = "1";
        } catch (Exception e) {
            msg = "0";
        }
        request.setAttribute("msg", msg);
        return "back/addfoods";
    }

    //查询要修改的菜品
    @RequestMapping("/queryfoodById")
    public String queryfoodById(Model model,int fid,int typeid){
        Food food = foodService.queryfoodById(fid);
        List<FoodType> ftlist = foodTypeService.queryAllfoodType();
        model.addAttribute("food", food);
        model.addAttribute("ftlist", ftlist);
        model.addAttribute("typeid", typeid);
        return "back/updatefood";
    }

    //修改菜品信息
    @RequestMapping("/updatefood")
    public String updatefood(HttpServletRequest request, @RequestParam("file") MultipartFile photo, Food food){
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
                food.setPicurl("upload/food/"+filename);
            }
            foodService.updateFood(food);
            msg = "1";
        } catch (Exception e) {
            msg = "0";
        }
        request.setAttribute("msg", msg);
        return "back/updatefood";
    }

    //删除菜品
    @RequestMapping("/deletefoodInfo")
    public String deletefoodInfo(Model model,int fid){
        String msg = null;
        try {
            foodService.deleteFood(fid);
            msg = "1";
        } catch (Exception e) {
            msg = "0";
        }
        model.addAttribute("msg", msg);
        return "back/foodsInfo";
    }

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

}
