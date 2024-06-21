package com.gec.roos.service.impl;

import com.gec.roos.dao.NoteMapper;
import com.gec.roos.pojo.Note;
import com.gec.roos.pojo.User;
import com.gec.roos.service.NoteService;
import com.gec.roos.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class NoteServiceImpl implements NoteService {
    @Autowired
    private NoteMapper noteMapper;

    @Autowired
    private UserService userService;
    @Override
    public Map<String, Object> queryRechargeByPageAndtime(int page, String startDate) {
        //1.条件查询充值总条数

        int count =noteMapper.getRechargeCountByTime(startDate);
        int start = (page-1)*5;
        int countPage = count%5==0? count/5:count/5+1;
        //2.条件查询充值信息
        List<Note> notes =  noteMapper.queryRechargeNotesByTime(start,startDate);

        //3.计算充值金额
        double sum=0;
        List<String> moneys=null;
        //判断是否是根据时间查询
        if(startDate!=null&&startDate!=""){
            //3.1 如果通过时间条件查询 则计算当前时间的总金额 查询当天所有充值金额
            moneys=   noteMapper.queryAllRechargeNotesByTime(startDate);
        }else {
            //3.2查询所有充值记录总金额数
            moneys=   noteMapper.queryAllRechargeNotesByTime(null);
        }
        //3.3 计算金额
        for (String str : moneys) {
            sum += Double.valueOf(str.substring(1));
        }

        //4.数据封装
        Map<String,Object> map = new HashMap<>();
        map.put("notes",notes);
        map.put("sum",sum);
        map.put("countPage",countPage );
        map.put("msg",notes.size()+"");
        return map;
    }

    //根据时间查询当前页内容  上一页/下一页
    @Override
    public List<Note> queryRechargeByPage(int page, String startDate) {
        int start = (page-1)*5;
        List<Note> notes = noteMapper.queryRechargeNotesByTime(start, startDate);
        return notes;
    }

    @Override
    public Map<String, Object> queryUserNoteByPage(String openid, int page) {
        //根据openid查询会员充值消费总记录个数
        int count = noteMapper.getCountByopenid(openid);
        //设置总页数
        int countPage = count%10==0?count/10:count/10+1;
        int start =(page-1)*10;//设置起始下标
        //根据openid查询会员充值消费总记录集合
        List<Note> notes =  noteMapper.queryUserNoteByPage(openid,start);
        //查询会员信息
        User user = userService.queryUser(openid);
        //封装数据
        Map<String,Object> map = new HashMap<>();
        map.put("notes",notes);
        map.put("countPage",countPage);
        map.put("user",user);
        return map;
    }
}
