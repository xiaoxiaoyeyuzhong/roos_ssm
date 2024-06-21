package com.gec.roos.dao;

import com.gec.roos.pojo.Note;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface NoteMapper {
    //添加会员充值记录
    @Insert("insert into note (openid,recordBill,money,createTime) values (#{openid},#{recordBill},#{money},now()) ")
    void addUserRecord(Note note);

    //查询所有账单信息
    @Select("select * from note where openid=#{openid} order by createTime desc")
    List<Note> queryAllMyNote(String openid);
    //查询5条账单记录
    @Select("select * from note where openid=#{openid} order by createTime desc limit 5")
    List<Note> queryMyNote(String openid);

}
