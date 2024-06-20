package com.gec.roos.service;

import com.gec.roos.pojo.OrderFo;

import java.util.List;

public interface OrderFoService {
    //编写根据订单ID查询所有订单项信息
    List<OrderFo> queryOrderFosByOrderid(int orderid);
}
