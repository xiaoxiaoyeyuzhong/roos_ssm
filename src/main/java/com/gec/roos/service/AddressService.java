package com.gec.roos.service;

import com.gec.roos.pojo.Address;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;

public interface AddressService {
    //通过openid查询会员收件地址
    Address queryAddressInfo(String openid);

    //添加收件地址
    int addAddressInfo(Address addressInfo);
    //修改收件地址
    int updateAddressInfo(Address addressInfo);

    //删除会员地址
    int delAddressInfo(String openid);
}
