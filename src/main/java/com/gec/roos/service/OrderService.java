package com.gec.roos.service;

import com.gec.roos.pojo.Order;
import com.gec.roos.vo.PayVo;

import java.util.List;
import java.util.Map;

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

    //删除提交的，但未确定下单的订单
    void deleteOrderISNULL();

    //根据 订单状态分页查询
    Map<String, Object> queryOrdersByIsexpend(int page, String isexpend);

    //上一页/下一页 根据未消费/已消费/已取消订单翻页功能
    List<Order> queryOrdersTurnPagesByIsexpend(int page, String isexpend);

    //订单确认消费
    String OKOrderState(int orderid, String openid);
}
