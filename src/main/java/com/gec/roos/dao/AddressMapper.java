package com.gec.roos.dao;

import com.gec.roos.pojo.Address;
import org.apache.ibatis.annotations.*;

@Mapper
public interface AddressMapper {
    //通过openId查询会员收件地址
    @Select("select * from address where openid=#{openid}")
    Address queryAddressInfo(String openid);


    //添加收件地址
    @Insert("insert into address (openid,userName,mobile,address,createTime) values(#{openid},#{userName},#{mobile},#{address},now())")
    int addAddressInfo(Address addressInfo);


    //修改收件地址
    @Update("update address set userName = #{userName},mobile = #{mobile},address = #{address},createTime = now() where openid = #{openid}")
    int updateAddressInfo(Address addressInfo);

    //删除会员收件地址
    @Delete("delete from address where openid=#{openid}")
    int delAddressInfo(String openid);
}
