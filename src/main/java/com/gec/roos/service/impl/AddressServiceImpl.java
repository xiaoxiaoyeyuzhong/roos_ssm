package com.gec.roos.service.impl;

import com.gec.roos.dao.AddressMapper;
import com.gec.roos.pojo.Address;
import com.gec.roos.service.AddressService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AddressServiceImpl  implements AddressService {
    @Autowired
    private AddressMapper addressMapper;

    @Override
    public Address queryAddressInfo(String openid) {
        return addressMapper.queryAddressInfo(openid);
    }

    //添加收件地址
    @Override
    public int addAddressInfo(Address addressInfo) {
        return addressMapper.addAddressInfo(addressInfo);
    }
    //修改收件地址
    @Override
    public int updateAddressInfo(Address addressInfo) {
        return addressMapper.updateAddressInfo(addressInfo);
    }

    @Override
    public int delAddressInfo(String openid) {
        return addressMapper.delAddressInfo(openid);
    }


}
