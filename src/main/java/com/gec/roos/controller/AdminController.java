package com.gec.roos.controller;

import com.gec.roos.pojo.Admin;
import com.gec.roos.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class AdminController {
    @Autowired
    private AdminService adminService;

    @RequestMapping("/admin/findById")
    @ResponseBody
    public Admin findById(Integer id){
        return adminService.findById(id);
    }

    //访问后台管理员登录
    @RequestMapping("/admin.html")
    public String openAdmin(){
        return "back/login";
    }
}
