package com.gec.roos.service;

import com.gec.roos.pojo.Order;

public interface OrderService {
    //创建订单
    int newOrder(Order order);

    //到店付业务
    void payAtStore(int shopid, String eatdate, String openid, int orderid);
}
