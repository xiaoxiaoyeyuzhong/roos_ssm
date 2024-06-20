package com.gec.roos.service.impl;

import com.gec.roos.dao.OrderFoMapper;
import com.gec.roos.pojo.OrderFo;
import com.gec.roos.service.OrderFoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class OrderFoServiceImpl implements OrderFoService {

    @Autowired
    private OrderFoMapper orderFoMapper;

    @Override
    public List<OrderFo> queryOrderFosByOrderid(int orderid) {
        return orderFoMapper.queryOrderFosByOrderid(orderid);
    }
}
