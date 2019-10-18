package com.care.sys.shareinfo.domain;

import java.io.Serializable;
import java.util.Date;

import com.godoing.rose.http.PublicVoBean;

public class ShareInfo extends PublicVoBean implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1182518760078612839L;

	private String userId;   //�û�id
	
	private String deviceId; //�豸id
	
	private String toUserId;  //���ĸ��û�����
	
	private String isPriority; //���ȼ�,0��ʾ������豸,1��ʾ�Լ������豸

	private Date shareDate;   //����ʱ��
	
    private String belongProject;
    
    private String orderNumber;
    private String orderNumber1;
    private String orderNumber2;
    private String orderNumber3;
    private String orderNumber4;
    private String orderNumber5;
    private String orderNumber6;
    private String orderNumber7;
    private String orderNumber8;
    private String orderNumber9;
    private String xsjg;
    private String xsjg1;
    private String xsjg2;
    private String xsjg3;
    private String xsjg4;
    private String xsjg5;
    private String xsjg6;
    private String xsjg7;
    private String xsjg8;
    private String xsjg9;
    private String order_id;
    private String addhang;
    private String addhang1;

    
	public String getAddhang() {
		return addhang;
	}
	public void setAddhang(String addhang) {
		this.addhang = addhang;
	}
	public String getAddhang1() {
		return addhang1;
	}
	public void setAddhang1(String addhang1) {
		this.addhang1 = addhang1;
	}
	public String getOrder_id() {
		return order_id;
	}
	public void setOrder_id(String order_id) {
		this.order_id = order_id;
	}
	public String getOrderNumber() {
		return orderNumber;
	}
	public void setOrderNumber(String orderNumber) {
		this.orderNumber = orderNumber;
	}
	public String getXsjg() {
		return xsjg;
	}
	public void setXsjg(String xsjg) {
		this.xsjg = xsjg;
	}
	public String getOrderNumber1() {
		return orderNumber1;
	}
	public void setOrderNumber1(String orderNumber1) {
		this.orderNumber1 = orderNumber1;
	}
	public String getOrderNumber2() {
		return orderNumber2;
	}
	public void setOrderNumber2(String orderNumber2) {
		this.orderNumber2 = orderNumber2;
	}
	public String getOrderNumber3() {
		return orderNumber3;
	}
	public void setOrderNumber3(String orderNumber3) {
		this.orderNumber3 = orderNumber3;
	}
	public String getOrderNumber4() {
		return orderNumber4;
	}
	public void setOrderNumber4(String orderNumber4) {
		this.orderNumber4 = orderNumber4;
	}
	public String getOrderNumber5() {
		return orderNumber5;
	}
	public void setOrderNumber5(String orderNumber5) {
		this.orderNumber5 = orderNumber5;
	}
	public String getOrderNumber6() {
		return orderNumber6;
	}
	public void setOrderNumber6(String orderNumber6) {
		this.orderNumber6 = orderNumber6;
	}
	public String getOrderNumber7() {
		return orderNumber7;
	}
	public void setOrderNumber7(String orderNumber7) {
		this.orderNumber7 = orderNumber7;
	}
	public String getOrderNumber8() {
		return orderNumber8;
	}
	public void setOrderNumber8(String orderNumber8) {
		this.orderNumber8 = orderNumber8;
	}
	public String getOrderNumber9() {
		return orderNumber9;
	}
	public void setOrderNumber9(String orderNumber9) {
		this.orderNumber9 = orderNumber9;
	}
	public String getXsjg1() {
		return xsjg1;
	}
	public void setXsjg1(String xsjg1) {
		this.xsjg1 = xsjg1;
	}
	public String getXsjg2() {
		return xsjg2;
	}
	public void setXsjg2(String xsjg2) {
		this.xsjg2 = xsjg2;
	}
	public String getXsjg3() {
		return xsjg3;
	}
	public void setXsjg3(String xsjg3) {
		this.xsjg3 = xsjg3;
	}
	public String getXsjg4() {
		return xsjg4;
	}
	public void setXsjg4(String xsjg4) {
		this.xsjg4 = xsjg4;
	}
	public String getXsjg5() {
		return xsjg5;
	}
	public void setXsjg5(String xsjg5) {
		this.xsjg5 = xsjg5;
	}
	public String getXsjg6() {
		return xsjg6;
	}
	public void setXsjg6(String xsjg6) {
		this.xsjg6 = xsjg6;
	}
	public String getXsjg7() {
		return xsjg7;
	}
	public void setXsjg7(String xsjg7) {
		this.xsjg7 = xsjg7;
	}
	public String getXsjg8() {
		return xsjg8;
	}
	public void setXsjg8(String xsjg8) {
		this.xsjg8 = xsjg8;
	}
	public String getXsjg9() {
		return xsjg9;
	}
	public void setXsjg9(String xsjg9) {
		this.xsjg9 = xsjg9;
	}
	public String getBelongProject() {
		return belongProject;
	}
	public void setBelongProject(String belongProject) {
		this.belongProject = belongProject;
	}
	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getDeviceId() {
		return deviceId;
	}

	public void setDeviceId(String deviceId) {
		this.deviceId = deviceId;
	}

	public String getIsPriority() {
		return isPriority;
	}

	public void setIsPriority(String isPriority) {
		this.isPriority = isPriority;
	}

	public String getToUserId() {
		return toUserId;
	}

	public void setToUserId(String toUserId) {
		this.toUserId = toUserId;
	}

	public Date getShareDate() {
		return shareDate;
	}

	public void setShareDate(Date shareDate) {
		this.shareDate = shareDate;
	}
	
}
