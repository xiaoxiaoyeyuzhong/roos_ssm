package com.gec.roos.service.impl;

import com.gec.roos.dao.ShopMapper;
import com.gec.roos.pojo.Shop;
import com.gec.roos.service.ShopService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ShopServiceImpl implements ShopService {

    @Autowired
    private ShopMapper shopMapper;

    @Override
    public List<Shop> queryAllShopInfo() {
        return shopMapper.queryAllShopInfo();
    }

    //添加门店信息
    @Override
    public void addShop(Shop shop) {
        shopMapper.addShop(shop);
    }
    //根据主键查询门店信息
    @Override
    public Shop queryShopById(int id) {
        return shopMapper.queryShopById(id);
    }
    //修改门店信息
    @Override
    public void updateShop(Shop shop) {
        shopMapper.updateShop(shop);
    }
    //删除门店信息
    @Override
    public void deleteShopInfo(int id) {
        shopMapper.deleteShopInfo(id);
    }
}
