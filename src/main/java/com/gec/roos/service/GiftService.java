package com.gec.roos.service;

import com.gec.roos.pojo.Gift;

import java.util.List;

public interface GiftService {
    //查询所有礼品信息
    List<Gift> queryAllGiftInfo();

    //礼品添加
    void addGiftInfo(Gift gift);
    //根据礼品id查询礼品
    Gift queryGiftInfoById(int pid);
    //修改礼品信息
    void updateGift(Gift gift);
    //通过礼品id删除
    void deleteGiftInfo(int pid);
}
