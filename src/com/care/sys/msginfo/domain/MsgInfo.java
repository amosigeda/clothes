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

    private String mianliao1; 
    private String mianliao2; 
    private String mianliao3; 
    private String mianliao4; 
    private String mianliao5; 
    private String mianliao6; 
    private String mianliao7; 
    private String mianliao8; 
    private String mianliao9; 
    private String mianliao10; 
    private String mianliao11; 
    private String mianliao12; 
    private String mianliao13; 
    private String mianliao14; 

    private String yongtu1; 
    private String yongtu2; 
    private String yongtu3; 
    private String yongtu4; 
    private String yongtu5; 
    private String yongtu6; 
    private String yongtu7; 
    private String yongtu8; 
    private String yongtu9; 
    private String yongtu10; 
    private String yongtu11; 
    private String yongtu12; 
    private String yongtu13; 
    private String yongtu14; 

    private String mi1; 
    private String mi2; 
    private String mi3; 
    private String mi4; 
    private String mi5; 
    private String mi6; 
    private String mi7; 
    private String mi8; 
    private String mi9; 
    private String mi10; 
    private String mi11; 
    private String mi12; 
    private String mi13; 
    private String mi14; 

    private String gys1; 
    private String gys2; 
    private String gys3; 
    private String gys4; 
    private String gys5; 
    private String gys6; 
    private String gys7; 
    private String gys8; 
    private String gys9; 
    private String gys10; 
    private String gys11; 
    private String gys12; 
    private String gys13; 
    private String gys14; 
    
    
	
	public String getMianliao1() {
		return mianliao1;
	}
	public void setMianliao1(String mianliao1) {
		this.mianliao1 = mianliao1;
	}
	public String getMianliao2() {
		return mianliao2;
	}
	public void setMianliao2(String mianliao2) {
		this.mianliao2 = mianliao2;
	}
	public String getMianliao3() {
		return mianliao3;
	}
	public void setMianliao3(String mianliao3) {
		this.mianliao3 = mianliao3;
	}
	public String getMianliao4() {
		return mianliao4;
	}
	public void setMianliao4(String mianliao4) {
		this.mianliao4 = mianliao4;
	}
	public String getMianliao5() {
		return mianliao5;
	}
	public void setMianliao5(String mianliao5) {
		this.mianliao5 = mianliao5;
	}
	public String getMianliao6() {
		return mianliao6;
	}
	public void setMianliao6(String mianliao6) {
		this.mianliao6 = mianliao6;
	}
	public String getMianliao7() {
		return mianliao7;
	}
	public void setMianliao7(String mianliao7) {
		this.mianliao7 = mianliao7;
	}
	public String getMianliao8() {
		return mianliao8;
	}
	public void setMianliao8(String mianliao8) {
		this.mianliao8 = mianliao8;
	}
	public String getMianliao9() {
		return mianliao9;
	}
	public void setMianliao9(String mianliao9) {
		this.mianliao9 = mianliao9;
	}
	public String getMianliao10() {
		return mianliao10;
	}
	public void setMianliao10(String mianliao10) {
		this.mianliao10 = mianliao10;
	}
	public String getMianliao11() {
		return mianliao11;
	}
	public void setMianliao11(String mianliao11) {
		this.mianliao11 = mianliao11;
	}
	public String getMianliao12() {
		return mianliao12;
	}
	public void setMianliao12(String mianliao12) {
		this.mianliao12 = mianliao12;
	}
	public String getMianliao13() {
		return mianliao13;
	}
	public void setMianliao13(String mianliao13) {
		this.mianliao13 = mianliao13;
	}
	public String getMianliao14() {
		return mianliao14;
	}
	public void setMianliao14(String mianliao14) {
		this.mianliao14 = mianliao14;
	}
	public String getYongtu1() {
		return yongtu1;
	}
	public void setYongtu1(String yongtu1) {
		this.yongtu1 = yongtu1;
	}
	public String getYongtu2() {
		return yongtu2;
	}
	public void setYongtu2(String yongtu2) {
		this.yongtu2 = yongtu2;
	}
	public String getYongtu3() {
		return yongtu3;
	}
	public void setYongtu3(String yongtu3) {
		this.yongtu3 = yongtu3;
	}
	public String getYongtu4() {
		return yongtu4;
	}
	public void setYongtu4(String yongtu4) {
		this.yongtu4 = yongtu4;
	}
	public String getYongtu5() {
		return yongtu5;
	}
	public void setYongtu5(String yongtu5) {
		this.yongtu5 = yongtu5;
	}
	public String getYongtu6() {
		return yongtu6;
	}
	public void setYongtu6(String yongtu6) {
		this.yongtu6 = yongtu6;
	}
	public String getYongtu7() {
		return yongtu7;
	}
	public void setYongtu7(String yongtu7) {
		this.yongtu7 = yongtu7;
	}
	public String getYongtu8() {
		return yongtu8;
	}
	public void setYongtu8(String yongtu8) {
		this.yongtu8 = yongtu8;
	}
	public String getYongtu9() {
		return yongtu9;
	}
	public void setYongtu9(String yongtu9) {
		this.yongtu9 = yongtu9;
	}
	public String getYongtu10() {
		return yongtu10;
	}
	public void setYongtu10(String yongtu10) {
		this.yongtu10 = yongtu10;
	}
	public String getYongtu11() {
		return yongtu11;
	}
	public void setYongtu11(String yongtu11) {
		this.yongtu11 = yongtu11;
	}
	public String getYongtu12() {
		return yongtu12;
	}
	public void setYongtu12(String yongtu12) {
		this.yongtu12 = yongtu12;
	}
	public String getYongtu13() {
		return yongtu13;
	}
	public void setYongtu13(String yongtu13) {
		this.yongtu13 = yongtu13;
	}
	public String getYongtu14() {
		return yongtu14;
	}
	public void setYongtu14(String yongtu14) {
		this.yongtu14 = yongtu14;
	}
	public String getMi1() {
		return mi1;
	}
	public void setMi1(String mi1) {
		this.mi1 = mi1;
	}
	public String getMi2() {
		return mi2;
	}
	public void setMi2(String mi2) {
		this.mi2 = mi2;
	}
	public String getMi3() {
		return mi3;
	}
	public void setMi3(String mi3) {
		this.mi3 = mi3;
	}
	public String getMi4() {
		return mi4;
	}
	public void setMi4(String mi4) {
		this.mi4 = mi4;
	}
	public String getMi5() {
		return mi5;
	}
	public void setMi5(String mi5) {
		this.mi5 = mi5;
	}
	public String getMi6() {
		return mi6;
	}
	public void setMi6(String mi6) {
		this.mi6 = mi6;
	}
	public String getMi7() {
		return mi7;
	}
	public void setMi7(String mi7) {
		this.mi7 = mi7;
	}
	public String getMi8() {
		return mi8;
	}
	public void setMi8(String mi8) {
		this.mi8 = mi8;
	}
	public String getMi9() {
		return mi9;
	}
	public void setMi9(String mi9) {
		this.mi9 = mi9;
	}
	public String getMi10() {
		return mi10;
	}
	public void setMi10(String mi10) {
		this.mi10 = mi10;
	}
	public String getMi11() {
		return mi11;
	}
	public void setMi11(String mi11) {
		this.mi11 = mi11;
	}
	public String getMi12() {
		return mi12;
	}
	public void setMi12(String mi12) {
		this.mi12 = mi12;
	}
	public String getMi13() {
		return mi13;
	}
	public void setMi13(String mi13) {
		this.mi13 = mi13;
	}
	public String getMi14() {
		return mi14;
	}
	public void setMi14(String mi14) {
		this.mi14 = mi14;
	}
	public String getGys1() {
		return gys1;
	}
	public void setGys1(String gys1) {
		this.gys1 = gys1;
	}
	public String getGys2() {
		return gys2;
	}
	public void setGys2(String gys2) {
		this.gys2 = gys2;
	}
	public String getGys3() {
		return gys3;
	}
	public void setGys3(String gys3) {
		this.gys3 = gys3;
	}
	public String getGys4() {
		return gys4;
	}
	public void setGys4(String gys4) {
		this.gys4 = gys4;
	}
	public String getGys5() {
		return gys5;
	}
	public void setGys5(String gys5) {
		this.gys5 = gys5;
	}
	public String getGys6() {
		return gys6;
	}
	public void setGys6(String gys6) {
		this.gys6 = gys6;
	}
	public String getGys7() {
		return gys7;
	}
	public void setGys7(String gys7) {
		this.gys7 = gys7;
	}
	public String getGys8() {
		return gys8;
	}
	public void setGys8(String gys8) {
		this.gys8 = gys8;
	}
	public String getGys9() {
		return gys9;
	}
	public void setGys9(String gys9) {
		this.gys9 = gys9;
	}
	public String getGys10() {
		return gys10;
	}
	public void setGys10(String gys10) {
		this.gys10 = gys10;
	}
	public String getGys11() {
		return gys11;
	}
	public void setGys11(String gys11) {
		this.gys11 = gys11;
	}
	public String getGys12() {
		return gys12;
	}
	public void setGys12(String gys12) {
		this.gys12 = gys12;
	}
	public String getGys13() {
		return gys13;
	}
	public void setGys13(String gys13) {
		this.gys13 = gys13;
	}
	public String getGys14() {
		return gys14;
	}
	public void setGys14(String gys14) {
		this.gys14 = gys14;
	}
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
