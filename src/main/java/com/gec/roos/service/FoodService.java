package com.gec.roos.service;

import com.gec.roos.pojo.Food;

import java.util.List;

public interface FoodService {
    //查询菜品总条数
    int selectSumCount();
    //查询所有菜品
    List<Food> queryAllfood(int start);

    //添加菜品
    void addFood(Food food);

    //根据id查询菜品
    Food queryfoodById(int fid);

    //修改菜品
    void updateFood(Food food);

    //删除菜品
    void deleteFood(int fid);

    //根据分类分页查询菜品
    List<Food> selectFoodPage(int typeid, int start);

    //查询该菜品分类下的菜品总行数
    int selectSumCountBytypeId(int typeid);
}
