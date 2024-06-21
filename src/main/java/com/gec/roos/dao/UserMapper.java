package com.gec.roos.dao;

import com.gec.roos.pojo.User;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

public interface  UserMapper {

    @Select("select * from user where openid=#{openid}")
    public void queryMyOrder(String openid);

    //根据openid 查询用户信息
    @Select("select * from user where openid=#{openid}")
    User queryUser(String openid);

    //修改会员积分
    @Update("update user set integral=integral+#{sum} where id =#{id}")
    void updateUserIntegral(@Param("sum") int sum, @Param("id") int id);
}
