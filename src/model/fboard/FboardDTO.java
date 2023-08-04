package model.fboard;

import java.sql.Timestamp;

public class FboardDTO {
    private int fboard_no;
    private String mem_nick;
    private String fb_title;
    private String fb_content;
    private Timestamp fb_regdate;
    private String fb_isshow;
    private int replyCount;
    private int viewCount;
    private int setFbTitleCount;
    private int setFreplyContentCount;
    
    
	public int getFboard_no() {
		return fboard_no;
	}
	public void setFboard_no(int fboard_no) {
		this.fboard_no = fboard_no;
	}
	public String getMem_nick() {
		return mem_nick;
	}
	public void setMem_nick(String mem_nick) {
		this.mem_nick = mem_nick;
	}
	public String getFb_title() {
		return fb_title;
	}
	public void setFb_title(String fb_title) {
		this.fb_title = fb_title;
	}
	public String getFb_content() {
		return fb_content;
	}
	public void setFb_content(String fb_content) {
		this.fb_content = fb_content;
	}
	public Timestamp getFb_regdate() {
		return fb_regdate;
	}
	public void setFb_regdate(Timestamp fb_regdate) {
		this.fb_regdate = fb_regdate;
	}
	public String getFb_isshow() {
		return fb_isshow;
	}
	public void setFb_isshow(String fb_isshow) {
		this.fb_isshow = fb_isshow;
	}
	
	@Override
	public String toString() {
		return "FboardDTO [fboard_no=" + fboard_no + ", mem_nick=" + mem_nick + ", fb_title=" + fb_title
				+ ", fb_content=" + fb_content + ", fb_regdate=" + fb_regdate + ", fb_isshow=" + fb_isshow + "]";
	}
	public int getSetFreplyContentCount() {
		return setFreplyContentCount;
	}
	public void setSetFreplyContentCount(int setFreplyContentCount) {
		this.setFreplyContentCount = setFreplyContentCount;
	}
	public int getSetFbTitleCount() {
		return setFbTitleCount;
	}
	public void setSetFbTitleCount(int setFbTitleCount) {
		this.setFbTitleCount = setFbTitleCount;
	}
	public int getViewCount() {
		return viewCount;
	}
	public void setViewCount(int viewCount) {
		this.viewCount = viewCount;
	}
	public int getReplyCount() {
		return replyCount;
	}
	public void setReplyCount(int replyCount) {
		this.replyCount = replyCount;
	}
    
}