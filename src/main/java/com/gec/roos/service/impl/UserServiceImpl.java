package com.gec.roos.service.impl;

import com.gec.roos.config.MD5;
import com.gec.roos.dao.NoteMapper;
import com.gec.roos.dao.UserMapper;
import com.gec.roos.pojo.Note;
import com.gec.roos.pojo.User;
import com.gec.roos.service.UserService;
import com.gec.roos.vo.PayVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private NoteMapper noteMapper;


    @Override
    public void queryMyOrder(String openid) {
        userMapper.queryMyOrder(openid);
    }

    @Override
    public User queryUser(String openid) {
        return userMapper.queryUser(openid);
    }

    @Override
    public int regMember(User user) {
        //1.进行密码加密
        String password = user.getPwd()+"xzg";
        password = MD5.stringMD5(password);
        user.setPwd(password);
        //2.用户注册
        int i =  userMapper.regMember(user);
        return i;
    }

    @Override
    public void rechargeSuccessed(String openid, PayVo payVo) {
        //1.查询用户信息可以获取余额
        User user = userMapper.queryUser(openid);
        //2.用户添加余额、积分
        double amount_double = Double.parseDouble(payVo.getTotal_amount());
        int amount = (int) (amount_double);
        userMapper.updateUserAmountAndIntegral(openid,amount);
        //3.创建note对象
        Note note = new Note();
        note.setOpenid(openid);
        note.setRecordBill("+"+amount);
        //4.更改余额，即当前（余额+充值的金额 = 充值后账户的总金额）
        double sum = user.getAmount()+amount;
        note.setMoney(sum);
        //5.note表中添加用户充值记录
        noteMapper.addUserRecord(note);
    }

    @Override
    public String submitPwd(String openid, int amount, String pwd) {
        String data =null;
        if(pwd==null||"".equals(pwd)){
            data = "no";
        }
        //验证密码是否正确
        User user = userMapper.queryUser(openid);
        pwd= MD5.stringMD5(pwd+"xzg");
        if(user.getPwd().equals(pwd)){
            //更改账户余额  "用户余额(money)-当前消费金额(amount) = 消费后的余额"
            BigDecimal bigDecimal = BigDecimal.valueOf(amount);
            //将结账金额变为负数
            amount = bigDecimal.negate().intValue();
            //付成功后根据openid更改账户的金额
            userMapper.updateUserAmonut(amount,openid);

            //保存消费记录
            Note note = new Note();
            note.setOpenid(openid);
            if (amount<0){
                note.setRecordBill(Integer.toString(amount));
            }
            else{
                note.setRecordBill("+"+amount);
            }
            note.setMoney(user.getAmount()+(int)amount);
            noteMapper.addUserRecord(note);
            data = "ok";
        }
        return data;
    }

    @Override
    public List<Note> queryAllMyNote(String openid) {
        return noteMapper.queryAllMyNote(openid);
    }

    @Override
    public List<Note> queryMyNote(String openid) {
        return noteMapper.queryMyNote(openid);
    }

    @Override
    public Map<String, Object> queryMemberByPageAndPhone(int page, String phone) {
        String msg = null;
        //查询总记录数
        int count = userMapper.getCountByPhone(phone);
        int countPage = count%5==0?count/5:count/5+1;
        //计算查询起始下标
        int start = (page-1)*5;
        List<User> users = userMapper.queryMemberByPageAndPhone(start,phone);

        if(users.size()==0){
            msg = "0";
        }
        //数据封装
        Map<String,Object> map = new HashMap<>();
        map.put("msg",msg);
        map.put("countPage",countPage);
        map.put("users",users);
        map.put("count",count);
        return map;
    }

    @Override
    public List<User> queryMemberByPage(int page) {
        int start = (page-1)*5;
        return userMapper.queryMemberByPage(start);
    }

    @Override
    public int updateUserIntegralByopenid(int integral, String openid) {
        return userMapper.updateUserIntegralByopenid(integral,openid);
    }

    @Override
    public void updateUserName(User user){
        userMapper.updateUserName(user);
    }

    @Override
    public void updatePassword(User user){
        //1.进行密码加密
        String password = user.getPwd()+"xzg";
        password = MD5.stringMD5(password);
        user.setPwd(password);
        userMapper.updateUserPwd(user);
        return;
    }


}
