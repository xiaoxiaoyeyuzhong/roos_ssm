package com.gec.roos.service.impl;

import com.gec.roos.dao.GiftMapper;
import com.gec.roos.pojo.Gift;
import com.gec.roos.service.GiftService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class GiftServiceImpl implements GiftService {
    @Autowired
    private GiftMapper giftMapper;

    //查询所有礼品信息
    @Override
    public List<Gift> queryAllGiftInfo() {
        return giftMapper.queryAllGiftInfo();
    }

    //添加礼品
    @Override
    public void addGiftInfo(Gift gift) {
        giftMapper.addGiftInfo(gift);
    }
    //根据礼品id查询礼品
    @Override
    public Gift queryGiftInfoById(int pid) {
        return  giftMapper.queryGiftInfoById(pid);
    }
    //修改礼品
    @Override
    public void updateGift(Gift gift) {
        giftMapper.updateGift(gift);
    }
    //根据礼品id删除
    @Override
    public void deleteGiftInfo(int pid) {
        giftMapper.deleteGiftInfo(pid);
    }
}
