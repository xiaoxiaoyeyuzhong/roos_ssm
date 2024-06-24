package com.gec.roos.service;

import com.gec.roos.pojo.Shop;

import java.util.List;

public interface ShopService {

    //查询所有店铺信息
    List<Shop> queryAllShopInfo();

    //添加门店信息
    void addShop(Shop shop);
    //通过主键查询门店信息
    Shop queryShopById(int id);
    //修改门店信息
    void updateShop(Shop shop);

    //根据主键删除门店信息
    void deleteShopInfo(int id);
}
