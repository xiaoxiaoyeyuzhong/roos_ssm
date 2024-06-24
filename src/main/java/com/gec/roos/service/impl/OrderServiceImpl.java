package com.gec.roos.service.impl;

import com.gec.roos.config.AlipayTemplate;
import com.gec.roos.dao.OrderFoMapper;
import com.gec.roos.dao.OrderMapper;
import com.gec.roos.dao.PaymentMapper;
import com.gec.roos.dao.UserMapper;
import com.gec.roos.pojo.Order;
import com.gec.roos.pojo.OrderFo;
import com.gec.roos.pojo.PaymentInfo;
import com.gec.roos.pojo.User;
import com.gec.roos.service.OrderService;
import com.gec.roos.vo.PayVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

    @Autowired
    private UserMapper userMapper;

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

    @Override
    public void deleteOrderISNULL() {
        orderMapper.deleteOrderISNULL();
    }

    @Override
    public Map<String, Object> queryOrdersByIsexpend(int page, String isexpend) {
        //1.根据Isexpend查询订单总记录数
        int count = orderMapper.getCountByIsexpend(isexpend);
        //1.1 计算未消费订单总页数 每页显示10条
        int countPage = count%10==0? count/10:count/10+1;

        //查询起始页码
        int start  = (page-1)*10;
        //2.根据isexpend查询第一页10条订单集合
        List<Order> orders = orderMapper.queryOrdersByIsexpendAndPage(start,isexpend);
        String msg =orders.size()+"";
        //3.返回数据封装
        Map<String,Object> map = new HashMap<>();
        map.put("msg",msg);
        map.put("countPage",countPage);
        map.put("orders",orders);
        return map;
    }

    @Override
    public List<Order> queryOrdersTurnPagesByIsexpend(int page, String isexpend) {
        int start = (page-1)*10;
        //使用之前编写好的dao方法
        return orderMapper.queryOrdersByIsexpendAndPage(start,isexpend);
    }

    @Override
    public String OKOrderState(int orderid, String openid) {
        String success = null;

        try {
            //1.修改订单状态 改为已支付 已消费
            orderMapper.updateOrderState(orderid);
            //2.查询用户信息 获取用户积分
            User user = userMapper.queryUser(openid);
            //2.1 判断该用户是否注册会员
            if(user!=null) {
                //3.已注册会员查询 该订单所有订单项积分
                List<OrderFo> orderFos = orderFoMapper.queryOrderFosByOrderid(orderid);
                int sum =0;
                for (OrderFo of : orderFos) {
                    sum += of.getNumber() * of.getFood().getFoodPrice();
                }
                //4.修改该会员积分
                userMapper.updateUserIntegral(sum,user.getId());
            }
            success = "1";
        } catch (Exception e) {
            e.printStackTrace();
            success = "0";
        }
        return success;
    }

    @Override
    public List<Order> queryPaymentOrderDetail(String openid) {
        return orderMapper.queryPaymentOrderDetail(openid);
    }

    @Override
    public void cancelPaymentAtTheStore(int orderid) {
        orderMapper.cancelPaymentAtTheStore(orderid);
    }
}

