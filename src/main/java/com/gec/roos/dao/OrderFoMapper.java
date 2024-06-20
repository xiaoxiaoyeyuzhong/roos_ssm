package com.gec.roos.dao;

import com.gec.roos.pojo.OrderFo;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Result;
import org.apache.ibatis.annotations.Results;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface OrderFoMapper {

    //批量创建订单项
    @Insert("<script>insert into orderfo (orderid,fid,number,create_time) " +
            "values" +
            "<foreach collection='list' item='item' separator=','>" +
            "(#{item.orderid},#{item.fid},#{item.number},now())"+
            "</foreach>"+
            "</script>")
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
}
