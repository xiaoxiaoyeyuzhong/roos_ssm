package com.gec.roos.pojo;
/**
 * 账单记录实体
 * @author hping
 *
 */

public class Note {

	private Integer id;
	private String openid;
	private String recordBill;//账单记录
	private double money; //余额
	private String createTime; //创建时间
	
	private User user;


	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getOpenid() {
		return openid;
	}
	public void setOpenid(String openid) {
		this.openid = openid;
	}

	public String getRecordBill() {
		return recordBill;
	}

	public void setRecordBill(String recordBill) {
		this.recordBill = recordBill;
	}

	public double getMoney() {
		return money;
	}
	public void setMoney(double money) {
		this.money = money;
	}

	public String getCreateTime() {
		return createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}


}
