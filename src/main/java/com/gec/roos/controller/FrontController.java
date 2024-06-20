package com.gec.roos.controller;

import com.gec.roos.pojo.*;
import com.gec.roos.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
}