package com.gec.roos.dao;

import com.gec.roos.pojo.GiftOrder;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.List;

public interface GiftOrderMapper {

    //添加礼品兑换记录
    @Insert("insert into gift_order (openid,pid,state,createTime) values (#{openid},#{pid},#{state},now())")
    void addGiftOrder(GiftOrder giftOrder);

    //查询会员礼品兑换记录
    List<GiftOrder> queryAll(String openid);

    //获取已兑换未发货总记录数
    @Select("select count(id) from gift_order where state!='已兑换'")
    int queryUndeliveredGiftsCount();

    //分页查询已兑换未发货数据集合
    List<GiftOrder> queryUndeliveredGiftsByPage(int start);

    //修改礼品兑换状态为 已兑换
    @Update("update gift_order set state='已兑换',createTime=now() where id = #{id}")
    int updateGiftOrderstate(int id);

    //获取已兑换订单总数
    @Select("select count(id) from gift_order where state ='已兑换'")
    int queryDeliveredGiftsCount();

    //分页查询
//    @Select("select * from gift_order o join gift g ON o.pid=g.pid " +
//            "where o.state = '已兑换' order by o.createTime desc limit #{page},8")
//    分页查询已处理礼品订单集合
    List<GiftOrder> queryDeliveredGiftsByPage(int page);
}
