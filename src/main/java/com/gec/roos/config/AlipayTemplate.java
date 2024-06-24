package com.gec.roos.config;

import com.alipay.api.AlipayApiException;
import com.alipay.api.AlipayClient;
import com.alipay.api.DefaultAlipayClient;
import com.alipay.api.request.AlipayTradePagePayRequest;
import com.alipay.api.request.AlipayTradeRefundRequest;
import com.alipay.api.response.AlipayTradeRefundResponse;
import com.gec.roos.pojo.PaymentInfo;
import com.gec.roos.vo.PayVo;

public class AlipayTemplate {

    //在支付宝创建的应用的id
    private   String app_id = "9021000138638077";

    // 商户私钥，您的PKCS8格式RSA2私钥
    private  String merchant_private_key = "MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCzc/sBAANPM6+n77HTmpqfvCo/dpVSqyuESMZk6eUjVo5IVQuidffv7Fub+ocE+kzccuuFEMbaZJsSrYz2yM5vHEO+/Uytp60af9uikUD8DN9slFlyoGttWzXB0PLOrgrR+4ZFscMid5dCizxjKVm+rSduO6p34JvqR4ULHBGl0OnLnxP+dSB03DcJXuLZlMy1HVX/fSb/3kxZxZg2ZVDEjtwS5qis2mpJWGR//RkFUS8F2QblEdLAm7Ij9b7LBcQJgZtmhQsu/jVtW2VddIqJfMfjDnejvkrTBeK6OqEEk3ggGbFyXflJziNaoW4lVq5avU6+TnP1EUfOMbiMocTZAgMBAAECggEAZRoz0TVrp+Sr00a0/k29Tb9aYhTyPfgX9Vh3BgXMxeMPGGtpuacTAAY++prkFQbb5NuOG5L/Ja3GvHgw0h0CSRE4jdLxr2inmyVr3aROY3LxMaBG4NDGlX7sw3xwP8dIa1N1K7DiCnosKx588DUszcOKUo2lFhLiZNTUfRTcUHl2LD5V6m2MDSLSJD9ylQm4h2DqqE2bQwP9evmEt/ZsacaBivJqZrsgpRxlH2bwhd24sj9x89cU8/2SQLzDqFIgbDSnFMb8RRZprOdH46A0qQddnXF8YRTv5GWzdwaquN6mGzXYNbF3FKC1RGOczVPcufkmxD3slsBB41zFqPKQsQKBgQD3cxBi2mLuGxIKZ7WLbdSjv1PPG2ga+ARFPykmMdJ3oKhCpNOKyY7cnNIqKJrSDeG5GWbKyaej1J9TScWUGD1S+oHawP+3LTNC2yaUbPRD2Jmx4YWKjTytLDI2V3JwmtLMllyVkHqaeIIZoZ+YCmkflMvAa9p43pdgaWhbujtLRQKBgQC5p2uywEa034q2I92c+Q6dJDsKGJm5/3euhE2WbbBqlGbe+an/cw+1hnBthlRD867JM0T3MAjI+S7rfHaJm761gJZphOYhmBiYgvzoNyFkK4DNIYLBtX4irfNBd/ZjQ/aa0Ncs5mducdcUfxY52w2oosAxO3NJ5PytHx2fl4qihQKBgDm/6eAYNaR6PuCcyZrLvCenHGkmbUp1/ZEnp3PZhtQSc5JyI0itt6C3HLloFpHVWYu4aOwE2hH7Kl/mxKzGZ3F5M1sZVdSrQN5mhP942h0HbP89scvfIH0N5n4WNIghKfdDVEI3oNVyMHLI7JUwQM51DIRQ54Dz+gIvN4LI2NO9AoGAGK6qgdxQSjHCFk8UYo82Iywy8TeuEG1ncvtB+XLh1nmeZ5yXvk+E0iRqhBUs1M/r9/HqBFcNg/KlC0fD1q2vICBVXvf9RJAdDQG1MAZMWS3zdNI0uR4xA9lOkvCpAC+D9Lc5NE35iFR4PNBcmxqFaVsh5Cm8PSHFehq97H7QPqUCgYEA64JrgUw7KKjB4utYtoLzfu4QCyJQvRd2gos9HMv3MdcroRJAezZ1F3D6qiFQmwC18T9UOQlR/WjoA/+YhC5c2Ff9fI7gafHJXCDeY5mx3UTOt150zQ+3sBedGAjGMLjYYDsult1L57/THJGbdHHFpato7wTfAg5gs3ce/dPqTWE=";
    // 支付宝公钥,查看地址：https://openhome.alipay.com/platform/keyManage.htm 对应APPID下的支付宝公钥。
    private  String alipay_public_key = "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAjXyq1N3+HS2t0Ppfa/aA96UcwgSmKeGqGFuKqmjqf4++8/750xOnuMugK5cWd7kGZPV4nGEG0vmuEDAkdiCYW9G7E5lknIalOolvJH3r6PmyEIIcLqnYlduQsTtdPfr5+MHxv+ZLEPUSBCYaNefpFZscW/LQ1GmiEVXrtGuyb9svG2sX5UTSMqcNuosmclacsxJJOGzM+ty2iQEqxKQ0b6l25ci7r8I3CjE6VaGSQCMv8FdGC8Mhy0B6V9Xct3/+7cuJDhr6db3QxgmfG1jvcid5shlQpuaT2GTg1OWSjw48+BMq+GQmrWUjFF+94pFDDO2Uqkzc/fqu8ZhrtQlLZwIDAQAB";
    // 服务器[异步通知]页面路径  需http://格式的完整路径，不能加?id=123这类自定义参数，必须外网可以正常访问
    // 支付宝会悄悄的给我们发送一个请求，告诉我们支付成功的信息
    private  String notify_url;

