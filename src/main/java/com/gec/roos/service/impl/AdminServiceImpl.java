package com.gec.roos.service.impl;

import com.gec.roos.dao.AdminMapper;
import com.gec.roos.pojo.Admin;
import com.gec.roos.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class AdminServiceImpl implements AdminService {

    @Autowired
    private AdminMapper adminMapper;

    @Override
    public Admin findById(Integer id) {
        return adminMapper.findById(id);
    }

    @Override
    public int insertBatch(Admin admin) {
        int result = adminMapper.insert(admin);
        int i= 1/0;//模拟异常
        result += adminMapper.insert(admin);
        return result;
    }
}
