package com.gec.roos.test;

import com.gec.roos.config.ContextConfig;
import com.gec.roos.pojo.Admin;
import com.gec.roos.service.AdminService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
//加载spring核心配置文件
//@ContextConfiguration(value = {"classpath:applicationContext.xml"})
//加载spring核心配置类
@ContextConfiguration(classes = {ContextConfig.class})
public class SpringJunitTest {
    @Autowired
    private AdminService adminService;


    @Test
    public void testFindById(){
        Admin admin = adminService.findById(1);
        System.out.println(admin);
    }
    @Test
    public void insertBatch(){
        Admin admin = new Admin();
        admin.setPwd("456");
        admin.setUserName("张三");
        int i = adminService.insertBatch(admin);
        System.out.println(i);
    }
}
