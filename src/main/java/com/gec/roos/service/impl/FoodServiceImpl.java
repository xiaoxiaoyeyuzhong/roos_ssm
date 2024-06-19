package com.gec.roos.service.impl;

import com.gec.roos.dao.FoodMapper;
import com.gec.roos.pojo.Food;
import com.gec.roos.service.FoodService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class FoodServiceImpl implements FoodService {

    @Autowired
    private FoodMapper foodMapper;

    //查询菜品总条数
    @Override
    public int selectSumCount() {
        return foodMapper.selectSumCount();
    }
    //查询所有菜品
    @Override
    public List<Food> queryAllfood(int start) {
        return foodMapper.queryAllfood(start);
    }

    @Override
    public void addFood(Food food) {
        foodMapper.addFood(food);
    }

    @Override
    public Food queryfoodById(int fid) {
        return foodMapper.queryfoodById(fid);
    }

    @Override
    public void updateFood(Food food) {
        foodMapper.updateFood(food);
    }

    @Override
    public void deleteFood(int fid) {
        foodMapper.deleteFood(fid);
    }

    @Override
    public List<Food> selectFoodPage(int typeid, int start) {
        return foodMapper.selectFoodPage(typeid,start);
    }

    @Override
    public int selectSumCountBytypeId(int typeid) {
        return foodMapper.selectSumCountBytypeId(typeid);
    }
}