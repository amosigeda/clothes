package com.care.sys.feedbackinfo.domain;

import java.util.Date;
import java.io.Serializable;

import com.godoing.rose.http.PublicVoBean;
/**
 * �û�POJO
 * @author hepx
 * @date 2010-10-29 ����10:34:23
 */
public class FeedBackInfo extends PublicVoBean implements Serializable {

	private static final long serialVersionUID = 3606211640133561712L;
	
	public FeedBackInfo(){
	}
	private String feedbackstatus;
	private Integer id;
	private String contactWay;     //��ϵ��ʽ
	private String feedBackContent;//�������
	private Date dateTime;         //����ʱ��
	
	private String userName;
	private String procontent;
    private Date protime;
    
    
    private String user_id;
    private String project_name;
    private String price;
    private String user_feedback_content;
    private Date date_time;
    
    

    public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getProject_name() {
		return project_name;
	}
	public void setProject_name(String project_name) {
		this.project_name = project_name;
	}
	
	
	
	public String getPrice() {
		return price;
	}
	public void setPrice(String price) {
		this.price = price;
	}
	public String getUser_feedback_content() {
		return user_feedback_content;
	}
	public void setUser_feedback_content(String user_feedback_content) {
		this.user_feedback_content = user_feedback_content;
	}
	public Date getDate_time() {
		return date_time;
	}
	public void setDate_time(Date date_time) {
		this.date_time = date_time;
	}
	public String getFeedbackstatus() {
		return feedbackstatus;
	}
	public void setFeedbackstatus(String feedbackstatus) {
		this.feedbackstatus = feedbackstatus;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
    private String belongProject;
	public String getProcontent() {
		return procontent;
	}
	public void setProcontent(String procontent) {
		this.procontent = procontent;
	}
	public Date getProtime() {
		return protime;
	}
	public void setProtime(Date protime) {
		this.protime = protime;
	}
	
	public String getBelongProject() {
		return belongProject;
	}
	public void setBelongProject(String belongProject) {
		this.belongProject = belongProject;
	}
	
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public void setContactWay(String contactWay){
		this.contactWay = contactWay;
	}
	public String getContactWay(){
		return this.contactWay;
	}

	public void setFeedBackContent(String feedBackContent){
		this.feedBackContent = feedBackContent;
	}
	public String getFeedBackContent(){
		return this.feedBackContent;
	}
	public void setDateTime(Date dateTime) {
		this.dateTime = dateTime;
	}

	public Date getDateTime() {
		return this.dateTime;
	}
}
