package model.nreply;

import java.util.Date;

public class NreplyDTO {
	
	private Integer nreply_no;
	private Integer notice_no;
	private String nreply_content;
	private String mem_nick;
	private Date nreply_regdate;
	private String nr_isshow;
	
	public Integer getNreply_no() {
        return nreply_no;
    }
    public void setNreply_no(Integer nreply_no) {
        this.nreply_no = nreply_no;
    }
	public Integer getNotice_no() {
		return notice_no;
	}
	public void setNotice_no(Integer notice_no) {
		this.notice_no = notice_no;
	}
	public String getNreply_content() {
		return nreply_content;
	}
	public void setNreply_content(String nreply_content) {
		this.nreply_content = nreply_content;
	}
	public String getMem_nick() {
		return mem_nick;
	}
	public void setMem_nick(String mem_nick) {
		this.mem_nick = mem_nick;
	}
	public Date getNreply_regdate() {
		return nreply_regdate;
	}
	public void setNreply_regdate(Date nreply_regdate) {
		this.nreply_regdate = nreply_regdate;
	}
	public String getNr_isshow() {
		return nr_isshow;
	}
	public void setNr_isshow(String nr_isshow) {
		this.nr_isshow = nr_isshow;
	}
	@Override
    public String toString() {
        return "ReplyDTO [n_reply_no=" + nreply_no + ", notice_no=" + notice_no + ", nreply_content=" + nreply_content
                + ", mem_nick=" + mem_nick + ", nreply_regdate=" + nreply_regdate + ", nr_isshow=" + nr_isshow + "]";
    }
	
	
}
