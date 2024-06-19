package com.gec.roos.dao;

import com.gec.roos.pojo.Food;
import com.gec.roos.pojo.FoodType;
import org.apache.ibatis.annotations.*;

import java.util.List;

public interface FoodMapper {
    //查询所有菜品
    List<Food> queryAllfood(int start);

    // 查询菜品条数
    int selectSumCount();

    //菜品添加
    @Insert("insert into food (typeid,foodName,picurl,foodPrice,foodVIP,integral,feature,create_time) values" +
            "(#{typeid},#{foodName},#{picurl},#{foodPrice},#{foodVIP},#{integral},#{feature},now())")
    void addFood(Food food);

    //根据id查询菜品
    @Select("select * from food where fid = #{fid}")
    Food queryfoodById(int fid);

    //修改菜品
    @Update("update food set " +
            "typeid=#{typeid},foodName=#{foodName},picurl=#{picurl},foodPrice=#{foodPrice},foodVIP=#{foodVIP},integral=#{integral},feature=#{feature} " +
            "where fid =#{fid}")
    void updateFood(Food food);

    //根据id删除菜品
    @Delete("delete from food where fid = #{fid}")
    void deleteFood(int fid);

    //根据分类分页查询菜品
    List<Food> selectFoodPage(@Param("typeid") int typeid, @Param("start") int start);


    //根据菜品分类查询菜品数量
    @Select("select count(*) from food where typeid = #{typeid}")
    int selectSumCountBytypeId(int typeid);
}
