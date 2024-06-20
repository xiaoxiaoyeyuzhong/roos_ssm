package com.gec.roos.pojo;

import java.math.BigDecimal;
import java.util.Date;

/**
 * @author cr
 * @date 2023/3/13
 * @description
 */
//支付流水
public class PaymentInfo {

    // 流水id
    private Long paymentid;
    //  订单id
    private int orderid;
    // 商户订单号
    private String outTradeNo;
    // 支付宝交易号
    private String tradeNo;
    // 付款金额
    private BigDecimal totalAmount;
    //付款状态
    private String payStatus;
    //创建时间
    private Date createTime;
    //更新时间
    private Date updateTime;

    public Long getPaymentid() {
        return paymentid;
    }

    public void setPaymentid(Long paymentid) {
        this.paymentid = paymentid;
    }

    public int getOrderid() {
        return orderid;
    }

    public void setOrderid(int orderid) {
        this.orderid = orderid;
    }

    public String getOutTradeNo() {
        return outTradeNo;
    }

    public void setOutTradeNo(String outTradeNo) {
        this.outTradeNo = outTradeNo;
    }

    public String getTradeNo() {
        return tradeNo;
    }

    public void setTradeNo(String tradeNo) {
        this.tradeNo = tradeNo;
    }

    public BigDecimal getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(BigDecimal totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getPayStatus() {
        return payStatus;
    }

    public void setPayStatus(String payStatus) {
        this.payStatus = payStatus;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Date getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }

    @Override
    public String toString() {
        return "PaymentInfo{" +
                "paymentid=" + paymentid +
                ", orderid=" + orderid +
                ", outTradeNo='" + outTradeNo + '\'' +
                ", tradeNo='" + tradeNo + '\'' +
                ", totalAmount=" + totalAmount +
                ", payStatus='" + payStatus + '\'' +
                ", createTime=" + createTime +
                ", updateTime=" + updateTime +
                '}';
    }
}
