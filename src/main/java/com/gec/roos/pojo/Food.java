package com.gec.roos.pojo;
/**
 * 菜品实体
 *
 */
public class Food {
	//菜品id
	private Integer fid;
	//菜品分类id
	private Integer typeid;
	//菜品名称
	private String foodName;
	//菜品图片地址ַ
	private String picurl;
	//菜品价格
	private double foodPrice;
	//菜品VIP价格
	private double foodVIP;
	//菜品积分
	private Integer integral;
	//菜品特色
	private String feature;
	//创建时间
	private String create_time;

	//菜品分类信息
	private FoodType ft;
	
	public Integer getFid() {
		return fid;
	}
	public void setFid(Integer fid) {
		this.fid = fid;
	}
	public Integer getTypeid() {
		return typeid;
	}
	public void setTypeid(Integer typeid) {
		this.typeid = typeid;
	}
	public String getFoodName() {
		return foodName;
	}
	public void setFoodName(String foodName) {
		this.foodName = foodName;
	}
	
	public double getFoodPrice() {
		return foodPrice;
	}
	public void setFoodPrice(double foodPrice) {
		this.foodPrice = foodPrice;
	}
	public String getPicurl() {
		return picurl;
	}
	public void setPicurl(String picurl) {
		this.picurl = picurl;
	}
	public void setFoodPrice(Integer foodPrice) {
		this.foodPrice = foodPrice;
	}
	
	public double getFoodVIP() {
		return foodVIP;
	}
	public void setFoodVIP(double foodVIP) {
		this.foodVIP = foodVIP;
	}
	public Integer getIntegral() {
		return integral;
	}
	public void setIntegral(Integer integral) {
		this.integral = integral;
	}
	public String getFeature() {
		return feature;
	}
	public void setFeature(String feature) {
		this.feature = feature;
	}
	public String getCreate_time() {
		return create_time;
	}
	public void setCreate_time(String create_time) {
		this.create_time = create_time;
	}
	
	
	public FoodType getFt() {
		return ft;
	}
	public void setFt(FoodType ft) {
		this.ft = ft;
	}
	
	
}
