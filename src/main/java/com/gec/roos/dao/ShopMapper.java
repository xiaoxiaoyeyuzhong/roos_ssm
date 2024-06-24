package com.gec.roos.dao;

import com.gec.roos.pojo.Shop;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.List;

public interface ShopMapper {
    //查询所有门店
    @Select("select * from shop")
    List<Shop> queryAllShopInfo();
    //添加门店信息
    @Insert("insert into shop (shopName,telphone,address,imgurl) values (#{shopName},#{telphone},#{address},#{imgurl})")
    void addShop(Shop shop);
    //根据id查询分店信息
    @Select("select * from shop where id = #{id}")
    Shop queryShopById(int id);
    //修改分店信息
    @Update("update shop set shopName=#{shopName},telphone=#{telphone},address=#{address},imgurl=#{imgurl} where id=#{id}")
    void updateShop(Shop shop);
    //删除分店信息
    @Delete("delete from shop where id = #{id}")
    void deleteShopInfo(int id);

}
