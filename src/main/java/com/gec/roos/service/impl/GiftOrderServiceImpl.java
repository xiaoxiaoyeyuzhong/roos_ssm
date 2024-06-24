package com.gec.roos.service.impl;

import com.gec.roos.dao.GiftOrderMapper;
import com.gec.roos.pojo.GiftOrder;
import com.gec.roos.service.GiftOrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class GiftOrderServiceImpl implements GiftOrderService {
    @Autowired
    private GiftOrderMapper giftOrderMapper;


    //添加礼品兑换记录
    @Override
    public void addGiftOrder(GiftOrder giftOrder) {
        giftOrderMapper.addGiftOrder(giftOrder);
    }


    //分页查询已兑换未发货信息
    @Override
    public Map<String, Object> queryUndeliveredGifts(int page) {

        Map<String ,Object> map = new HashMap<>();
        //获取已兑换未发货总记录数
        int count = giftOrderMapper.queryUndeliveredGiftsCount();
        int countPage = count%8==0? count/8:count/8+1;//每页显示8条
        //计算查询起始页
        int start = (page-1)*8;
        //分页查询已兑换未发货数据集合
        List<GiftOrder> giftorder = giftOrderMapper.queryUndeliveredGiftsByPage(start);
        if(giftorder.size()==0){
            map.put("giftordersize","0");
        }
        map.put("countPage",countPage);
        map.put("giftorder",giftorder);
        return map;
    }

    //修改订单状态为已兑换
    @Override
    public int updateGiftOrderstate(int id) {
        return giftOrderMapper.updateGiftOrderstate(id);
    }

    @Override
    public Map<String, Object> queryDeliveredGiftsByPage(int page) {

        Map<String,Object> map = new HashMap<>();

        //获取已兑换订单总数
        int count = giftOrderMapper.queryDeliveredGiftsCount();
        int countPage = count%8==0?count/8:count/8+1;
        //获取最新8条已处理的订单
        int start  = (page-1)*8;
        List<GiftOrder> giftOrders = giftOrderMapper.queryDeliveredGiftsByPage(page);
        if(giftOrders.size()==0){
            map.put("size","0");
        }
        map.put("countPage",countPage);
        map.put("giftorder",giftOrders);
        return map;
    }

}
