package com.gec.roos.service.impl;

import com.gec.roos.dao.CartMapper;
import com.gec.roos.pojo.Cart;
import com.gec.roos.service.CartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CartServiceImpl implements CartService {

    @Autowired
    private CartMapper cartMapper;

    @Override
    public void addCart(Cart cart) {

        //1.查询当前用户购物车中是否存在该菜品
        int reslut = cartMapper.queryCartisExist(cart);
        //2.如果不存在添加菜品到购物车
        if(reslut==0){
            //2.1加入购物车
            cartMapper.addCart(cart);
        }
    }

    @Override
    public List<Cart> queryAllCart(String openid) {
        return cartMapper.queryAllCart(openid);
    }
}
