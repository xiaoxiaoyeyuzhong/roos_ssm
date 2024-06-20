package com.gec.roos.vo;

public class PayVo {
    private String out_trade_no; // 商户订单号 必填
    private String trade_no; //交易号
    private String subject; // 订单名称 必填
    private String total_amount;  // 付款金额 必填
    private String body; // 商品描述 可空

    public String getOut_trade_no() {
        return out_trade_no;
    }

    public void setOut_trade_no(String out_trade_no) {
        this.out_trade_no = out_trade_no;
    }

    public String getTrade_no() {
        return trade_no;
    }

    public void setTrade_no(String trade_no) {
        this.trade_no = trade_no;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public String getTotal_amount() {
        return total_amount;
    }

    public void setTotal_amount(String total_amount) {
        this.total_amount = total_amount;
    }

    public String getBody() {
        return body;
    }

    public void setBody(String body) {
        this.body = body;
    }

    @Override
    public String toString() {
        return "PayVo{" +
                "out_trade_no='" + out_trade_no + '\'' +
                ", trade_no='" + trade_no + '\'' +
                ", subject='" + subject + '\'' +
                ", total_amount='" + total_amount + '\'' +
                ", body='" + body + '\'' +
                '}';
    }
}
