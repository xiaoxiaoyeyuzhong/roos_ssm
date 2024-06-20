package com.gec.roos.dao;

import com.gec.roos.pojo.Shop;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface ShopMapper {
    //查询所有门店
    @Select("select * from shop")
    List<Shop> queryAllShopInfo();
}
