package com.gec.roos.service;

import com.gec.roos.pojo.FoodType;

import java.util.List;

public interface FoodTypeService {

   //查询所有菜品类型
   List<FoodType> queryAllfoodType();

   //查询菜品类型总条数
   int selectTypeSumCount();

   //添加菜品类型
   void addFoodType(FoodType foodType);

   //根据id查询菜品类型
   FoodType queryfoodTypeById(int typeid);

   //修改菜品类型
   void updatefoodTypeInfo(FoodType foodType);


   //删除菜品类型
   void deletefoodTypeInfo(int typeid);


   //根据菜品类型id查询类型下的菜品
   FoodType queryListByfoodTypeId(int typeid);

}
