package com.gec.roos.dao;

import com.gec.roos.pojo.Note;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
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

    //根据时间查询充值条数
    int getRechargeCountByTime(@Param("startDate") String startDate);

    //根据时间查询充值记录信息
    List<Note> queryRechargeNotesByTime(@Param("start") int start ,@Param("startDate") String startDate);
    //根据时间查询充值钱数
    List<String>queryAllRechargeNotesByTime(@Param("startDate") String startDate);

    //根据openid查询会员充值消费总记录个数
    @Select("select count(n_id) from note where openid=#{openid}")
    int getCountByopenid(String openid);

    //根据openid查询会员充值消费总记录集合
    @Select("select * from note where openid =#{openid} order by createTime desc limit #{start},10")
    List<Note> queryUserNoteByPage(@Param("openid")String openid,@Param("start") int start);
}
