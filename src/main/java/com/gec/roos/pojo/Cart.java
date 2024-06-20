package com.gec.roos.pojo;
/**
 * 购物车
 * @author fdt
 *
 */
public class Cart {

	private int id;
	private String openid;
	private int fid; //菜品id
	private String create_time; //创建时间
	
	
	//菜品信息
	private Food food;

	public Food getFood() {
		return food;
	}
	public void setFood(Food food) {
		this.food = food;
	}
	
	
	
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getOpenid() {
		return openid;
	}
	public void setOpenid(String openid) {
		this.openid = openid;
	}
	public int getFid() {
		return fid;
	}
	public void setFid(int fid) {
		this.fid = fid;
	}
	public String getCreate_time() {
		return create_time;
	}
	public void setCreate_time(String create_time) {
		this.create_time = create_time;
	}
}
