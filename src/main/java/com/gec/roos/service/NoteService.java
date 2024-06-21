package com.gec.roos.service;

import com.gec.roos.pojo.Note;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public interface NoteService {
    //分页条件查询所有会员充值信息
    Map<String, Object> queryRechargeByPageAndtime(int page, String startDate);

    //根据时间查询当前页内容  上一页/下一页
    List<Note> queryRechargeByPage(int page, String startDate);

    //分页查询会员充值消费详情
    Map<String, Object> queryUserNoteByPage(String openid, int page);
}
