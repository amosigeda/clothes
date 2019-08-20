package com.care.sys.projectinfo.domain;

import java.io.Serializable;
import java.util.Date;

import com.godoing.rose.http.PublicVoBean;

public class ProjectInfo extends PublicVoBean implements Serializable{
	private static final long serialVersionUID = 1L;
	public ProjectInfo(){
		
	}
	private Integer id;
	private String orderId;
	private String wwName;
	private String salePrice;
	private String wechat;
	private String orderNumber;
	private String kehuPhone;
	private String orderType;
	private String kehuName;
	private String qudao;
	private String xiadanKeFu;
	private String address;
	private String height;
	private String weight;
	private String age;
	private String sex;
	private String jiankuanA;
	private String lingweiB;
	private String xiongweiA;
	private String xiongweiB;
	private String zhongyaoA;
	private String zhongyaoB;
	private String fuweiA;
	private String fuweiB;
	private String houzhongyichangA;
	private String xiuchangB;
	private String qianyichangA;
	private String xiufeiB;
	private String xiuchangA;
	private String xiukouB;
	private String xiufeiA;
	private String lingkoukuaishiB;
	private String xiukouA;
	private String yichangB;
	private String kuchangC;
	private String xiongweiD;
	private String yaoweiC;
	private String zhongyaoD;
	private String tuiweiC;
	private String yichangD;
	private String dangweiC;
	private String datuiC;
	private String zhongtuiC;
	private String xiaotuiC;
	private String tuikouC;
	private String kouxingC;
	private String kouseC;
	private String kuanxingD;
	private String botouD;
	private String koudaiC;
	private String daigai;
	private String pingxiedai;
	private String miaoliao1;
	private String yongtu1;
	private String miaoliao2;
	private String yongtu2;
	private String tixingremark;
	
	
	private String projectNo;
	private String projectName;
	private String channelId;
	private String companyId;
	private String status;
	private Date addTime;
	private String remark;
	private String projectStatus;
	private Integer idP;
	private String roleCodeP;
	private String mName;
	private String projectCode;
	private String need;
	private String heartS;
	private int shiqu;
	private Integer projectType;  //��Ŀ���ͣ�1��λ��2������3����
	private Integer dataSourceC; //���� LBS���Դ��1���ߵ£�2���MiNiGps 0�� 
	private Integer dataSourceO;  //���� LBS���Դ ��1���ߵ� 2MiNiGps 0��
	private Integer mapTypeC;  //���ڵ�ͼ���� ͼ�̣�1���ߵµ�ͼ��2���Google��ͼ��0���û��ͼ
	private Integer mapTypeO;  //�����ҵ�ͼ���� ͼ�̣�1���ߵµ�ͼ��2���Google��ͼ��0���û��ͼ
	private String socketWay;  //Socket���ӷ�����1���mina������ӣ�2���ֱ��socket,0�����
	private String locationSwitch;
	private String beifen;
	
	private String adTitle;
	private String adDetail;
	
