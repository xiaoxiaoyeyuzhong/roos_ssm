package com.gec.roos.dao;

import com.gec.roos.pojo.Address;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

public interface AddressMapper {
    //通过openId查询会员收件地址
    @Select("select * from address where openid=#{openid}")
    Address queryAddressInfo(String openid);

    @Delete("delete from address where openid=#{openid}")
    int delAddressInfo(String openid);
}
