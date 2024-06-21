package com.gec.roos.service.impl;

import com.gec.roos.dao.UserMapper;
import com.gec.roos.pojo.User;
import com.gec.roos.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserMapper userMapper;
    @Override
    public void queryMyOrder(String openid) {
        userMapper.queryMyOrder(openid);
    }

    @Override
    public User queryUser(String openid) {
        return userMapper.queryUser(openid);
    }
}
