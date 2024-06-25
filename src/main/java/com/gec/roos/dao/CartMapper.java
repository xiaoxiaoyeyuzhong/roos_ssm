package com.gec.roos.dao;

import com.gec.roos.pojo.Cart;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface CartMapper {

    //查询 该用户购物车是否存在菜品
    @Select("select count(id) from cart where openid = #{openid} and fid = #{fid} ")
    int queryCartisExist(Cart cart);

    //添加菜品到购物车
    @Insert("insert into cart (openid,fid,create_time) values(#{openid},#{fid},now())")
    void addCart(Cart cart);

    //查询用户购物车
    List<Cart> queryAllCart(String openid);
}
