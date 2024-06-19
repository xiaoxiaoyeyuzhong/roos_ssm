package com.gec.roos.service.impl;

import com.gec.roos.dao.FoodTypeMapper;
import com.gec.roos.pojo.FoodType;
import com.gec.roos.service.FoodTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class FoodTypeServiceImpl implements FoodTypeService {

    @Autowired
    private FoodTypeMapper foodTypeMapper;

    @Override
    public List<FoodType> queryAllfoodType() {
        return foodTypeMapper.queryAllfoodType();
    }

    @Override
    public int selectTypeSumCount() {
        return foodTypeMapper.selectTypeSumCount();
    }

    @Override
    public void addFoodType(FoodType foodType) {
        foodTypeMapper.addFoodType(foodType);
    }


    @Override
    public FoodType queryfoodTypeById(int typeid) {
        return foodTypeMapper.queryfoodTypeById(typeid);
    }

    @Override
    public void updatefoodTypeInfo(FoodType foodType) {
        foodTypeMapper.updateFoodTypeInfo(foodType);
    }

    @Override
    public void deletefoodTypeInfo(int typeid) {
        foodTypeMapper.deletefoodTypeInfo(typeid);
    }


}