    //同步通知，支付成功，一般跳转到成功页
    private  String return_url="http://localhost:8888/roos_ssm/paymentSuccessed";

    // 签名方式
    private  String sign_type = "RSA2";

    // 字符编码格式
    private  String charset = "utf-8";

    // 支付宝网关； https://openapi.alipaydev.com/gateway.do
    private  String gatewayUrl = "https://openapi-sandbox.dl.alipaydev.com/gateway.do";

    public  String pay(PayVo vo, String args) throws AlipayApiException {

        //AlipayClient alipayClient = new DefaultAlipayClient(AlipayTemplate.gatewayUrl, AlipayTemplate.app_id, AlipayTemplate.merchant_private_key, "json", AlipayTemplate.charset, AlipayTemplate.alipay_public_key, AlipayTemplate.sign_type);
        //1、根据支付宝的配置生成一个支付客户端
        AlipayClient alipayClient = new DefaultAlipayClient(gatewayUrl,
                app_id, merchant_private_key, "json",
                charset, alipay_public_key, sign_type);

        //2、创建一个支付请求 //设置请求参数
        AlipayTradePagePayRequest alipayRequest = new AlipayTradePagePayRequest();
        alipayRequest.setReturnUrl(return_url+args);
        alipayRequest.setNotifyUrl(notify_url);

        //商户订单号，商户网站订单系统中唯一订单号，必填
        String out_trade_no = vo.getOut_trade_no();
        //付款金额，必填
        String total_amount = vo.getTotal_amount();
        //订单名称，必填
        String subject = vo.getSubject();
        //商品描述，可空
        String body = vo.getBody();

        alipayRequest.setBizContent("{\"out_trade_no\":\""+ out_trade_no +"\","
                + "\"total_amount\":\""+ total_amount +"\","
                + "\"subject\":\""+ subject +"\","
                + "\"body\":\""+ body +"\","
                + "\"product_code\":\"FAST_INSTANT_TRADE_PAY\"}");

        String result = alipayClient.pageExecute(alipayRequest).getBody();

        //会收到支付宝的响应，响应的是一个页面，只要浏览器显示这个页面，就会自动来到支付宝的收银台页面
        System.out.println("支付宝的响应："+result);
        return result;
    }

