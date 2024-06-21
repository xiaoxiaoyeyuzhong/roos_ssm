package com.gec.roos.service;

import com.gec.roos.pojo.Address;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;

public interface AddressService {
    //通过openid查询会员收件地址
    Address queryAddressInfo(String openid);

    //删除会员地址
    int delAddressInfo(String openid);
}
