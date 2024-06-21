package com.gec.roos.service;

import com.gec.roos.pojo.Note;
import com.gec.roos.pojo.User;
import com.gec.roos.vo.PayVo;
import org.springframework.stereotype.Service;

import java.util.List;

public interface UserService {

    public void queryMyOrder(String openid);

    //通过openid查询用户信息
    User queryUser(String openid);

    //vip会员注册
    int regMember(User user);

    //会员充值成功
    void rechargeSuccessed(String openid, PayVo payVo);

    //提交支付密码完成结账
    String submitPwd(String openid, int amount, String pwd);


    //查询所有账单信息
    List<Note> queryAllMyNote(String openid);
    //查询该用户5条账单信息
    List<Note> queryMyNote(String openid);
}
