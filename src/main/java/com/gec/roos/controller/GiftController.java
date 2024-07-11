package com.gec.roos.controller;

import com.gec.roos.pojo.Gift;
import com.gec.roos.pojo.GiftOrder;
import com.gec.roos.pojo.User;
import com.gec.roos.service.GiftOrderService;
import com.gec.roos.service.GiftService;
import com.gec.roos.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

@Controller
public class GiftController {

    @Autowired
    private GiftService giftService;

    @Autowired
    private UserService userService;

    @Autowired
    private GiftOrderService giftOrderService;

    //查询所有礼品信息
    @RequestMapping("queryAllgift")
    public String queryAllgift(Model model){
        List<Gift> gifts = giftService.queryAllGiftInfo();
        model.addAttribute("gifts", gifts);
        return "back/giftInfo";
    }

    //跳转到添加页面
    @RequestMapping("/opengift")
    public String opengift(){
        return "back/addgift";
    }

    //添加礼品信息
    @RequestMapping("/addgiftinfo")
    public String addgiftinfo(HttpServletRequest request, @RequestParam("file") MultipartFile photo, Gift gift){
        String msg = null;
        //获取文件名称
        String filename = photo.getOriginalFilename();
        // 文件上传的路径
        String path =  request.getSession().getServletContext().getRealPath("/upload/gift");
        try {

            assert filename != null;
            File file = new File(path, filename);
            //完成文件上传
            photo.transferTo(file);
            //设置图片路径
            gift.setImgurl("upload/gift/"+filename);
            //添加礼品
            giftService.addGiftInfo(gift);
            msg = "1";
        } catch (Exception e) {
            msg = "0";
        }
        request.setAttribute("msg", msg);
        return "back/addgift";
    }

    //根据pid查询礼品信息
    @RequestMapping("/querygiftById")
    public String querygiftByID(Model model,int pid){
        Gift gift = giftService.queryGiftInfoById(pid);
        model.addAttribute("gift", gift);
        return "back/updategift";
    }
    //修改礼品信息
    @RequestMapping("/updateGiftInfo")
    public String updateGift(HttpServletRequest request, @RequestParam("file") MultipartFile photo, Gift gift){
        System.out.println("为啥修改失败,gift="+gift.toString());
        String msg = null;
        // 文件上传的路径
        String path = request.getSession().getServletContext().getRealPath("/upload/gift");

        try {
            // 检查用户是否上传了新图片
            if (photo != null && !photo.isEmpty()) {
                // 获取文件名称
                String filename = photo.getOriginalFilename();
                assert filename != null;
                File file = new File(path, filename);
                // 完成文件上传
                photo.transferTo(file);
                // 设置新图片路径
                gift.setImgurl("upload/gift/" + filename);
            }
            System.out.println("为啥修改失败,gift="+gift.toString());
            //修改礼品
            giftService.updateGift(gift);
            msg = "1";
        } catch (Exception e) {
            msg = "0";
        }
        request.setAttribute("msg", msg);
        return "back/updategift";
    }

    //删除礼品信息
    @RequestMapping("/deleteGiftInfo")
    public String deleteGiftInfo(Model model, int pid){
        String msg = null;
        try {
            giftService.deleteGiftInfo(pid);
            msg = "1";
        } catch (Exception e) {
            msg = "0";
        }
        model.addAttribute("msg", msg);
        return "back/giftInfo";
    }

    //线下兑换礼品
    //管理员直接在后台输入兑换积分数兑换
    @RequestMapping("/userUpdateIntegral")
    @ResponseBody
    public String userUpdateIntegral(int integral,String openid){
        String success = null;
        User user = userService.queryUser(openid);
        int jifei = user.getIntegral();
        //会员积分大于礼品所扣积分
        if(jifei>=integral){
            //将扣减积分变为负数
            BigDecimal bigDecimal = new BigDecimal(integral);
            integral = bigDecimal.negate().intValue();
            int i = userService.updateUserIntegralByopenid(integral, openid);
            if(i>0){
                success="ok";
            }else{
                success="no";//兑换失败
            }
        }else{
            //积分不足
            success="0";
        }
        return success;
    }

    //查询已兑换未发货礼品信息
    @RequestMapping("/queryUndeliveredGifts")
    public String queryUndeliveredGifts(Model model,int page){
        //分页查询已兑换未发货礼品信息
        Map<String,Object> map  = giftOrderService.queryUndeliveredGifts(page);

        model.addAttribute("countPage",map.get("countPage"));
        model.addAttribute("giftorder",map.get("giftorder"));
        model.addAttribute("giftordersize  ",map.get("giftordersize  "));
        return "back/undeliveredGifts";
    }

    //更改礼品订单状态
    @RequestMapping("/updateGiftOrderstate")
    public String updateGiftOrderstate(Model model,int id){
        int result = giftOrderService.updateGiftOrderstate(id);
        if(result>0){
            model.addAttribute("ok", "ok");
        }
        return "back/undeliveredGifts";
    }

    //查询已处理礼品订单
    @RequestMapping("/queryDeliveredGifts")
    public String queryDeliveredGifts(Model model,int page){

        Map<String,Object> map= giftOrderService.queryDeliveredGiftsByPage(page);

        model.addAttribute("countPage", map.get("countPage"));
        model.addAttribute("giftorder", map.get("giftorder"));
        model.addAttribute("y",map.get("y"));
        return "back/deliveredGifts";
    }

    //分页查询已提交待发货礼品订单
    @RequestMapping("/querylipinOrderPage")
    @ResponseBody
    public List<GiftOrder> querylipinOrderPage(int page){
        return giftOrderService.querylipinOrderPage(page);
    }

    //分页查询已处理礼品订单
    @RequestMapping("querylipinyichuliOrderPage")
    @ResponseBody
    public List<GiftOrder> querylipinyichuliOrderPage(int page){
        return giftOrderService.querylipinyichuliOrderPage(page);
    }

}