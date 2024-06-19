package com.gec.roos.controller;

import com.gec.roos.pojo.Admin;
import com.gec.roos.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;

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

    //管理员登录
    @RequestMapping(value = "/adminLogin",method = {RequestMethod.POST})
    public String adminLogin(HttpSession session, Admin admin){
        String url = null;
        int id = adminService.adminLogin(admin);
        if(id>0){
            session.setAttribute("admin", admin);
            session.setMaxInactiveInterval(60*10);
            System.out.println(session.getAttribute("admin"));
            url = "back/index";
        }else{
            url = "back/login";
        }
        return url;
    }

    //退出管理员登录
    @RequestMapping("/exit")
    public String exit(HttpSession httpSession){
        httpSession.removeAttribute("admin");
        httpSession.invalidate();
        return "back/login";
    }

}
