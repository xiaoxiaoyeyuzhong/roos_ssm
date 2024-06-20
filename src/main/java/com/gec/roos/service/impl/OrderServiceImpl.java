package com.gec.roos.service.impl;

import com.gec.roos.config.AlipayTemplate;
import com.gec.roos.dao.OrderFoMapper;
import com.gec.roos.dao.OrderMapper;
import com.gec.roos.dao.PaymentMapper;
import com.gec.roos.pojo.Order;
import com.gec.roos.pojo.PaymentInfo;
import com.gec.roos.service.OrderService;
import com.gec.roos.vo.PayVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class OrderServiceImpl  implements OrderService {

    @Autowired
    private OrderMapper orderMapper;

    @Autowired
    private OrderFoMapper orderFoMapper;

    @Autowired
    private PaymentMapper paymentMapper;

    @Autowired
    private AlipayTemplate alipayTemplate;

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

    @Override
    public void paymentSuccessed(String eatdate, String openid, int orderid, int shopid, PayVo payVo) {
        //1.修改订单状态
        orderMapper.changeOrderPaymentState(shopid,eatdate,openid,orderid);
        //2.添加订单支付交易流水
        paymentMapper.addPayment(orderid,payVo);
        //3.删除提交的，但未确定下单的订单
        orderMapper.deleteOrderISNULL();
    }

    @Override
    public List<Order> queryPaidOrderDetail(String openid) {
        return orderMapper.queryPaidOrderDetail(openid);
    }

    @Override
    public void cancelPaidOrders(int orderid) throws Exception {
        //1.查询支付流水信息
        PaymentInfo paymentInfo= paymentMapper.queryByOrderId(orderid);
//        System.out.println(paymentInfo);
        //1.申请支付宝退款
        boolean refund = alipayTemplate.refund(paymentInfo);
        if(refund){
            //2.修改订单为已取消
            orderMapper.cancelPaymentAtTheStore(orderid);
            //3.修改支付流水为已退款
            paymentMapper.updatePaymentRefund(paymentInfo.getPaymentid());
        }else{
            throw new RuntimeException("退款失败");
        }
    }
}

