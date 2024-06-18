package com.gec.roos.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.servlet.config.annotation.DefaultServletHandlerConfigurer;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

@Configuration
@ComponentScan(basePackages = "com.gec.roos")//开启扫描
@EnableWebMvc//开启mvc注解支持
public class SpringmvcConfig implements WebMvcConfigurer {

    //容器管理视图bean
    @Bean
    public InternalResourceViewResolver getResourvler() {
//        return new InternalResourceViewResolver("/WEB-INF/view/", ".jsp");// /WEB-INF/view/fee/fee_list.jsp
        return new InternalResourceViewResolver("/WEB-INF/view/", ".jsp");// /fee/fee_list.jsp
    }
    //配置文件上传解析器
    @Bean(name = "multipartResolver")
    public CommonsMultipartResolver getCommonsMultipartResolver(){
        CommonsMultipartResolver resolver = new CommonsMultipartResolver();
        resolver.setMaxUploadSize(5242880);//最大上传文件为5M
        return resolver;
    }

    //配置默认静态资源放行
    public void configureDefaultServletHandling(DefaultServletHandlerConfigurer configurer) {
        configurer.enable();//放行静态资源
    }
}
