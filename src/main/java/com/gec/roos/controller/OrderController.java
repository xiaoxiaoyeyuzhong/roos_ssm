package com.gec.roos.controller;

import com.gec.roos.pojo.Order;
import com.gec.roos.service.OrderFoService;
import com.gec.roos.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;
import java.util.Map;

@Controller
public class OrderController {

    @Autowired
    private OrderService orderService;

    @Autowired
    private OrderFoService orderFoService;

    //进入订单管理中心 根据isexpend状态分页查询订单
    @RequestMapping("/openOrderManager")
    public String openOrderManager(Model model, int page, String isexpend ){

        //1.根据isexpend 设置转发页面
        String returnURL=null;
        if("未消费".equals(isexpend)){
            returnURL ="back/orderManager";
        }else if("已消费".equals(isexpend)){
            returnURL = "back/orderYixiaofei";
        }else{
            returnURL = "back/orderYiquxiao";
        }
        //执行查询业务方法 返回数据map集合
        Map<String,Object> map= orderService.queryOrdersByIsexpend(page,isexpend);
        model.addAttribute("msg",map.get("msg"));
        model.addAttribute("countPage",map.get("countPage"));
        model.addAttribute("orders",map.get("orders"));

        return returnURL;
    }

    // 上一页/下一页 根据未消费/已消费/已取消订单翻页功能
    @RequestMapping("/queryOrdersTurnPagesByIsexpend")
    @ResponseBody
    public List<Order> queryOrdersTurnPagesByIsexpend(int page, String isexpend){

        List<Order> orders = orderService.queryOrdersTurnPagesByIsexpend(page,isexpend);

        return orders;
    }

    //进入订单详情
    @RequestMapping("/openOrderContent")
    public String openOrderContent(Model model, int orderid, int page){
        //执行查询订单详情业务
        Map<String,Object> map =  orderFoService.openOrderContent(orderid,page);

        model.addAttribute("orderFos", map.get("orderFos"));
        model.addAttribute("totalAmount", map.get("totalAmount"));
        model.addAttribute("countPage", map.get("countPage"));
        model.addAttribute("orderid", orderid);
        return "back/orderContent";
    }

    @RequestMapping("/OKOrderState")
    @ResponseBody
    public String OKOrderState(int orderid,String openid){

        //确认消费业务方法
        String success = orderService.OKOrderState(orderid,openid);
        return success;
    }
}

