package com.gec.roos.controller;

import com.alipay.api.AlipayApiException;
import com.gec.roos.config.AlipayTemplate;
import com.gec.roos.pojo.FoodType;
import com.gec.roos.pojo.Note;
import com.gec.roos.pojo.User;
import com.gec.roos.service.FoodTypeService;
import com.gec.roos.service.UserService;
import com.gec.roos.vo.PayVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Random;

@Controller
public class UserController {

    @Autowired
    private UserService userService;

    @Autowired
    private FoodTypeService foodTypeService;

    @Autowired
    private AlipayTemplate alipayTemplate;

    @RequestMapping("/queryUserInfo")
    public String queryUserInfo(Model model, String openid){
        String msg = null;
        //通过openid查询用户
        User user = userService.queryUser(openid);
        if(user==null){
            msg = "0";
        }
        model.addAttribute("msg",msg);
        model.addAttribute("user",user);
        return "back/userInfo";
    }

    //进入会员卡中心
    @RequestMapping("/openmember")
    public String openmember(Model model, String openid) {
        String url = null;
        // 获取所有的菜品分类名称
        List<FoodType> ftlist = foodTypeService.queryAllfoodType();
        // 判断当前用户是否是会员
        User user = userService.queryUser(openid);
        if (user == null) {
            model.addAttribute("msg", "0");
            url = "front/register";
        } else {

            model.addAttribute("user",user);
            url = "front/card";
        }
        model.addAttribute("ftlist", ftlist);
        model.addAttribute("openid", openid);
        return url;
    }

    //用户注册会员
    @RequestMapping("/regMember")
    public String regMember(HttpServletRequest request, User user) {
        String msg = null;
        int rs = userService.regMember(user);
        if(rs>0){
            msg = "1";
        }else{
            msg = "0";
        }
        request.setAttribute("msg", msg);
        request.setAttribute("openid", user.getOpenid());
        return "front/register";
    }

    //进入充值页面
    @RequestMapping("/toRecharge")
    public String toRecharge(Model model,String openid){
        model.addAttribute("openid", openid);
        return "front/torecharge";
    }

    //生成支付宝充值页面
    @RequestMapping(value = "/recharge")
    public void alipay(HttpServletResponse response, int amount, String openid ) throws AlipayApiException {


        //1.补充支付需要参数调用支付宝模板返回响应 字符串
        PayVo payVo = new PayVo();
        Date currentDate = new Date();
        Long outTradeNo = Long.parseLong(new SimpleDateFormat("yyyyMMddHHmmssSSS").format(currentDate)+new Random().nextInt(10));
        payVo.setOut_trade_no(outTradeNo.toString());
        payVo.setTotal_amount(amount+"");
        payVo.setSubject("会员充值");
        payVo.setBody("会员充值");
        //用于拼接回调请求参数
        String args ="?openid="+openid;
        //请求支付宝生成 支付页面 字符串
        String result = alipayTemplate.recharge(payVo, args);
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
    @RequestMapping("/rechargeSuccessed")
    public String rechargeSuccessed( String openid,PayVo payVo){
//        System.out.println("最后金额是"+payVo.getTotal_amount());
        //1.执行支付成功业务
        userService.rechargeSuccessed(openid,payVo);
        //2.重定向到我的订单请求
        return "redirect:openmember?openid="+openid;
    }

    //打开余额消费中心
    @RequestMapping("/openconsume")
    public String openxiaofei(HttpServletRequest request,String openid){
        //查出当前用的账户余额
        User user = userService.queryUser(openid);
        request.setAttribute("amount", user.getAmount());
        request.setAttribute("openid", openid);
        return "front/xiaofei";
    }

    //弹出密码输入框
    @RequestMapping("/gopasswordbox")
    public String gopasswordbox(Model model,String openid,int amount){

        model.addAttribute("openid", openid);
        model.addAttribute("amount", amount);
        return "front/password";
    }

    //提交密码并完成支付结账
    @RequestMapping("/submitPwd")
    @ResponseBody
    public String submitPwd(String openid,int amount,String pwd){
        String data = userService.submitPwd(openid,amount,pwd);
        return data;
    }

    //查看我的最新10条账单记录
    @RequestMapping("/findMyNote")
    public String findMyNote(HttpServletRequest request,String openid){
        //查询我的5条账单记录
        List<Note> notes = userService.queryMyNote(openid);
        if(notes.size()==0){
            request.setAttribute("len", "0");
        }
        request.setAttribute("notes", notes);
        request.setAttribute("openid", openid);
        return "front/mynote";
    }


    //查看所有的账单记录
    @RequestMapping("/findAllNote")
    public String findAllNote(Model model, String openid){
        //查询所有账单记录 为了方便写在了UserService中
        List<Note> notes = userService.queryAllMyNote(openid);

        model.addAttribute("notes", notes);
        model.addAttribute("openid", openid);
        model.addAttribute("msg", "ok");
        return "front/mynote";
    }

    //分页条件查询会员信息
    @RequestMapping("/queryMemberByPageAndPhone")
    public String queryMemberByPageAndPhone(Model model , @RequestParam("page") int page ,
                                            @RequestParam(value = "phone",required = false) String phone){
        //调用查询接口
        Map<String,Object> map = userService.queryMemberByPageAndPhone(page,phone);

        model.addAttribute("msg",map.get("msg"));
        model.addAttribute("users",map.get("users"));
        model.addAttribute("countPage",map.get("countPage"));
        model.addAttribute("count",map.get("count"));

        model.addAttribute("phone",phone);
        return "back/member";
    }

    //分页条件查询会员信息
    @RequestMapping("/queryMemberByPage")
    @ResponseBody
    public List<User> queryMemberByPage(Model model , @RequestParam("page") int page ){
        //调用查询接口
        List<User>  users= userService.queryMemberByPage(page);
        return users;
    }

    //打开修改用户名页面
    @RequestMapping("/openUpdateUserName")
    public String openUpdateUserName(HttpServletRequest request, String openid) {
        String msg = null;
        //通过openid查询用户
        User user = userService.queryUser(openid);
        if(user==null){
            msg = "0";
        }
        request.setAttribute("msg",msg);
        request.setAttribute("user",user);
        request.setAttribute("openid",openid);
        return "front/xiugaiyonghuming";
    }

    //修改用户名
    @RequestMapping("/updateUserName")
    public String updateUserName(Model model,String openid,User user) {
        String data = null;
        user.setOpenid(openid);
        userService.updateUserName(user);
        data = "1";
        model.addAttribute("data",data);
        model.addAttribute("openid",openid);

        return "front/xiugaiyonghuming";
    }

    //进入修改密码页面
    @RequestMapping("/openUpdatePwd")
    public String openUpdatePwd(Model model, String openid) {
        String url = null;

        User user = userService.queryUser(openid);
        if (user == null) {
            model.addAttribute("msg", "0");
            url = "front/register";
        } else {
            model.addAttribute("user",user);
            url = "front/xiugaimima";
        }
        model.addAttribute("openid", openid);

        return url;
    }

    //修改密码
    @RequestMapping("/updatePwd")
    @ResponseBody
    public String updatePwd(HttpServletRequest request, String openid,User user)
    {
        String data = null;
        User user1 = userService.queryUser(openid);
        if(user1 != null){
            boolean flag = user1.getPhone().equals(user.getPhone());
            if(flag){
                userService.updatePassword(user);
                data = "1";
            }else {
                data = "-1";
            }
        }
        return data ;
    }

}