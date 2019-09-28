package com.care.sys.msginfo.domain;

import java.io.Serializable;
import java.util.Date;

import com.godoing.rose.http.PublicVoBean;

public class MsgInfo extends PublicVoBean implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1182518760078612839L;

	private String fromId;   //�û�id
	
	private String toId; //�豸id
	
	private String isHandler; //�Ƿ���,0��δ����,1��ʾ�Ѵ���

	private String msgLevel;  //��Ϣ���ȼ�
	
	private String msgContent; //��Ϣ����
	
	private Date msgHandlerDate; //��Ϣ����ʱ��
	
    private String belongProject;
    
    private Date msgOccurDate;  //ZST@20151111
    
    private String order_id;
    private String phone;
    private String fahuo_wuliu;
    private String wuliu_bianma;
    private String remark;
    private String add_user;
    private String name;
    private String cishu;
    private String jiaofutime;
    private String mi;
    private String gongyingshang;
    private String mianliao;
    private String guize;
    private String yongtu; 
    private String url; 
    
	
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getYongtu() {
		return yongtu;
	}
	public void setYongtu(String yongtu) {
		this.yongtu = yongtu;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getCishu() {
		return cishu;
	}
	public void setCishu(String cishu) {
		this.cishu = cishu;
	}
	public String getJiaofutime() {
		return jiaofutime;
	}
	public void setJiaofutime(String jiaofutime) {
		this.jiaofutime = jiaofutime;
	}
	public String getMi() {
		return mi;
	}
	public void setMi(String mi) {
		this.mi = mi;
	}
	public String getGongyingshang() {
		return gongyingshang;
	}
	public void setGongyingshang(String gongyingshang) {
		this.gongyingshang = gongyingshang;
	}
	public String getMianliao() {
		return mianliao;
	}
	public void setMianliao(String mianliao) {
		this.mianliao = mianliao;
	}
	public String getGuize() {
		return guize;
	}
	public void setGuize(String guize) {
		this.guize = guize;
	}
	public String getOrder_id() {
		return order_id;
	}
	public void setOrder_id(String order_id) {
		this.order_id = order_id;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getFahuo_wuliu() {
		return fahuo_wuliu;
	}
	public void setFahuo_wuliu(String fahuo_wuliu) {
		this.fahuo_wuliu = fahuo_wuliu;
	}
	public String getWuliu_bianma() {
		return wuliu_bianma;
	}
	public void setWuliu_bianma(String wuliu_bianma) {
		this.wuliu_bianma = wuliu_bianma;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public String getAdd_user() {
		return add_user;
	}
	public void setAdd_user(String add_user) {
		this.add_user = add_user;
	}
	public String getBelongProject() {
		return belongProject;
	}
	public void setBelongProject(String belongProject) {
		this.belongProject = belongProject;
	}
	public String getFromId() {
		return fromId;
	}

	public void setFromId(String fromId) {
		this.fromId = fromId;
	}

	public String getToId() {
		return toId;
	}

	public void setToId(String toId) {
		this.toId = toId;
	}

	public String getIsHandler() {
		return isHandler;
	}

	public void setIsHandler(String isHandler) {
		this.isHandler = isHandler;
	}

	public String getMsgLevel() {
		return msgLevel;
	}

	public void setMsgLevel(String msgLevel) {
		this.msgLevel = msgLevel;
	}

	public String getMsgContent() {
		return msgContent;
	}

	public void setMsgContent(String msgContent) {
		this.msgContent = msgContent;
	}

	public Date getMsgHandlerDate() {
		return msgHandlerDate;
	}

	public void setMsgHandlerDate(Date msgHandlerDate) {
		this.msgHandlerDate = msgHandlerDate;
	}
	public Date getMsgOccurDate() {
		return msgOccurDate;
	}
	public void setMsgOccurDate(Date msgOccurDate) {
		this.msgOccurDate = msgOccurDate;
	}
	
	
}
