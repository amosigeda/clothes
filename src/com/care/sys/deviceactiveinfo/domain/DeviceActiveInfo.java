package com.care.sys.deviceactiveinfo.domain;

import java.io.Serializable;
import java.util.Date;

import com.godoing.rose.http.PublicVoBean;

public class DeviceActiveInfo extends PublicVoBean implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 2651599528701240468L;
	
	private int id;

	private String devicePhone;  //�豸�绰����
	
	private String deviceImei;   //�豸��imei��
	
	private String deviceName;   //�豸���
	
	private String deviceHead;   //�豸ͷ��,0��1Ů
	
	private String deviceSex;    //�豸�Ա�,Ĭ��18
	
	private String deviceAge;    //�豸����
	
	private String deviceHeight; //�豸���
	
	private String deviceWeight; //�豸����
	
	private String deviceDisable; //�豸�Ƿ񼤻�  0δ����,1�Ǽ���
	
	private Date deviceUpdateTime;   //�豸�ϴ�ʱ��

	private String userId;       //�󶨵��û�id
	
	private String listenType;   //�豸����״̬
	
	private String count;        //绑定次数
	
	private Integer bindCount;  //绑定人数
	
    private String belongProject;
    
    private String userName;
    
    private String firm;
	
	 private Date unbindTime;
	
	private Date first;
	
	private String deviceStatus; //ZST@20151104
	
	private String shortNumber;  //短号
	
	private String sportType;
	
	private String distance;
	
	private String energy;
	
	private String heartRate;
	
	private String uploadTime;
	
	private String nickName;
	private String type;
	private String phone;
	private String useTime;
	private String callTime;
	
	private String imei;
	private String mImei;
	private String mPhone;
	private String name;
	private String mName;
	
	private String country;
	private String city;
	private String temperature;
	private String wStatus;
    private String weather;
    private String step;
    private Date uDate;
    
    private String mac;
    private Date sportTime;
    private String sportCount;
    
	private String showFirst;
	
	
	private String orderid;
	private String fujian;
	private String dabiao_file;
	private String erweima_1;
	private String erweima_2;
	private String erweima_3;
	private String erweima_4;
	private String erweima_zip;
	
	
	
	
	public String getOrderid() {
		return orderid;
	}
	public void setOrderid(String orderid) {
		this.orderid = orderid;
	}
	public String getFujian() {
		return fujian;
	}
	public void setFujian(String fujian) {
		this.fujian = fujian;
	}
	public String getDabiao_file() {
		return dabiao_file;
	}
	public void setDabiao_file(String dabiao_file) {
		this.dabiao_file = dabiao_file;
	}
	public String getErweima_1() {
		return erweima_1;
	}
	public void setErweima_1(String erweima_1) {
		this.erweima_1 = erweima_1;
	}
	public String getErweima_2() {
		return erweima_2;
	}
	public void setErweima_2(String erweima_2) {
		this.erweima_2 = erweima_2;
	}
	public String getErweima_3() {
		return erweima_3;
	}
	public void setErweima_3(String erweima_3) {
		this.erweima_3 = erweima_3;
	}
	public String getErweima_4() {
		return erweima_4;
	}
	public void setErweima_4(String erweima_4) {
		this.erweima_4 = erweima_4;
	}
	public String getErweima_zip() {
		return erweima_zip;
	}
	public void setErweima_zip(String erweima_zip) {
		this.erweima_zip = erweima_zip;
	}
	public Integer getBindCount() {
		return bindCount;
	}
	public void setBindCount(Integer bindCount) {
		this.bindCount = bindCount;
	}
	public String getShowFirst() {
		return showFirst;
	}
	public void setShowFirst(String showFirst) {
		this.showFirst = showFirst;
	}
	public String getMac() {
		return mac;
	}
	public void setMac(String mac) {
		this.mac = mac;
	}
	public Date getSportTime() {
		return sportTime;
	}
	public void setSportTime(Date sportTime) {
		this.sportTime = sportTime;
	}
	public String getSportCount() {
		return sportCount;
	}
	public void setSportCount(String sportCount) {
		this.sportCount = sportCount;
	}
    
    
    
	public Date getuDate() {
		return uDate;
	}
	public void setuDate(Date uDate) {
		this.uDate = uDate;
	}
	public String getStep() {
		return step;
	}
	public void setStep(String step) {
		this.step = step;
	}
	public String getWeather() {
		return weather;
	}
	public void setWeather(String weather) {
		this.weather = weather;
	}
	public String getCountry() {
		return country;
	}
	public void setCountry(String country) {
		this.country = country;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getTemperature() {
		return temperature;
	}
	public void setTemperature(String temperature) {
		this.temperature = temperature;
	}
	public String getwStatus() {
		return wStatus;
	}
	public void setwStatus(String wStatus) {
		this.wStatus = wStatus;
	}
	public String getImei() {
		return imei;
	}
	public void setImei(String imei) {
		this.imei = imei;
	}
	public String getmImei() {
		return mImei;
	}
	public void setmImei(String mImei) {
		this.mImei = mImei;
	}
	public String getmPhone() {
		return mPhone;
	}
	public void setmPhone(String mPhone) {
		this.mPhone = mPhone;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getmName() {
		return mName;
	}
	public void setmName(String mName) {
		this.mName = mName;
	}
	public String getNickName() {
		return nickName;
	}
	public void setNickName(String nickName) {
		this.nickName = nickName;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getUseTime() {
		return useTime;
	}
	public void setUseTime(String useTime) {
		this.useTime = useTime;
	}
	public String getCallTime() {
		return callTime;
	}
	public void setCallTime(String callTime) {
		this.callTime = callTime;
	}
	public String getSportType() {
		return sportType;
	}
	public void setSportType(String sportType) {
		this.sportType = sportType;
	}
	public String getDistance() {
		return distance;
	}
	public void setDistance(String distance) {
		this.distance = distance;
	}
	public String getEnergy() {
		return energy;
	}
	public void setEnergy(String energy) {
		this.energy = energy;
	}
	public String getHeartRate() {
		return heartRate;
	}
	public void setHeartRate(String heartRate) {
		this.heartRate = heartRate;
	}
	public String getUploadTime() {
		return uploadTime;
	}
	public void setUploadTime(String uploadTime) {
		this.uploadTime = uploadTime;
	}
	public Date getUnbindTime() {
		return unbindTime;
	}
	public void setUnbindTime(Date unbindTime) {
		this.unbindTime = unbindTime;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
		
	public String getDeviceStatus() {
		return deviceStatus;
	}
	public String getShortNumber() {
		return shortNumber;
	}
	public void setShortNumber(String shortNumber) {
		this.shortNumber = shortNumber;
	}
	public void setDeviceStatus(String deviceStatus) {
		this.deviceStatus = deviceStatus;
	}
	
	public String getBelongProject() {
		return belongProject;
	}
	public void setBelongProject(String belongProject) {
		this.belongProject = belongProject;
	}
		
	public String getListenType() {
		return listenType;
	}
	
	public int getId() {
		return id;
	}


	public void setId(int id) {
		this.id = id;
	}


	public void setListenType(String listenType) {
		this.listenType = listenType;
	}

	public String getCount() {
		return count;
	}

	public void setCount(String count) {
		this.count = count;
	}



	
	public Date getDeviceUpdateTime() {
		return deviceUpdateTime;
	}
	public void setDeviceUpdateTime(Date deviceUpdateTime) {
		this.deviceUpdateTime = deviceUpdateTime;
	}
	public String getDeviceDisable() {
		return deviceDisable;
	}

	public void setDeviceDisable(String deviceDisable) {
		this.deviceDisable = deviceDisable;
	}

	public String getDeviceWeight() {
		return deviceWeight;
	}

	public void setDeviceWeight(String deviceWeight) {
		this.deviceWeight = deviceWeight;
	}

	public String getDeviceHeight() {
		return deviceHeight;
	}

	public void setDeviceHeight(String deviceHeight) {
		this.deviceHeight = deviceHeight;
	}

	public String getDeviceAge() {
		return deviceAge;
	}

	public void setDeviceAge(String deviceAge) {
		this.deviceAge = deviceAge;
	}

	public String getDeviceSex() {
		return deviceSex;
	}

	public void setDeviceSex(String deviceSex) {
		this.deviceSex = deviceSex;
	}

	public String getDeviceHead() {
		return deviceHead;
	}

	public void setDeviceHead(String deviceHead) {
		this.deviceHead = deviceHead;
	}

	public String getDeviceName() {
		return deviceName;
	}

	public void setDeviceName(String deviceName) {
		this.deviceName = deviceName;
	}

	public String getDevicePhone() {
		return devicePhone;
	}

	public void setDevicePhone(String devicePhone) {
		this.devicePhone = devicePhone;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getDeviceImei() {
		return deviceImei;
	}

	public void setDeviceImei(String deviceImei) {
		this.deviceImei = deviceImei;
	}
	public String getFirm() {
		return firm;
	}
	public void setFirm(String firm) {
		this.firm = firm;
	}
	public Date getFirst() {
		return first;
	}
	public void setFirst(Date first) {
		this.first = first;
	}
	
		
}
