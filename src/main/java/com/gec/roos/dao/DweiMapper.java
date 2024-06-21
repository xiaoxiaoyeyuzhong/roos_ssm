package com.gec.roos.dao;

import com.gec.roos.pojo.Dwei;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.List;

public interface DweiMapper {
    //添加用户定位
    @Insert("insert into dwei(openid,activetime,personNum,diskNum,mobile,name,state,remark,create_time) values(#{openid},#{activetime},#{personNum},#{diskNum},#{mobile},#{name},\"未使用\",#{remark},now())")
    void addDweiInfo(Dwei dwei);

    //查询用户在线定位信息
    @Select("select * from dwei where openid = #{openid}")
    List<Dwei> queryDweiDetail(String openid);

    //取消预定桌位
    @Update("update dwei set state = \"已取消\" where id = #{id}")
    void changeDweiState(int id);

    //查询定位人数
    @Select("select count(id) from dwei ")
    int queryAlldweiInfoCount();


    //查询所有定位信息
    @Select("select * from dwei order by create_time desc limit #{start},10")
    List<Dwei> queryAllDweiInfo(int start);

    //确认桌位消费
    @Update("update dwei set state = \"已消费\" where id = #{id}")
    void updateDweiState(int id);
}