    //退款方法
    public boolean refund(PaymentInfo paymentInfo) throws AlipayApiException {
        //1、根据支付宝的配置生成一个支付客户端
        AlipayClient alipayClient = new DefaultAlipayClient(gatewayUrl,
                app_id, merchant_private_key, "json",
                charset, alipay_public_key, sign_type);

        //2、创建一个退款请求 注意这里与之前支付创建对象不一样
        AlipayTradeRefundRequest alipayRequest = new AlipayTradeRefundRequest();

        alipayRequest.setBizContent("{\"out_trade_no\":\""+ paymentInfo.getOutTradeNo() +"\","
                + "\"trade_no\":\""+ paymentInfo.getTradeNo() +"\","
                + "\"refund_amount\":\""+ paymentInfo.getTotalAmount() +"\"," // 设置退款金额
                + "\"refund_reason\":\""+"申请退款"+"\","
                + "\"out_request_no\":\"\"}");
        //执行退款 返回响应
        AlipayTradeRefundResponse response = alipayClient.execute(alipayRequest);
        //查看响应字符串
        System.out.println(response.getBody());
        //返回是否 退款成功
        return response.isSuccess();
    }

    public  String recharge(PayVo vo,String args) throws AlipayApiException {

        //1、根据支付宝的配置生成一个支付客户端
        AlipayClient alipayClient = new DefaultAlipayClient(gatewayUrl,
                app_id, merchant_private_key, "json",
                charset, alipay_public_key, sign_type);

        //2、创建一个支付请求 //设置请求参数
        AlipayTradePagePayRequest alipayRequest = new AlipayTradePagePayRequest();
        //2.1 修改同步跳转路径为会员充值成功 请求
        return_url="http://localhost:8888/roos_ssm/rechargeSuccessed";
        alipayRequest.setReturnUrl(return_url+args);
        alipayRequest.setNotifyUrl(notify_url);
        //商户订单号，商户网站订单系统中唯一订单号，必填
        String out_trade_no = vo.getOut_trade_no();
        //付款金额，必填
        String total_amount = vo.getTotal_amount();
        //订单名称，必填
        String subject = vo.getSubject();
        //商品描述，可空
        String body = vo.getBody();

        alipayRequest.setBizContent("{\"out_trade_no\":\""+ out_trade_no +"\","
                + "\"total_amount\":\""+ total_amount +"\","
                + "\"subject\":\""+ subject +"\","
                + "\"body\":\""+ body +"\","
                + "\"product_code\":\"FAST_INSTANT_TRADE_PAY\"}");

        String result = alipayClient.pageExecute(alipayRequest).getBody();

        //会收到支付宝的响应，响应的是一个页面，只要浏览器显示这个页面，就会自动来到支付宝的收银台页面
        System.out.println("支付宝的响应："+result);
        return result;
    }

    //支付运费
    public  String payPostage(PayVo vo,String args) throws AlipayApiException {

        //1、根据支付宝的配置生成一个支付客户端
        AlipayClient alipayClient = new DefaultAlipayClient(gatewayUrl,
                app_id, merchant_private_key, "json",
                charset, alipay_public_key, sign_type);

        //2、创建一个支付请求 //设置请求参数
        AlipayTradePagePayRequest alipayRequest = new AlipayTradePagePayRequest();
        alipayRequest.setReturnUrl("http://localhost:8888/roos_ssm/postagePaymentSuccessed"+args);
        alipayRequest.setNotifyUrl(notify_url);

        //商户订单号，商户网站订单系统中唯一订单号，必填
        String out_trade_no = vo.getOut_trade_no();
        //付款金额，必填
        String total_amount = vo.getTotal_amount();
        //订单名称，必填
        String subject = vo.getSubject();
        //商品描述，可空
        String body = vo.getBody();

        alipayRequest.setBizContent("{\"out_trade_no\":\""+ out_trade_no +"\","
                + "\"total_amount\":\""+ total_amount +"\","
                + "\"subject\":\""+ subject +"\","
                + "\"body\":\""+ body +"\","
                + "\"product_code\":\"FAST_INSTANT_TRADE_PAY\"}");

        String result = alipayClient.pageExecute(alipayRequest).getBody();
        //会收到支付宝的响应，响应的是一个页面，只要浏览器显示这个页面，就会自动来到支付宝的收银台页面
        System.out.println("支付宝的响应："+result);
        return result;
    }

}
