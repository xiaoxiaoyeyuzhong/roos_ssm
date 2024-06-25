package com.gec.roos.dao;

import com.gec.roos.pojo.FoodType;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface FoodTypeMapper {
    // 查询所有菜品类型
    @Select("select * from foodtype")
    List<FoodType> queryAllfoodType();

    // 查询菜品类型条数
    int selectTypeSumCount();

    // 添加菜品类型
    @Insert("insert into foodtype (typeName,picurl,create_time) values(#{typeName},#{picurl},now())")
    void addFoodType(FoodType foodType);

    //根据id查询菜品类型
    @Select("select * from foodtype where typeid = #{typeid}")
    FoodType queryfoodTypeById(int typeid);

    //修改菜品类型信息
    @Update("update foodtype set typeName=#{typeName},picurl=#{picurl} where typeid=#{typeid}")
    void updateFoodTypeInfo(FoodType foodType);

    //删除菜品类型
    @Delete("delete from foodtype where typeid=#{typeid}")
    void deletefoodTypeInfo(int typeid);

    //根据菜品类型id查询类型下的菜品
    FoodType queryListByfoodTypeId(int typeid);
}
