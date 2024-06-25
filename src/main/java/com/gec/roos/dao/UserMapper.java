package com.gec.roos.dao;

import com.gec.roos.pojo.Note;
import com.gec.roos.pojo.User;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface  UserMapper {

    @Select("select * from user where openid=#{openid}")
    public void queryMyOrder(String openid);

    //根据openid 查询用户信息
    @Select("select * from user where openid=#{openid}")
    User queryUser(String openid);

    //修改会员积分
    @Update("update user set integral=integral+#{sum} where id =#{id}")
    void updateUserIntegral(@Param("sum") int sum, @Param("id") int id);

    //注册会员
    @Insert("insert into user(openid,userName,pwd,nike,phone,member,createTime) " +
            "values(#{openid},#{userName},#{pwd},#{nike},#{phone},\"VIP会员\",now())")
    int regMember(User user);

    //修改会员 余额及积分
    @Update("update user set amount=amount+#{amount},integral=integral+#{amount} where openid=#{openid} ")
    void updateUserAmountAndIntegral(@Param("openid") String openid,@Param("amount") int amount);

    //修改会员余额
    @Update("update user set amount=amount+#{amount} where openid=#{openid}")
    void updateUserAmonut(@Param("amount")int amount,@Param("openid")String openid);

    //条件查询总条数
    @Select("<script>"
            +"SELECT count(id) FROM user"
            +"<where > <if test=\"phone!=null&amp;phone!=''\"> phone=#{phone}</if></where>"
            +"</script>")
    int getCountByPhone(@Param("phone") String phone);
    @Select("<script>"
            + "select * from user"
            +"<where ><if test=\"phone!=null&amp;phone!=''\">phone=#{phone}</if></where>"
            +"limit #{start},5"
            +"</script>")
    List<User> queryMemberByPageAndPhone(@Param("start") int start, @Param("phone") String phone);

    //分页查询会员信息
    @Select("select * from user limit #{start},5")
    List<User> queryMemberByPage(int start);

    //通过openid 修改会员积分
    @Update("update user set integral=integral+#{integral} where openid =#{openid}")
    int updateUserIntegralByopenid(@Param("integral") int integral,@Param("openid") String openid);
}
