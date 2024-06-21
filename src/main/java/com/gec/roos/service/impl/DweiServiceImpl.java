package com.gec.roos.service.impl;

import com.gec.roos.dao.DweiMapper;
import com.gec.roos.pojo.Dwei;
import com.gec.roos.service.DweiService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class DweiServiceImpl implements DweiService {
    @Autowired
    private DweiMapper dweiMapper;

    @Override
    public void addDweiInfo(Dwei dwei) {
        dweiMapper.addDweiInfo(dwei);
    }

    @Override
    public List<Dwei> queryDweiDetail(String openid) {
        return dweiMapper.queryDweiDetail(openid);
    }

    @Override
    public void changeDweiState(int id) {
        dweiMapper.changeDweiState(id);
    }

    @Override
    public Map<String, Object> queryAllDweiInfo(int page) {
        String msg = null;
        //1.查询出预定桌位总记录数
        int count = dweiMapper.queryAlldweiInfoCount();
        //计算总页数
        int countPage = count%10==0? count/10:count/10+1;
        //查询起始下标
        int start = (page-1)*10;
        //2.查询最新10条记录
        List<Dwei> dweis = dweiMapper.queryAllDweiInfo(start);
        if(dweis.size()==0){
            msg = "0";
        }
        //3.封装返回数据
        Map<String,Object> map = new HashMap<>();
        map.put("countPage",countPage);
        map.put("msg",msg);
        map.put("dweis",dweis);
        return map;
    }

    @Override
    public void OKyuding(int id) {
        dweiMapper.updateDweiState(id);
    }
}
