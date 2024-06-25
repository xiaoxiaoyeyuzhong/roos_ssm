package com.gec.roos.dao;

import com.gec.roos.pojo.OrderFo;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface OrderFoMapper {

    //批量创建订单项
//    @Insert("<script>insert into orderfo (orderid,fid,number,create_time) " +
//            "values" +
//            "<foreach collection='list' item='item' separator=','>" +
//            "(#{item.orderid},#{item.fid},#{item.number},now())"+
//            "</foreach>"+
//            "</script>")
    void addOrderFos(List<OrderFo> odf);


    //查询
    @Select("SELECT d.number,f.foodName,f.picurl,f.foodPrice "+
            "FROM orderfo d "+
            "LEFT JOIN food f ON(f.fid = d.fid) "+
            "WHERE  d.orderid=#{orderid}")
    @Results({
            @Result(column = "number",property = "number"),
            @Result(column = "foodName",property = "food.foodName"),
            @Result(column = "picurl",property = "food.picurl"),
            @Result(column = "foodPrice",property = "food.foodPrice")
    })
    List<OrderFo> queryOrderFosByOrderid(int orderid);

    //查询订单项记录数
    @Select("select count(id) from orderfo where orderid = #{orderid}")
    int queryOrderFoCount(int orderid);

    //查询当前页订单项数据集合
    @Select("SELECT * FROM orderfo d "+
            "LEFT JOIN food f ON(f.fid = d.fid) "+
            "WHERE  d.orderid=#{orderid} limit #{start},5")
    @Results({
            @Result(column = "orderid",property = "orderid"),
            @Result(column = "number",property = "number"),
            @Result(column = "foodName",property = "food.foodName"),
            @Result(column = "picurl",property = "food.picurl"),
            @Result(column = "foodPrice",property = "food.foodPrice")
    })
    List<OrderFo> queryOrderFosByOrderidAndPage(@Param("orderid") int orderid, @Param("start") int start);
}
