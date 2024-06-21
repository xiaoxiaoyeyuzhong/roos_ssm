package com.gec.roos.service;

import com.gec.roos.pojo.User;
import org.springframework.stereotype.Service;

public interface UserService {

    public void queryMyOrder(String openid);

    //通过openid查询用户信息
    User queryUser(String openid);
}
