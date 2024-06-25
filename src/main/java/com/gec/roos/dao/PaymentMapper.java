package com.gec.roos.dao;

import com.gec.roos.pojo.PaymentInfo;
import com.gec.roos.vo.PayVo;
import org.apache.ibatis.annotations.*;

@Mapper
public interface PaymentMapper {
    //添加交易流水
    @Insert("insert into paymentinfo (orderid,outTradeNo,tradeNo,totalAmount,payStatus,createTime,updateTime) " +
            "values(#{orderid},#{payvo.out_trade_no},#{payvo.trade_no},#{payvo.total_amount},\"已支付\",now(),now())")
    void addPayment(@Param("orderid") int orderid, @Param("payvo") PayVo payVo);

    //通过订单id查询支付流水信息
    @Select("select * from paymentinfo where orderid=#{orderid}")
    PaymentInfo queryByOrderId(int orderid);
    //修改支付流水为已退款
    @Update("update paymentinfo set payStatus=\"已退款\" where paymentid=#{paymentid}")
    void updatePaymentRefund(Long paymentid);
}