	private Date updateTime;
	
	
	
	
	
	
	
	
	public Date getUpdateTime() {
		return updateTime;
	}
	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}
	public String getOrderId() {
		return orderId;
	}
	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}
	public String getWwName() {
		return wwName;
	}
	public void setWwName(String wwName) {
		this.wwName = wwName;
	}
	public String getSalePrice() {
		return salePrice;
	}
	public void setSalePrice(String salePrice) {
		this.salePrice = salePrice;
	}
	public String getWechat() {
		return wechat;
	}
	public void setWechat(String wechat) {
		this.wechat = wechat;
	}
	public String getOrderNumber() {
		return orderNumber;
	}
	public void setOrderNumber(String orderNumber) {
		this.orderNumber = orderNumber;
	}
	public String getKehuPhone() {
		return kehuPhone;
	}
	public void setKehuPhone(String kehuPhone) {
		this.kehuPhone = kehuPhone;
	}
	public String getOrderType() {
		return orderType;
	}
	public void setOrderType(String orderType) {
		this.orderType = orderType;
	}
	public String getKehuName() {
		return kehuName;
	}
	public void setKehuName(String kehuName) {
		this.kehuName = kehuName;
	}
	public String getQudao() {
		return qudao;
	}
	public void setQudao(String qudao) {
		this.qudao = qudao;
	}
	public String getXiadanKeFu() {
		return xiadanKeFu;
	}
	public void setXiadanKeFu(String xiadanKeFu) {
		this.xiadanKeFu = xiadanKeFu;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getHeight() {
		return height;
	}
	public void setHeight(String height) {
		this.height = height;
	}
	public String getWeight() {
		return weight;
	}
	public void setWeight(String weight) {
		this.weight = weight;
	}
	public String getAge() {
		return age;
	}
	public void setAge(String age) {
		this.age = age;
	}
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	public String getJiankuanA() {
		return jiankuanA;
	}
	public void setJiankuanA(String jiankuanA) {
		this.jiankuanA = jiankuanA;
	}
	public String getLingweiB() {
		return lingweiB;
	}
	public void setLingweiB(String lingweiB) {
		this.lingweiB = lingweiB;
	}
	public String getXiongweiA() {
		return xiongweiA;
	}
	public void setXiongweiA(String xiongweiA) {
		this.xiongweiA = xiongweiA;
	}
	public String getXiongweiB() {
		return xiongweiB;
	}
	public void setXiongweiB(String xiongweiB) {
		this.xiongweiB = xiongweiB;
	}
	public String getZhongyaoA() {
		return zhongyaoA;
	}
	public void setZhongyaoA(String zhongyaoA) {
		this.zhongyaoA = zhongyaoA;
	}
	public String getZhongyaoB() {
		return zhongyaoB;
	}
	public void setZhongyaoB(String zhongyaoB) {
		this.zhongyaoB = zhongyaoB;
	}
	public String getFuweiA() {
		return fuweiA;
	}
	public void setFuweiA(String fuweiA) {
		this.fuweiA = fuweiA;
	}
	public String getFuweiB() {
		return fuweiB;
	}
	public void setFuweiB(String fuweiB) {
		this.fuweiB = fuweiB;
	}
	public String getHouzhongyichangA() {
		return houzhongyichangA;
	}
	public void setHouzhongyichangA(String houzhongyichangA) {
		this.houzhongyichangA = houzhongyichangA;
	}
	public String getXiuchangB() {
		return xiuchangB;
	}
	public void setXiuchangB(String xiuchangB) {
		this.xiuchangB = xiuchangB;
	}
	public String getQianyichangA() {
		return qianyichangA;
	}
	public void setQianyichangA(String qianyichangA) {
		this.qianyichangA = qianyichangA;
	}
	public String getXiufeiB() {
		return xiufeiB;
	}
	public void setXiufeiB(String xiufeiB) {
		this.xiufeiB = xiufeiB;
	}
	public String getXiuchangA() {
		return xiuchangA;
	}
	public void setXiuchangA(String xiuchangA) {
		this.xiuchangA = xiuchangA;
	}
	public String getXiukouB() {
		return xiukouB;
	}
	public void setXiukouB(String xiukouB) {
		this.xiukouB = xiukouB;
	}
	public String getXiufeiA() {
		return xiufeiA;
	}
	public void setXiufeiA(String xiufeiA) {
		this.xiufeiA = xiufeiA;
	}
	public String getLingkoukuaishiB() {
		return lingkoukuaishiB;
	}
	public void setLingkoukuaishiB(String lingkoukuaishiB) {
		this.lingkoukuaishiB = lingkoukuaishiB;
	}
	public String getXiukouA() {
		return xiukouA;
	}
	public void setXiukouA(String xiukouA) {
		this.xiukouA = xiukouA;
	}
	public String getYichangB() {
		return yichangB;
	}
	public void setYichangB(String yichangB) {
		this.yichangB = yichangB;
	}
	public String getKuchangC() {
		return kuchangC;
	}
	public void setKuchangC(String kuchangC) {
		this.kuchangC = kuchangC;
	}
	public String getXiongweiD() {
		return xiongweiD;
	}
	public void setXiongweiD(String xiongweiD) {
		this.xiongweiD = xiongweiD;
	}
	public String getYaoweiC() {
		return yaoweiC;
	}
	public void setYaoweiC(String yaoweiC) {
		this.yaoweiC = yaoweiC;
	}
	public String getZhongyaoD() {
		return zhongyaoD;
	}
	public void setZhongyaoD(String zhongyaoD) {
		this.zhongyaoD = zhongyaoD;
	}
	public String getTuiweiC() {
		return tuiweiC;
	}
	public void setTuiweiC(String tuiweiC) {
		this.tuiweiC = tuiweiC;
	}
	public String getYichangD() {
		return yichangD;
	}
	public void setYichangD(String yichangD) {
		this.yichangD = yichangD;
	}
	public String getDangweiC() {
		return dangweiC;
	}
	public void setDangweiC(String dangweiC) {
		this.dangweiC = dangweiC;
	}
	public String getDatuiC() {
		return datuiC;
	}
	public void setDatuiC(String datuiC) {
		this.datuiC = datuiC;
	}
	public String getZhongtuiC() {
		return zhongtuiC;
	}
	public void setZhongtuiC(String zhongtuiC) {
		this.zhongtuiC = zhongtuiC;
	}
	public String getXiaotuiC() {
		return xiaotuiC;
	}
	public void setXiaotuiC(String xiaotuiC) {
		this.xiaotuiC = xiaotuiC;
	}
	public String getTuikouC() {
		return tuikouC;
	}
	public void setTuikouC(String tuikouC) {
		this.tuikouC = tuikouC;
	}
	public String getKouxingC() {
		return kouxingC;
	}
	public void setKouxingC(String kouxingC) {
		this.kouxingC = kouxingC;
	}
	public String getKouseC() {
		return kouseC;
	}
	public void setKouseC(String kouseC) {
		this.kouseC = kouseC;
	}
	public String getKuanxingD() {
		return kuanxingD;
	}
	public void setKuanxingD(String kuanxingD) {
		this.kuanxingD = kuanxingD;
	}
	public String getBotouD() {
		return botouD;
	}
	public void setBotouD(String botouD) {
		this.botouD = botouD;
	}
	public String getKoudaiC() {
		return koudaiC;
	}
	public void setKoudaiC(String koudaiC) {
		this.koudaiC = koudaiC;
	}
	public String getDaigai() {
		return daigai;
	}
	public void setDaigai(String daigai) {
		this.daigai = daigai;
	}
	public String getPingxiedai() {
		return pingxiedai;
	}
	public void setPingxiedai(String pingxiedai) {
		this.pingxiedai = pingxiedai;
	}
	public String getMiaoliao1() {
		return miaoliao1;
	}
	public void setMiaoliao1(String miaoliao1) {
		this.miaoliao1 = miaoliao1;
	}
	public String getYongtu1() {
		return yongtu1;
	}
	public void setYongtu1(String yongtu1) {
		this.yongtu1 = yongtu1;
	}
	public String getMiaoliao2() {
		return miaoliao2;
	}
	public void setMiaoliao2(String miaoliao2) {
		this.miaoliao2 = miaoliao2;
	}
	public String getYongtu2() {
		return yongtu2;
	}
	public void setYongtu2(String yongtu2) {
		this.yongtu2 = yongtu2;
	}
	public String getTixingremark() {
		return tixingremark;
	}
	public void setTixingremark(String tixingremark) {
		this.tixingremark = tixingremark;
	}
	public String getAdTitle() {
		return adTitle;
	}
	public void setAdTitle(String adTitle) {
		this.adTitle = adTitle;
	}
	public String getAdDetail() {
		return adDetail;
	}
	public void setAdDetail(String adDetail) {
		this.adDetail = adDetail;
	}
	public String getNeed() {
		return need;
	}
	public void setNeed(String need) {
		this.need = need;
	}
	public String getHeartS() {
		return heartS;
	}
	public void setHeartS(String heartS) {
		this.heartS = heartS;
	}
	public int getShiqu() {
		return shiqu;
	}
	public void setShiqu(int shiqu) {
		this.shiqu = shiqu;
	}
	public Integer getProjectType() {
		return projectType;
	}
	public void setProjectType(Integer projectType) {
		this.projectType = projectType;
	}
	public Integer getDataSourceC() {
		return dataSourceC;
	}
	public void setDataSourceC(Integer dataSourceC) {
		this.dataSourceC = dataSourceC;
	}
	public Integer getDataSourceO() {
		return dataSourceO;
	}
	public void setDataSourceO(Integer dataSourceO) {
		this.dataSourceO = dataSourceO;
	}
	public Integer getMapTypeC() {
		return mapTypeC;
	}
	public void setMapTypeC(Integer mapTypeC) {
		this.mapTypeC = mapTypeC;
	}
	public Integer getMapTypeO() {
		return mapTypeO;
	}
	public void setMapTypeO(Integer mapTypeO) {
		this.mapTypeO = mapTypeO;
	}
	
	public String getSocketWay() {
		return socketWay;
	}
	public void setSocketWay(String socketWay) {
		this.socketWay = socketWay;
	}
	public String getBeifen() {
		return beifen;
	}
	public void setBeifen(String beifen) {
		this.beifen = beifen;
	}
	public String getLocationSwitch() {
		return locationSwitch;
	}
	public void setLocationSwitch(String locationSwitch) {
		this.locationSwitch = locationSwitch;
	}
	public Date getAddTime() {
		return addTime;
	}
	public void setAddTime(Date addTime) {
		this.addTime = addTime;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getProjectNo() {
		return projectNo;
	}
	public void setProjectNo(String projectNo) {
		this.projectNo = projectNo;
	}
	public String getProjectName() {
		return projectName;
	}
	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}
	
	public String getChannelId() {
		return channelId;
	}
	public void setChannelId(String channelId) {
		this.channelId = channelId;
	}
	public String getCompanyId() {
		return companyId;
	}
	public void setCompanyId(String companyId) {
		this.companyId = companyId;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
	public Integer getIdP() {
		return idP;
	}
	public void setIdP(Integer idP) {
		this.idP = idP;
	}
	public String getRoleCodeP() {
		return roleCodeP;
	}
	public void setRoleCodeP(String roleCodeP) {
		this.roleCodeP = roleCodeP;
	}
	
	public String getmName() {
		return mName;
	}
	public void setmName(String mName) {
		this.mName = mName;
	}
	public String getProjectCode() {
		return projectCode;
	}
	public void setProjectCode(String projectCode) {
		this.projectCode = projectCode;
	}
	public String getProjectStatus() {
		return projectStatus;
	}
	public void setProjectStatus(String projectStatus) {
		this.projectStatus = projectStatus;
	}
	

}
