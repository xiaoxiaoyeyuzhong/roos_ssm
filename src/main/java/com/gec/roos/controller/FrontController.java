package com.gec.roos.controller;

import com.alipay.api.AlipayApiException;
import com.gec.roos.config.AlipayTemplate;
import com.gec.roos.pojo.*;
import com.gec.roos.service.*;
import com.gec.roos.vo.PayVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
public class FrontController {

    @Autowired
    private FoodTypeService foodTypeService;

    @Autowired
    private CartService cartService;

    @Autowired
    OrderService orderService;

    @Autowired
    private OrderFoService orderFoService;

    @Autowired
    ShopService shopService;

    @Autowired
    private AlipayTemplate alipayTemplate;

    //访问前台首页
    @RequestMapping("/index.html")
    public String openIndex(Model model, String code){
        String openid = "11001";
        //获取用户临时授权码 code到微信服务器换取用户唯一标识openid 略
        model.addAttribute("openid",openid);
        return "front/index";
    }

    //进入菜品区（菜品分类列表）
    @RequestMapping("/opentypeList")
    public String opentypeList(Model model, String openid) {
        // 获取所有的菜品分类名称
        List<FoodType> ftlist = foodTypeService.queryAllfoodType();
        model.addAttribute("ftlist", ftlist);
        model.addAttribute("openid", openid);
        return "front/typelist";
    }

    //根据指定的菜品ID分类进入菜品列表
    @RequestMapping("/openfoodlistById")
    public String openfoodlistById(Model model, String openid, int typeid) {
        //1.根据分类ID查询分类信息
        FoodType ftype = foodTypeService.queryListByfoodTypeId(typeid);
        //2. 获取所有的菜品分类名称 在 footer.jsp页面需要使用
        List<FoodType> ftlist = foodTypeService.queryAllfoodType();
        model.addAttribute("ftlist", ftlist);
        model.addAttribute("openid", openid);
        model.addAttribute("ftype",ftype);
        return "front/foodlist";
    }

    //添加菜品到购物车
    @RequestMapping("/addcart")
    @ResponseBody
    public String addCart(String openid, int fid) {
        Cart cart = new Cart();
        cart.setOpenid(openid);
        cart.setFid(fid);
        String success = null;
        try {
            cartService.addCart(cart);
            success = "ok";
        } catch (Exception e) {
            success = "no";
        }
        return success;
    }

    //查询用户购物车
    @RequestMapping("/queryAllCart")
    public String queryAllCart(Model model, String openid) {
        // 获取所有的菜品分类名称
        List<FoodType> ftlist = foodTypeService.queryAllfoodType();
        //加载购物车信息
        List<Cart> carts = cartService.queryAllCart(openid);
        if(carts.size()==0){
            model.addAttribute("nocart", "0");
        }

        model.addAttribute("ftlist", ftlist);
        model.addAttribute("carts", carts);
        model.addAttribute("openid", openid);
        return "front/shopping";
    }

//    去结算
    @RequestMapping("/newOrder")
    @ResponseBody
    public Map<String,Object> newOrder(@RequestBody Order order){
        String msg = null;
        //响应对象
        Map map=new HashMap<String,Object>();
        try{
            //执行创建订单业务

            int orderid = orderService.newOrder(order);
            map.put("orderid",orderid);
            msg ="ok";
        }catch (Exception e){
            e.printStackTrace();
            msg="no";
        }
        map.put("msg",msg);
        return map;
    }

    //跳转结算页面
    @RequestMapping("/toPayPage")
    public String toPayPage(Model model,String openid,int orderid){
        //总金额
        Double amount =0D;
        //1.获取所有的菜品分类名称
        List<FoodType> ftlist = foodTypeService.queryAllfoodType();

        //2.获取当前的订单信息
        List<OrderFo> orderFos = orderFoService.queryOrderFosByOrderid(orderid);

        //3.获取各个分店名称
        List<Shop> shop = shopService.queryAllShopInfo();

        //计算出总金额
        for (OrderFo odf : orderFos) {
            BigDecimal unitPrice = new BigDecimal(odf.getFood().getFoodPrice());
            amount+=unitPrice.multiply(new BigDecimal(odf.getNumber())).doubleValue();
        }
        model.addAttribute("amount", amount);
        model.addAttribute("orderFos", orderFos);
        model.addAttribute("openid", openid);
        model.addAttribute("orderid", orderid);
        model.addAttribute("ftlist", ftlist);
        model.addAttribute("shop", shop);
        return "front/payer";
    }

