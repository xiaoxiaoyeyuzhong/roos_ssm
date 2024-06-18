package com.gec.roos.pojo;
/**
 * 订单信息实体
 * @author hping
 *
 */
public class OrderFo {

	private int id;
	private int orderid; //订单id
	private int number; //订单项 数量
	private int fid;   //菜品id
	private String create_time;// 创建时间
	
	//存放已下单的菜品总金额（即 单价X数量）的值
	private double sum_money;
	
	//每个订单信息中对应一个菜品信息
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
	public int getOrderid() {
		return orderid;
	}
	public void setOrderid(int orderid) {
		this.orderid = orderid;
	}
	public int getNumber() {
		return number;
	}
	public void setNumber(int number) {
		this.number = number;
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
	public double getSum_money() {
		return sum_money;
	}
	public void setSum_money(double sum_money) {
		this.sum_money = sum_money;
	}
	
}
