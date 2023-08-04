package model.freply;

import java.util.Date;

public class FreplyDTO {
	
	private Integer freply_no;
	private Integer fboard_no;
	private String freply_content;
	private String mem_nick;
	private Date freply_regdate;
	private String fr_isshow;
	
	public Integer getFreply_no() {
		return freply_no;
	}
	public void setFreply_no(Integer freply_no) {
		this.freply_no = freply_no;
	}
	public Integer getFboard_no() {
		return fboard_no;
	}
	public void setFboard_no(Integer fboard_no) {
		this.fboard_no = fboard_no;
	}
	public String getFreply_content() {
		return freply_content;
	}
	public void setFreply_content(String freply_content) {
		this.freply_content = freply_content;
	}
	public String getMem_nick() {
		return mem_nick;
	}
	public void setMem_nick(String mem_nick) {
		this.mem_nick = mem_nick;
	}
	public Date getFreply_regdate() {
		return freply_regdate;
	}
	public void setFreply_regdate(Date freply_regdate) {
		this.freply_regdate = freply_regdate;
	}
	public String getFr_isshow() {
		return fr_isshow;
	}
	public void setFr_isshow(String fr_isshow) {
		this.fr_isshow = fr_isshow;
	}
	
	@Override
	public String toString() {
		return "MReplyDTO [freply_no=" + freply_no + ", fboard_no=" + fboard_no + ", freply_content=" + freply_content
				+ ", mem_nick=" + mem_nick + ", freply_regdate=" + freply_regdate + ", fr_isshow=" + fr_isshow + "]";
	}
	

	
}
