package com.gec.roos.controller;

import com.gec.roos.pojo.Note;
import com.gec.roos.service.NoteService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;
import java.util.Map;

@Controller
public class NoteController {
    @Autowired
    private NoteService noteService;

    //分页条件查询用户充值记录
    @RequestMapping("/queryRechargeByPageAndtime")
    public String queryRechargeByPageAndtime(Model model, @RequestParam(value = "page")int page,
                                             @RequestParam(value = "startDate",required = false) String startDate){
        //调用业务接口查询充值信息
        Map<String,Object> map =  noteService.queryRechargeByPageAndtime(page,startDate);

        model.addAttribute("notes", map.get("notes"));
        model.addAttribute("countPage", map.get("countPage"));
        model.addAttribute("sum", map.get("sum" ));
        model.addAttribute("msg",map.get("msg"));
        if(startDate!=null&&startDate!=""){
            //如果携带startDate 转发到页面 翻页使用
            model.addAttribute("startDate",startDate);
        }
        return "back/userNote";
    }

    //根据时间查询当前页内容  上一页/下一页
    @RequestMapping("/queryRechargeByPage")
    @ResponseBody
    public List<Note> queryRechargeByPage(@RequestParam(value = "page")int page,
                                          @RequestParam(value = "startDate",required = false) String startDate){

        List<Note> notes = noteService.queryRechargeByPage(page,startDate);

        return notes;
    }

    //分页查询会员充值消费详情
    @RequestMapping("/queryUserNoteByPage")
    public String queryUserNoteByPage(Model model, String openid, int page){

        Map<String,Object> map =noteService.queryUserNoteByPage(openid,page);
        model.addAttribute("notes",map.get("notes"));
        model.addAttribute("countPage",map.get("countPage"));
        model.addAttribute("user",map.get("user"));
        return "back/userNoteConten";
    }

}