    //到店付
    @RequestMapping("/changePaymentState")
    @ResponseBody
    public String changePaymentState(int shopid,String eatdate,String openid,int orderid){
        String success = null;
        //更改订单的付款方式
        try {
            //1.修改订单为到店付 未消费
            //2.删除该用户未确定下的订单
            orderService.payAtStore(shopid,eatdate,openid,orderid);
            //2.删除该用户未确定下的订单
//            orderService.deleteOrderISNULL();
            success="ok";
        } catch (Exception e) {
            e.printStackTrace();
        }
        return success;
    }

    //支付宝生成支付页面
    @RequestMapping(value = "/payOrder")
    public void alipay(HttpServletResponse response, String eatdate, String openid, int orderid, int shopid) throws AlipayApiException {

        Double payAmount =0D;
        //1.计算支付金额
        List<OrderFo> orderFos = orderFoService.queryOrderFosByOrderid(orderid);
        for (OrderFo odf : orderFos) {
            BigDecimal unitPrice = new BigDecimal(odf.getFood().getFoodPrice());
            payAmount+=unitPrice.multiply(new BigDecimal(odf.getNumber())).doubleValue();
        }
        //2.补充支付需要参数调用支付宝模板返回响应 字符串
        PayVo payVo = new PayVo();
        Date currentDate = new Date();
        Long outTradeNo = Long.parseLong(new SimpleDateFormat("yyyyMMddHHmmssSSS").format(currentDate)+new Random().nextInt(10));
        payVo.setOut_trade_no(outTradeNo.toString());
        payVo.setTotal_amount(payAmount.toString());
        payVo.setSubject("湘中阁在线点餐付款");
        payVo.setBody("湘中阁在线点餐付款");
        //用于拼接回调请求参数
        String args ="?eatdate="+eatdate+"&openid="+openid+"&orderid="+orderid+"&shopid="+shopid;
        //请求支付宝生成 支付页面 字符串
        String result = alipayTemplate.pay(payVo, args);
        //由于生成内容为 支付页面的html字符串 需要让页面直接响应成HTML内容
        PrintWriter pw =null;
        //设置响应头 响应内容为 HTML文本内容
        response.setHeader("Content-Type","text/html;charset=UTF-8");
        try {
            pw = response.getWriter();
            pw.write(result);
            pw.flush();
        } catch (IOException e) {
            e.printStackTrace();
        }
        finally {
            pw.close();
        }


    }

    //支付成功后更改订单状态
    @RequestMapping("/paymentSuccessed")
    public String paymentSuccessed(String eatdate, String openid, int orderid, int shopid,PayVo payVo){
        //1.执行支付成功业务
        orderService.paymentSuccessed(eatdate,openid,orderid,shopid,payVo);
        //2.重定向到我的订单请求
        return "redirect:queryMyOrder?openid="+openid;
    }

    //查询看已支付且未消费的订单详情信息
        @RequestMapping("/queryPaidOrderDetail")
    public String queryPaidOrderDetail(HttpServletRequest request, String openid){
        String msg = null;
        // 获取所有的菜品分类名称
        List<FoodType> ftlist = foodTypeService.queryAllfoodType();
        //查询出已支付且未消费的订单信息
        List<Order> orders = orderService.queryPaidOrderDetail(openid);
        if(orders.size()==0){
            msg = "0";
        }
        request.setAttribute("orders", orders);
        request.setAttribute("msg", msg);
        request.setAttribute("openid", openid);
        request.setAttribute("ftlist", ftlist);
        return "front/yizhifu";
    }

    //取消已支付未消费订单
    @RequestMapping("/cancelPaidOrders")
    @ResponseBody
    public String cancelPaidOrders(int orderid){
        String success =null;
        //调用取消订单页面
        try {
            orderService.cancelPaidOrders(orderid);
            success = "1";
        }catch (Exception e){
            e.printStackTrace();
            success = "0";
        }
        return success;
    }

}