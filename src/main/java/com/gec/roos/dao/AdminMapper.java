package com.gec.roos.dao;

import com.gec.roos.pojo.Admin;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
//Admin Dao 接口 可使用 注解方式直接编写SQL 以及XML 配置方式

@Mapper
public interface AdminMapper {
    @Select("select * from admin where id=#{id}")
    Admin findById(Integer id);

    int insert(Admin admin);

    @Select("select count(id) from admin where userName=#{userName} and pwd = #{pwd}")
    int adminLogin(Admin admin);
}
