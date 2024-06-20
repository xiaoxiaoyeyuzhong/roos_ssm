package com.gec.roos.service.impl;

import com.gec.roos.dao.OrderFoMapper;
import com.gec.roos.dao.OrderMapper;
import com.gec.roos.pojo.Order;
import com.gec.roos.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class OrderServiceImpl  implements OrderService {

    @Autowired
    private OrderMapper orderMapper;

    @Autowired
    private OrderFoMapper orderFoMapper;

    @Override
    public int newOrder(Order order) {
        //1.在orders表创建新订单
        orderMapper.addOrder(order);
        int orderid = order.getOrderid();
        //2.订单项添加 补全orderid字段
        order.getOdf().stream().forEach(item->{
                    item.setOrderid(orderid);
                }
        );
        //3.将菜品订单项保存在orderfo表中
        orderFoMapper.addOrderFos(order.getOdf());
        //4.返回订单id
        return orderid;
    }

    @Override
    public void payAtStore(int shopid, String eatdate, String openid, int orderid) {
        //1.修改订单为到店付 未消费
        orderMapper.updatePaymentState(shopid,eatdate,openid,orderid);
        //2.删除该用户未确定下的订单
        orderMapper.deleteOrderISNULL();
    }
}
