package com.gec.roos.controller;

import com.gec.roos.pojo.Gift;
import com.gec.roos.service.GiftService;
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
public class GiftController {

    @Autowired
    private GiftService giftService;
    //查询所有礼品信息
    @RequestMapping("queryAllgift")
    public String queryAllgift(Model model){
        List<Gift> gifts = giftService.queryAllGiftInfo();
        model.addAttribute("gifts", gifts);
        return "back/giftInfo";
    }

    //跳转到添加页面
    @RequestMapping("/opengift")
    public String opengift(){
        return "back/addgift";
    }

    //添加礼品信息
    @RequestMapping("/addgiftinfo")
    public String addgiftinfo(HttpServletRequest request, @RequestParam("file") MultipartFile photo, Gift gift){
        String msg = null;
        //获取文件名称
        String filename = photo.getOriginalFilename();
        // 文件上传的路径
        String path =  request.getSession().getServletContext().getRealPath("/upload/gift");
        try {

            assert filename != null;
            File file = new File(path, filename);
            //完成文件上传
            photo.transferTo(file);
            //设置图片路径
            gift.setImgurl("upload/gift/"+filename);
            //添加礼品
            giftService.addGiftInfo(gift);
            msg = "1";
        } catch (Exception e) {
            msg = "0";
        }
        request.setAttribute("msg", msg);
        return "back/addgift";
    }

    //根据pid查询礼品信息
    @RequestMapping("/querygiftById")
    public String querygiftByID(Model model,int pid){
        Gift gift = giftService.queryGiftInfoById(pid);
        model.addAttribute("gift", gift);
        return "back/updategift";
    }
    //修改礼品信息
    @RequestMapping("/updateGiftInfo")
    public String updateGift(HttpServletRequest request, @RequestParam("file") MultipartFile photo, Gift gift){
        System.out.println("为啥修改失败,gift="+gift.toString());
        String msg = null;
        // 文件上传的路径
        String path = request.getSession().getServletContext().getRealPath("/upload/gift");

        try {
            // 检查用户是否上传了新图片
            if (photo != null && !photo.isEmpty()) {
                // 获取文件名称
                String filename = photo.getOriginalFilename();
                assert filename != null;
                File file = new File(path, filename);
                // 完成文件上传
                photo.transferTo(file);
                // 设置新图片路径
                gift.setImgurl("upload/gift/" + filename);
            }
            System.out.println("为啥修改失败,gift="+gift.toString());
            //修改礼品
            giftService.updateGift(gift);
            msg = "1";
        } catch (Exception e) {
            msg = "0";
        }
        request.setAttribute("msg", msg);
        return "back/updategift";
    }

    //删除礼品信息
    @RequestMapping("/deleteGiftInfo")
    public String deleteGiftInfo(Model model, int pid){
        String msg = null;
        try {
            giftService.deleteGiftInfo(pid);
            msg = "1";
        } catch (Exception e) {
            msg = "0";
        }
        model.addAttribute("msg", msg);
        return "back/giftInfo";
    }
}