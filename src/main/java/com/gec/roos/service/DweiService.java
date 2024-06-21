package com.gec.roos.service;

import com.gec.roos.pojo.Dwei;

import java.util.List;
import java.util.Map;

public interface DweiService {
    //添加用户定位
    void addDweiInfo(Dwei dwei);

    //查询用户定位信息
    List<Dwei> queryDweiDetail(String openid);

    //修改预定桌位为已取消
    void changeDweiState(int id);

    //查询定位信息
    Map<String, Object> queryAllDweiInfo(int page);

    //确认桌位消费
    void OKyuding(int id);
}
