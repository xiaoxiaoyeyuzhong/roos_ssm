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
}
