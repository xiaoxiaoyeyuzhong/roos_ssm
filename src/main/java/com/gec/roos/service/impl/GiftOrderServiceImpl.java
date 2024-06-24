package com.gec.roos.service.impl;

import com.gec.roos.dao.GiftOrderMapper;
import com.gec.roos.pojo.GiftOrder;
import com.gec.roos.service.GiftOrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class GiftOrderServiceImpl implements GiftOrderService {
    @Autowired
    private GiftOrderMapper giftOrderMapper;


    //添加礼品兑换记录
    @Override
    public void addGiftOrder(GiftOrder giftOrder) {
        giftOrderMapper.addGiftOrder(giftOrder);
    }
}
