package com.gec.roos.service;

import com.gec.roos.pojo.Cart;

import java.util.List;

public interface CartService {
    //添加购物车
    void addCart(Cart cart);

    //查询用户购物车
    List<Cart> queryAllCart(String openid);
}
