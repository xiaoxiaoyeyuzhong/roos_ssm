package com.gec.roos.controller;

import com.gec.roos.service.DweiService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Map;

@Controller
public class DweiController {

    @Autowired
    private DweiService dweiService;

    @RequestMapping("/queryAllDweiInfo")
    public String queryAllDweiInfo(Model model, int page){
        Map<String,Object> map= dweiService.queryAllDweiInfo(page);

        model.addAttribute("msg",map.get("msg"));
        model.addAttribute("dweis",map.get("dweis"));
        model.addAttribute("countPage",map.get("countPage"));
        return "back/zuoweiyuding";
    }

    //管理员确定预定桌位消费
    @RequestMapping("/OKyuding")
    @ResponseBody
    public String OKyuding(int id){
        //更改预定桌位的订单状态
        String success = null;
        try {
            dweiService.OKyuding(id);
            success = "1";
        } catch (Exception e) {
            success = "0";
        }
        return success;
    }
}
