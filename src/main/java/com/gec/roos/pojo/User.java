package com.gec.roos.pojo;

public class User {

	private int id;
	private String openid;
	private String nike; //昵称
	private String userName; //用户名
	private String pwd;  //密码
	private String phone; //手机号
	private int integral; //积分
	private int amount;  //充值金额
	private String member; //是否是会员
	private String createTime; //创建时间
	
	
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
	public String getNike() {
		return nike;
	}
	public void setNike(String nike) {
		this.nike = nike;
	}
	
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public int getIntegral() {
		return integral;
	}
	public void setIntegral(int integral) {
		this.integral = integral;
	}
	
	public int getAmount() {
		return amount;
	}
	public void setAmount(int amount) {
		this.amount = amount;
	}
	
	public String getMember() {
		return member;
	}
	public void setMember(String member) {
		this.member = member;
	}

	public String getCreateTime() {
		return createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

	@Override
	public String toString() {
		return "User{" +
				"id=" + id +
				", openid='" + openid + '\'' +
				", nike='" + nike + '\'' +
				", userName='" + userName + '\'' +
				", pwd='" + pwd + '\'' +
				", phone='" + phone + '\'' +
				", integral=" + integral +
				", amount=" + amount +
				", member='" + member + '\'' +
				", createTime='" + createTime + '\'' +
				'}';
	}
}
