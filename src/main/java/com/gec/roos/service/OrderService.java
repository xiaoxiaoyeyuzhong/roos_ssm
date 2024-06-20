package com.gec.roos.service;

import com.gec.roos.pojo.Order;
import com.gec.roos.vo.PayVo;

import java.util.List;

public interface OrderService {
    //创建订单
    int newOrder(Order order);

    //到店付业务
    void payAtStore(int shopid, String eatdate, String openid, int orderid);

    //支付成功业务处理
    void paymentSuccessed(String eatdate, String openid, int orderid, int shopid, PayVo payVo);

    //查询已支付未消费订单
    List<Order> queryPaidOrderDetail(String openid);

    //取消已支付未消费订单
    void cancelPaidOrders(int orderid) throws Exception;
}
