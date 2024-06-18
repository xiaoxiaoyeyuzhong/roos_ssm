package com.gec.roos.pojo;

import java.util.List;

/**
 * 订单实体
 * @author hping
 *
 */
public class Order {

	private int orderid;
	private String openid;
	private String state; //订单状态
	//付款方式
	private String payment;
	//是否消费
	private String isexpend;
	private String eatdate; //用餐时间
	private String create_time; //创建时间
	
	//一个订单里可以有多个商品
	private List<OrderFo> odf;

	public List<OrderFo> getOdf() {
		return odf;
	}
	public void setOdf(List<OrderFo> odf) {
		this.odf = odf;
	}
	
	
	//一个订单对应一个用餐门店
	private Shop shop;
	
	public Shop getShop() {
		return shop;
	}
	public void setShop(Shop shop) {
		this.shop = shop;
	}
	
	
	public int getOrderid() {
		return orderid;
	}
	public void setOrderid(int orderid) {
		this.orderid = orderid;
	}
	public String getOpenid() {
		return openid;
	}
	public void setOpenid(String openid) {
		this.openid = openid;
	}
	
	
	public String getPayment() {
		return payment;
	}
	public void setPayment(String payment) {
		this.payment = payment;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}

	public String getIsexpend() {
		return isexpend;
	}

	public void setIsexpend(String isexpend) {
		this.isexpend = isexpend;
	}

	public String getEatdate() {
		return eatdate;
	}
	public void setEatdate(String eatdate) {
		this.eatdate = eatdate;
	}
	public String getCreate_time() {
		return create_time;
	}
	public void setCreate_time(String create_time) {
		this.create_time = create_time;
	}
}
