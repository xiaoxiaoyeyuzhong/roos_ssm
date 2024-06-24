package com.gec.roos.service;

import com.gec.roos.pojo.GiftOrder;

import java.util.Map;

public interface GiftOrderService {
    //添加礼品兑换记录
    void addGiftOrder(GiftOrder giftOrder);

    //分页查询以兑换未发货信息
    Map<String, Object> queryUndeliveredGifts(int page);

    //修改订单状态为已兑换
    int updateGiftOrderstate(int id);

    //查询已处理礼品订单
    Map<String, Object> queryDeliveredGiftsByPage(int page);
}
