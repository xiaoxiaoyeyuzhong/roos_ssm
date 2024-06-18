package com.gec.roos.service;

import com.gec.roos.pojo.Admin;

public interface AdminService {
    Admin findById(Integer id);

    int insertBatch(Admin admin);
}
