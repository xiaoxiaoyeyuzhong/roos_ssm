package com.gec.roos.dao;

import com.gec.roos.pojo.Order;
import org.apache.ibatis.annotations.*;

import java.util.List;

public interface OrderMapper {
    //创建订单
    @Insert("insert into orders(openid,state,create_time) values(#{openid},\"未支付\",now()) ")
    @Options(useGeneratedKeys = true,keyColumn = "orderid",keyProperty = "orderid")
    void addOrder(Order order);

    @Update("update orders set payment =\"到店付\",shopid= #{shopid},eatdate=#{eatdate},isexpend=\"未消费\",create_time=now()" +
            " where openid=#{openid} and orderid=#{orderid}")
    void updatePaymentState(@Param("shopid") int shopid, @Param("eatdate")String eatdate, @Param("openid")String openid, @Param("orderid")int orderid);

    @Delete("delete o,d from orders o ,orderfo d where o.orderid = d.orderid  and ISNULL(o.isexpend) and ISNULL(o.payment) and ISNULL(o.eatdate)")
    void deleteOrderISNULL();

    //修改支付为已支付
    @Update("update orders set state=\"已支付\",shopid= #{shopid}, eatdate = #{datetime},payment = \"支付宝支付\",isexpend = \"未消费\",create_time=now() where openid=#{openid} and orderid=#{orderid}")
    void changeOrderPaymentState(@Param("shopid")  int shopid,@Param("datetime") String datetime,@Param("openid") String openid,@Param("orderid") int orderid);

    //查询已支付未消费订单
    List<Order> queryPaidOrderDetail(String openid);


//    //取消订单
//    @Update("update orders set state=\"已取消\" where orderid=#{orderid}")
//    void cancelPaymentAtTheStore(int orderid);

    //取消到店付未消费订单
    @Update("update orders set isexpend = \"已取消\",create_time=now() where orderid = #{orderid}")
    void cancelPaymentAtTheStore(int orderid);

    //根据isexpend查询订单数量
    @Select("select count(orderid) from orders  where isexpend=#{isexpend} and !ISNULL(isexpend) and !ISNULL(payment) and !ISNULL(eatdate)")
    int getCountByIsexpend(String isexpend);


    //根据isexpend查询第一页10条订单集合方法
    List<Order> queryOrdersByIsexpendAndPage(@Param("start") int start,@Param("isexpend") String isexpend);

    //修改订单为已消费 已支付
    @Update("update orders set isexpend = \"已消费\",state=\"已支付\" , create_time=now() where orderid = #{orderid}")
    void updateOrderState(int orderid);

    //查询到店付未消费订单
    List<Order> queryPaymentOrderDetail(String openid);
}

