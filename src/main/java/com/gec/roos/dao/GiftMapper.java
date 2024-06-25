package com.gec.roos.dao;

import com.gec.roos.pojo.Gift;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface GiftMapper {
    //查询所有礼品信息
    @Select("select * from gift")
    List<Gift> queryAllGiftInfo();

    //添加礼品
    @Insert("insert into gift(pname,integral,number,imgurl,postage,createTime)" +
            " values(#{pname},#{integral},#{number},#{imgurl},#{postage},now())")
    void addGiftInfo(Gift gift);

    //根据礼品id查询礼品
    @Select("select * from gift where pid = #{pid}")
    Gift queryGiftInfoById(int pid);

    //修改礼品信息
    @Update("update gift set" +
            " pname=#{pname},integral=#{integral},number=#{number},imgurl=#{imgurl},postage=#{postage},createTime=now() " +
            "where pid=#{pid}")
    void updateGift(Gift gift);

    //通过pid删除礼品
    @Delete("delete from gift where pid = #{pid}")
    void deleteGiftInfo(int pid);
}
