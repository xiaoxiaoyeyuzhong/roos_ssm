package com.gec.roos.dao;

import com.gec.roos.pojo.Order;
import org.apache.ibatis.annotations.*;

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
}

