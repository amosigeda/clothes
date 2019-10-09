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
	private String jiankuan_a;
	public String getJiankuan_a() {
		return jiankuan_a;
	}
	public void setJiankuan_a(String jiankuan_a) {
		this.jiankuan_a = jiankuan_a;
	}
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
	private String xiufeiA2;
	
	
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
	
	
	private String jiankuanA2;
	private String lingweiB2;
	private String xiongweiA2;
	private String xiongweiB2;
	private String zhongyaoA2;
	private String zhongyaoB2;
	private String fuweiA2;
	private String fuweiB2;
	private String houzhongyichangA2;
	private String xiuchangB2;
	private String qianyichangA2;
	private String xiufeiB2;
	private String xiuchangA2;
	private String xiukouB2;
	private String lingkoukuaishiB2;
	private String xiukouA2;
	private String yichangB2;
	private String kuchangC2;
	private String xiongweiD2;
	private String yaoweiC2;
	private String zhongyaoD2;
	private String tuiweiC2;
	private String yichangD2;
	private String dangweiC2;
	private String datuiC2;
	private String zhongtuiC2;
	private String xiaotuiC2;
	private String tuikouC2;
	private String mi1;
	private String mi2;
	private String pidanremark;
	private String yaoweiC22;
	private String xiongweiB22;
	
	private String gongyingshang1;
	private String gongyingshang2;
	private String dadanStatus;
	
	private Date jiaoLiaoTime;
	private String xizhuang_number;
	private String chenshan_number;
	private String xiku_number;
	private String majia_number;
	
	private Date pidan_time;
	private Date gendan_tijiao_time;
	private Date tuihui_time;
	
	private String gendan_fuze;
	private String gd_remark;
	
	
	private String yi_ma;
	private String chenshan_ma;
	private String ku_ma;
	private String majia_ma;
	
	private String jiaofu_time;
	
	
	private String kaicha;
	private String xiabai;
	private String zhuangse;
	private String waizhubian;
	private String xiucha;
	private String kuyao;
	private String kuxing;
	private String chenshanling;
	private String chenshanxiu;
	private String jiankuannew;
	private String dakuang1;
	private String dakuang2;
	private String dakuang3;
	private String dakuang4;
	
	private String fujian_url;
	
	private String xc_que;
	private String yichang_q;
	private String xiukou_que;
	private String fuwei_quea;
	private String fuwei_queb;
	
	
	private String jiankuanque;
	
	
	
	
	
	    private String ml1; 
	    private String ml2; 
	    private String ml3; 
	    private String ml4; 
	    private String ml5; 
	    private String ml6; 
	    private String ml7; 
	    private String ml8; 
	    private String ml9; 
	    private String ml10; 
	    private String ml11; 
	    private String ml12; 
	    private String ml13; 
	    private String ml14; 
	   

	    private String yt1; 
	    private String yt2; 
	    private String yt3; 
	    private String yt4; 
	    private String yt5; 
	    private String yt6; 
	    private String yt7; 
	    private String yt8; 
	    private String yt9; 
	    private String yt10; 
	    private String yt11; 
	    private String yt12; 
	    private String yt13; 
	    private String yt14; 
	  

	    private String ms1; 
	    private String ms2; 
	    private String ms3; 
	    private String ms4; 
	    private String ms5; 
	    private String ms6; 
	    private String ms7; 
	    private String ms8; 
	    private String ms9; 
	    private String ms10; 
	    private String ms11; 
	    private String ms12; 
	    private String ms13; 
	    private String ms14; 

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
	    
	    
	
	public String getMl14() {
			return ml14;
		}
		public void setMl14(String ml14) {
			this.ml14 = ml14;
		}
		public String getYt14() {
			return yt14;
		}
		public void setYt14(String yt14) {
			this.yt14 = yt14;
		}
		public String getMs14() {
			return ms14;
		}
		public void setMs14(String ms14) {
			this.ms14 = ms14;
		}
		public String getGys14() {
			return gys14;
		}
		public void setGys14(String gys14) {
			this.gys14 = gys14;
		}
	public String getMl1() {
			return ml1;
		}
		public void setMl1(String ml1) {
			this.ml1 = ml1;
		}
		public String getMl2() {
			return ml2;
		}
		public void setMl2(String ml2) {
			this.ml2 = ml2;
		}
		public String getMl3() {
			return ml3;
		}
		public void setMl3(String ml3) {
			this.ml3 = ml3;
		}
		public String getMl4() {
			return ml4;
		}
		public void setMl4(String ml4) {
			this.ml4 = ml4;
		}
		public String getMl5() {
			return ml5;
		}
		public void setMl5(String ml5) {
			this.ml5 = ml5;
		}
		public String getMl6() {
			return ml6;
		}
		public void setMl6(String ml6) {
			this.ml6 = ml6;
		}
		public String getMl7() {
			return ml7;
		}
		public void setMl7(String ml7) {
			this.ml7 = ml7;
		}
		public String getMl8() {
			return ml8;
		}
		public void setMl8(String ml8) {
			this.ml8 = ml8;
		}
		public String getMl9() {
			return ml9;
		}
		public void setMl9(String ml9) {
			this.ml9 = ml9;
		}
		public String getMl10() {
			return ml10;
		}
		public void setMl10(String ml10) {
			this.ml10 = ml10;
		}
		public String getMl11() {
			return ml11;
		}
		public void setMl11(String ml11) {
			this.ml11 = ml11;
		}
		public String getMl12() {
			return ml12;
		}
		public void setMl12(String ml12) {
			this.ml12 = ml12;
		}
		public String getMl13() {
			return ml13;
		}
		public void setMl13(String ml13) {
			this.ml13 = ml13;
		}
		public String getYt1() {
			return yt1;
		}
		public void setYt1(String yt1) {
			this.yt1 = yt1;
		}
		public String getYt2() {
			return yt2;
		}
		public void setYt2(String yt2) {
			this.yt2 = yt2;
		}
		public String getYt3() {
			return yt3;
		}
		public void setYt3(String yt3) {
			this.yt3 = yt3;
		}
		public String getYt4() {
			return yt4;
		}
		public void setYt4(String yt4) {
			this.yt4 = yt4;
		}
		public String getYt5() {
			return yt5;
		}
		public void setYt5(String yt5) {
			this.yt5 = yt5;
		}
		public String getYt6() {
			return yt6;
		}
		public void setYt6(String yt6) {
			this.yt6 = yt6;
		}
		public String getYt7() {
			return yt7;
		}
		public void setYt7(String yt7) {
			this.yt7 = yt7;
		}
		public String getYt8() {
			return yt8;
		}
		public void setYt8(String yt8) {
			this.yt8 = yt8;
		}
		public String getYt9() {
			return yt9;
		}
		public void setYt9(String yt9) {
			this.yt9 = yt9;
		}
		public String getYt10() {
			return yt10;
		}
		public void setYt10(String yt10) {
			this.yt10 = yt10;
		}
		public String getYt11() {
			return yt11;
		}
		public void setYt11(String yt11) {
			this.yt11 = yt11;
		}
		public String getYt12() {
			return yt12;
		}
		public void setYt12(String yt12) {
			this.yt12 = yt12;
		}
		public String getYt13() {
			return yt13;
		}
		public void setYt13(String yt13) {
			this.yt13 = yt13;
		}
		public String getMs1() {
			return ms1;
		}
		public void setMs1(String ms1) {
			this.ms1 = ms1;
		}
		public String getMs2() {
			return ms2;
		}
		public void setMs2(String ms2) {
			this.ms2 = ms2;
		}
		public String getMs3() {
			return ms3;
		}
		public void setMs3(String ms3) {
			this.ms3 = ms3;
		}
		public String getMs4() {
			return ms4;
		}
		public void setMs4(String ms4) {
			this.ms4 = ms4;
		}
		public String getMs5() {
			return ms5;
		}
		public void setMs5(String ms5) {
			this.ms5 = ms5;
		}
		public String getMs6() {
			return ms6;
		}
		public void setMs6(String ms6) {
			this.ms6 = ms6;
		}
		public String getMs7() {
			return ms7;
		}
		public void setMs7(String ms7) {
			this.ms7 = ms7;
		}
		public String getMs8() {
			return ms8;
		}
		public void setMs8(String ms8) {
			this.ms8 = ms8;
		}
		public String getMs9() {
			return ms9;
		}
		public void setMs9(String ms9) {
			this.ms9 = ms9;
		}
		public String getMs10() {
			return ms10;
		}
		public void setMs10(String ms10) {
			this.ms10 = ms10;
		}
		public String getMs11() {
			return ms11;
		}
		public void setMs11(String ms11) {
			this.ms11 = ms11;
		}
		public String getMs12() {
			return ms12;
		}
		public void setMs12(String ms12) {
			this.ms12 = ms12;
		}
		public String getMs13() {
			return ms13;
		}
		public void setMs13(String ms13) {
			this.ms13 = ms13;
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
	public String getJiankuanque() {
		return jiankuanque;
	}
	public void setJiankuanque(String jiankuanque) {
		this.jiankuanque = jiankuanque;
	}
	public String getXc_que() {
		return xc_que;
	}
	public void setXc_que(String xc_que) {
		this.xc_que = xc_que;
	}
	public String getYichang_q() {
		return yichang_q;
	}
	public void setYichang_q(String yichang_q) {
		this.yichang_q = yichang_q;
	}
	public String getXiukou_que() {
		return xiukou_que;
	}
	public void setXiukou_que(String xiukou_que) {
		this.xiukou_que = xiukou_que;
	}
	public String getFuwei_quea() {
		return fuwei_quea;
	}
	public void setFuwei_quea(String fuwei_quea) {
		this.fuwei_quea = fuwei_quea;
	}
	public String getFuwei_queb() {
		return fuwei_queb;
	}
	public void setFuwei_queb(String fuwei_queb) {
		this.fuwei_queb = fuwei_queb;
	}
	public String getFujian_url() {
		return fujian_url;
	}
	public void setFujian_url(String fujian_url) {
		this.fujian_url = fujian_url;
	}
	public String getDakuang1() {
		return dakuang1;
	}
	public void setDakuang1(String dakuang1) {
		this.dakuang1 = dakuang1;
	}
	public String getDakuang2() {
		return dakuang2;
	}
	public void setDakuang2(String dakuang2) {
		this.dakuang2 = dakuang2;
	}
	public String getDakuang3() {
		return dakuang3;
	}
	public void setDakuang3(String dakuang3) {
		this.dakuang3 = dakuang3;
	}
	public String getDakuang4() {
		return dakuang4;
	}
	public void setDakuang4(String dakuang4) {
		this.dakuang4 = dakuang4;
	}
	public String getJiankuannew() {
		return jiankuannew;
	}
	public void setJiankuannew(String jiankuannew) {
		this.jiankuannew = jiankuannew;
	}
	public String getKaicha() {
		return kaicha;
	}
	public void setKaicha(String kaicha) {
		this.kaicha = kaicha;
	}
	public String getXiabai() {
		return xiabai;
	}
	public void setXiabai(String xiabai) {
		this.xiabai = xiabai;
	}
	public String getZhuangse() {
		return zhuangse;
	}
	public void setZhuangse(String zhuangse) {
		this.zhuangse = zhuangse;
	}
	public String getWaizhubian() {
		return waizhubian;
	}
	public void setWaizhubian(String waizhubian) {
		this.waizhubian = waizhubian;
	}
	public String getXiucha() {
		return xiucha;
	}
	public void setXiucha(String xiucha) {
		this.xiucha = xiucha;
	}
	public String getKuyao() {
		return kuyao;
	}
	public void setKuyao(String kuyao) {
		this.kuyao = kuyao;
	}
	public String getKuxing() {
		return kuxing;
	}
	public void setKuxing(String kuxing) {
		this.kuxing = kuxing;
	}
	public String getChenshanling() {
		return chenshanling;
	}
	public void setChenshanling(String chenshanling) {
		this.chenshanling = chenshanling;
	}
	public String getChenshanxiu() {
		return chenshanxiu;
	}
	public void setChenshanxiu(String chenshanxiu) {
		this.chenshanxiu = chenshanxiu;
	}
	public String getJiaofu_time() {
		return jiaofu_time;
	}
	public void setJiaofu_time(String jiaofu_time) {
		this.jiaofu_time = jiaofu_time;
	}
	public String getYi_ma() {
		return yi_ma;
	}
	public void setYi_ma(String yi_ma) {
		this.yi_ma = yi_ma;
	}
	public String getChenshan_ma() {
		return chenshan_ma;
	}
	public void setChenshan_ma(String chenshan_ma) {
		this.chenshan_ma = chenshan_ma;
	}
	public String getKu_ma() {
		return ku_ma;
	}
	public void setKu_ma(String ku_ma) {
		this.ku_ma = ku_ma;
	}
	public String getMajia_ma() {
		return majia_ma;
	}
	public void setMajia_ma(String majia_ma) {
		this.majia_ma = majia_ma;
	}
	public String getGd_remark() {
		return gd_remark;
	}
	public void setGd_remark(String gd_remark) {
		this.gd_remark = gd_remark;
	}
	public Date getTuihui_time() {
		return tuihui_time;
	}
	public void setTuihui_time(Date tuihui_time) {
		this.tuihui_time = tuihui_time;
	}
	public Date getGendan_tijiao_time() {
		return gendan_tijiao_time;
	}
	public void setGendan_tijiao_time(Date gendan_tijiao_time) {
		this.gendan_tijiao_time = gendan_tijiao_time;
	}
	public String getGendan_fuze() {
		return gendan_fuze;
	}
	public void setGendan_fuze(String gendan_fuze) {
		this.gendan_fuze = gendan_fuze;
	}
	public Date getPidan_time() {
		return pidan_time;
	}
	public void setPidan_time(Date pidan_time) {
		this.pidan_time = pidan_time;
	}
	public String getXizhuang_number() {
		return xizhuang_number;
	}
	public void setXizhuang_number(String xizhuang_number) {
		this.xizhuang_number = xizhuang_number;
	}
	public String getChenshan_number() {
		return chenshan_number;
	}
	public void setChenshan_number(String chenshan_number) {
		this.chenshan_number = chenshan_number;
	}
	public String getXiku_number() {
		return xiku_number;
	}
	public void setXiku_number(String xiku_number) {
		this.xiku_number = xiku_number;
	}
	public String getMajia_number() {
		return majia_number;
	}
	public void setMajia_number(String majia_number) {
		this.majia_number = majia_number;
	}
	public Date getJiaoLiaoTime() {
		return jiaoLiaoTime;
	}
	public void setJiaoLiaoTime(Date jiaoLiaoTime) {
		this.jiaoLiaoTime = jiaoLiaoTime;
	}
	public String getDadanStatus() {
		return dadanStatus;
	}
	public void setDadanStatus(String dadanStatus) {
		this.dadanStatus = dadanStatus;
	}
	public String getGongyingshang1() {
		return gongyingshang1;
	}
	public void setGongyingshang1(String gongyingshang1) {
		this.gongyingshang1 = gongyingshang1;
	}
	public String getGongyingshang2() {
		return gongyingshang2;
	}
	public void setGongyingshang2(String gongyingshang2) {
		this.gongyingshang2 = gongyingshang2;
	}
	public String getXiongweiB22() {
		return xiongweiB22;
	}
	public void setXiongweiB22(String xiongweiB22) {
		this.xiongweiB22 = xiongweiB22;
	}
	public String getYaoweiC22() {
		return yaoweiC22;
	}
	public void setYaoweiC22(String yaoweiC22) {
		this.yaoweiC22 = yaoweiC22;
	}
	public String getXiufeiA2() {
		return xiufeiA2;
	}
	public void setXiufeiA2(String xiufeiA2) {
		this.xiufeiA2 = xiufeiA2;
	}
	public String getPidanremark() {
		return pidanremark;
	}
	public void setPidanremark(String pidanremark) {
		this.pidanremark = pidanremark;
	}
	public String getJiankuanA2() {
		return jiankuanA2;
	}
	public void setJiankuanA2(String jiankuanA2) {
		this.jiankuanA2 = jiankuanA2;
	}
	public String getLingweiB2() {
		return lingweiB2;
	}
	public void setLingweiB2(String lingweiB2) {
		this.lingweiB2 = lingweiB2;
	}
	public String getXiongweiA2() {
		return xiongweiA2;
	}
	public void setXiongweiA2(String xiongweiA2) {
		this.xiongweiA2 = xiongweiA2;
	}
	public String getXiongweiB2() {
		return xiongweiB2;
	}
	public void setXiongweiB2(String xiongweiB2) {
		this.xiongweiB2 = xiongweiB2;
	}
	public String getZhongyaoA2() {
		return zhongyaoA2;
	}
	public void setZhongyaoA2(String zhongyaoA2) {
		this.zhongyaoA2 = zhongyaoA2;
	}
	public String getZhongyaoB2() {
		return zhongyaoB2;
	}
	public void setZhongyaoB2(String zhongyaoB2) {
		this.zhongyaoB2 = zhongyaoB2;
	}
	public String getFuweiA2() {
		return fuweiA2;
	}
	public void setFuweiA2(String fuweiA2) {
		this.fuweiA2 = fuweiA2;
	}
	public String getFuweiB2() {
		return fuweiB2;
	}
	public void setFuweiB2(String fuweiB2) {
		this.fuweiB2 = fuweiB2;
	}
	public String getHouzhongyichangA2() {
		return houzhongyichangA2;
	}
	public void setHouzhongyichangA2(String houzhongyichangA2) {
		this.houzhongyichangA2 = houzhongyichangA2;
	}
	public String getXiuchangB2() {
		return xiuchangB2;
	}
	public void setXiuchangB2(String xiuchangB2) {
		this.xiuchangB2 = xiuchangB2;
	}
	public String getQianyichangA2() {
		return qianyichangA2;
	}
	public void setQianyichangA2(String qianyichangA2) {
		this.qianyichangA2 = qianyichangA2;
	}
	public String getXiufeiB2() {
		return xiufeiB2;
	}
	public void setXiufeiB2(String xiufeiB2) {
		this.xiufeiB2 = xiufeiB2;
	}
	public String getXiuchangA2() {
		return xiuchangA2;
	}
	public void setXiuchangA2(String xiuchangA2) {
		this.xiuchangA2 = xiuchangA2;
	}
	public String getXiukouB2() {
		return xiukouB2;
	}
	public void setXiukouB2(String xiukouB2) {
		this.xiukouB2 = xiukouB2;
	}
	public String getLingkoukuaishiB2() {
		return lingkoukuaishiB2;
	}
	public void setLingkoukuaishiB2(String lingkoukuaishiB2) {
		this.lingkoukuaishiB2 = lingkoukuaishiB2;
	}
	public String getXiukouA2() {
		return xiukouA2;
	}
	public void setXiukouA2(String xiukouA2) {
		this.xiukouA2 = xiukouA2;
	}
	public String getYichangB2() {
		return yichangB2;
	}
	public void setYichangB2(String yichangB2) {
		this.yichangB2 = yichangB2;
	}
	public String getKuchangC2() {
		return kuchangC2;
	}
	public void setKuchangC2(String kuchangC2) {
		this.kuchangC2 = kuchangC2;
	}
	public String getXiongweiD2() {
		return xiongweiD2;
	}
	public void setXiongweiD2(String xiongweiD2) {
		this.xiongweiD2 = xiongweiD2;
	}
	public String getYaoweiC2() {
		return yaoweiC2;
	}
	public void setYaoweiC2(String yaoweiC2) {
		this.yaoweiC2 = yaoweiC2;
	}
	public String getZhongyaoD2() {
		return zhongyaoD2;
	}
	public void setZhongyaoD2(String zhongyaoD2) {
		this.zhongyaoD2 = zhongyaoD2;
	}
	public String getTuiweiC2() {
		return tuiweiC2;
	}
	public void setTuiweiC2(String tuiweiC2) {
		this.tuiweiC2 = tuiweiC2;
	}
	public String getYichangD2() {
		return yichangD2;
	}
	public void setYichangD2(String yichangD2) {
		this.yichangD2 = yichangD2;
	}
	public String getDangweiC2() {
		return dangweiC2;
	}
	public void setDangweiC2(String dangweiC2) {
		this.dangweiC2 = dangweiC2;
	}
	public String getDatuiC2() {
		return datuiC2;
	}
	public void setDatuiC2(String datuiC2) {
		this.datuiC2 = datuiC2;
	}
	public String getZhongtuiC2() {
		return zhongtuiC2;
	}
	public void setZhongtuiC2(String zhongtuiC2) {
		this.zhongtuiC2 = zhongtuiC2;
	}
	public String getXiaotuiC2() {
		return xiaotuiC2;
	}
	public void setXiaotuiC2(String xiaotuiC2) {
		this.xiaotuiC2 = xiaotuiC2;
	}
	public String getTuikouC2() {
		return tuikouC2;
	}
	public void setTuikouC2(String tuikouC2) {
		this.tuikouC2 = tuikouC2;
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
