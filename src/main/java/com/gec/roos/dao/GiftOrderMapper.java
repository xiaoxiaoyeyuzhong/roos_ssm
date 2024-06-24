package com.gec.roos.dao;

import com.gec.roos.pojo.GiftOrder;
import org.apache.ibatis.annotations.Insert;

import java.util.List;

public interface GiftOrderMapper {

    //添加礼品兑换记录
    @Insert("insert into gift_order (openid,pid,state,createTime) values (#{openid},#{pid},#{state},now())")
    void addGiftOrder(GiftOrder giftOrder);

    //查询会员礼品兑换记录
    List<GiftOrder> queryAll(String openid);
}
