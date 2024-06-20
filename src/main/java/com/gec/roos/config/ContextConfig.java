package com.gec.roos.config;

import com.alibaba.druid.pool.DruidDataSource;
import org.apache.ibatis.logging.log4j2.Log4j2Impl;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import java.io.IOException;
import java.util.Properties;

/*
        整合spring与mybatis
        整合事务

        1.读取配置文件，声明数据源对象
        2.声明配置SqlSessionFactoryBean
        3.声明配置MapperScannerConfigurer
        4.声明配置事务管理器
        5.开启事务注解支持
        6.开启包扫描，扫码服务层
        */
@Configuration
//@PropertySource(encoding = "utf-8",value = "classpath:db.properties")
//开启mapper扫描，自动扫描mapper包下的接口，并且创建代理子类  替代MapperScannerConfigurer
//annotationClass指定注解标记类
@MapperScan(basePackages = {"com.gec.roos.dao"})
@EnableTransactionManagement//开启事务注解支持
@ComponentScan(basePackages = "com.gec.roos.service")
public class ContextConfig {

    //如果Properties文件的属性名命名符合configFromPropety的参数Properties的命名规则，则自动赋值
    @Bean
    public DruidDataSource getDataSource(){
        Properties props = new Properties();
        try {
            props.load(ContextConfig.class.getClassLoader().getResourceAsStream("db.properties"));
            DruidDataSource dataSource = new DruidDataSource();
            dataSource.configFromPropety(props);
            return dataSource;
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }


    //DruidDataSource dataSource：spring容器会自动从自己的bean里面按照类型查找是否存在
    //如果有则注入给改方法参数
    @Bean
    public SqlSessionFactoryBean getFactoryBean(DruidDataSource dataSource) throws IOException {
        SqlSessionFactoryBean factoryBean = new SqlSessionFactoryBean();
        //1.配置数据源
        factoryBean.setDataSource(dataSource);

        //2.配置别名
        factoryBean.setTypeAliasesPackage("com.gec.roos.pojo");

        //3.配置接口映射XML文件路径
        factoryBean.setMapperLocations(new PathMatchingResourcePatternResolver().getResources("classpath:mapper/*.xml"));

        org.apache.ibatis.session.Configuration configuration = new org.apache.ibatis.session.Configuration ();
        configuration.setLogImpl(Log4j2Impl.class);//配置mybatis 日志类

        configuration.setMapUnderscoreToCamelCase(true);//开启支持驼峰命名
        factoryBean.setConfiguration(configuration);
        return factoryBean;

    }

    //创建事务管理器bean
    @Bean
    public DataSourceTransactionManager getTransactionManager(DruidDataSource dataSource){
        return  new DataSourceTransactionManager(dataSource);

    }

    //将AlipayTemplate
    @Bean
    public AlipayTemplate getAlipayTemplate(){
        return  new AlipayTemplate();
    }
}
