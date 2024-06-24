package com.gec.roos.interceptors;

import com.gec.roos.pojo.Admin;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

//登录拦截器
public class LoginCheckInterceptor extends HandlerInterceptorAdapter {

    //执行controller方法之前处理
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {
        //获取session
        HttpSession session = request.getSession();
        //获取用户登录信息
        Admin admin = (Admin) session.getAttribute("admin");
        System.out.println(admin);
        //用户未登录转入登录页面
        if(admin==null){
            request.getRequestDispatcher("/WEB-INF/view/back/login.jsp").forward(request, response);
            return false;
        }
        //用户已登录放行
        return super.preHandle(request, response, handler);
    }
}
