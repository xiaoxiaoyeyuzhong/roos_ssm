package com.gec.roos.service.impl;

import com.gec.roos.dao.OrderFoMapper;
import com.gec.roos.dao.OrderMapper;
import com.gec.roos.pojo.OrderFo;
import com.gec.roos.service.OrderFoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class OrderFoServiceImpl implements OrderFoService {

    @Autowired
    private OrderFoMapper orderFoMapper;

    @Autowired
    private OrderMapper orderMapper;

    @Override
    public List<OrderFo> queryOrderFosByOrderid(int orderid) {
        return orderFoMapper.queryOrderFosByOrderid(orderid);
    }

    @Override
    public Map<String, Object> openOrderContent(int orderid, int page) {
        //1.查询该订单项总记录数
        int count = orderFoMapper.queryOrderFoCount(orderid);
        //2.计算总页数
        int countPage = count%5==0? count/5:count/5+1;
        //3.计算查询起始下标
        int start = (page-1)*5;
        //4.查询当前页订单项数据
        List<OrderFo> orderFos = orderFoMapper.queryOrderFosByOrderidAndPage(orderid,start);
        //4.1 计算每个菜品的总金额
        for (OrderFo order : orderFos) {
            order.setSum_money(order.getNumber()*order.getFood().getFoodPrice());
        }
        //5.计算消费总金额
        Double totalAmount =0D;
        //5.1 查询该订单 所有订单项  计算总金额
        List<OrderFo> allOrderFoS = orderFoMapper.queryOrderFosByOrderid(orderid);
        for (OrderFo odf : allOrderFoS) {
            BigDecimal unitPrice = new BigDecimal(odf.getFood().getFoodPrice());
            totalAmount+=unitPrice.multiply(new BigDecimal(odf.getNumber())).doubleValue();
        }

        //6.封装返回数据
        Map<String,Object> map = new HashMap<>();
        map.put("orderFos",orderFos);
        map.put("totalAmount",totalAmount);
        map.put("countPage",countPage);

        return map;
    }
}
