package model.mreply;

import java.util.Date;

public class MreplyDTO {
	
	private Integer mreply_no;
	private Integer board_no;
	private String mreply_content;
	private String mem_nick;
	private Date mreply_regdate;
	private String mr_isshow;
	
	public Integer getMreply_no() {
		return mreply_no;
	}
	public void setMreply_no(Integer mreply_no) {
		this.mreply_no = mreply_no;
	}
	public Integer getBoard_no() {
		return board_no;
	}
	public void setBoard_no(Integer board_no) {
		this.board_no = board_no;
	}
	public String getMreply_content() {
		return mreply_content;
	}
	public void setMreply_content(String mreply_content) {
		this.mreply_content = mreply_content;
	}
	public String getMem_nick() {
		return mem_nick;
	}
	public void setMem_nick(String mem_nick) {
		this.mem_nick = mem_nick;
	}
	public Date getMreply_regdate() {
		return mreply_regdate;
	}
	public void setMreply_regdate(Date mreply_regdate) {
		this.mreply_regdate = mreply_regdate;
	}
	public String getMr_isshow() {
		return mr_isshow;
	}
	public void setMr_isshow(String mr_isshow) {
		this.mr_isshow = mr_isshow;
	}
	@Override
	public String toString() {
		return "MReplyDTO [mreply_no=" + mreply_no + ", mboard_no=" + board_no + ", mreply_content=" + mreply_content
				+ ", mem_nick=" + mem_nick + ", mreply_regdate=" + mreply_regdate + ", mr_isshow=" + mr_isshow + "]";
	}
	
	

	
}
