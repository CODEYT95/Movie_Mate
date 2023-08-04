package model.notice;

import java.util.Date;
import java.util.List;

import model.nreply.NreplyDTO;

public class NoticeDTO {
	private Integer notice_no;
	private String m_nick;
	private String n_title;
	private String n_contents;
	private Date n_regdate;
	private String n_isshow;
	private int commentCount;
	private List<NreplyDTO> replies;

	public Integer getNotice_no() {
		return notice_no;
	}

	public void setNotice_no(Integer notice_no) {
		this.notice_no = notice_no;
	}

	public String getM_nick() {
		return m_nick;
	}

	public void setM_nick(String m_nick) {
		this.m_nick = m_nick;
	}

	public String getN_title() {
		return n_title;
	}

	public void setN_title(String n_title) {
		this.n_title = n_title;
	}

	public String getN_contents() {
		return n_contents;
	}

	public void setN_contents(String n_contents) {
		this.n_contents = n_contents;
	}

	public Date getN_regdate() {
		return n_regdate;
	}

	public void setN_regdate(Date n_regdate) {
		this.n_regdate = n_regdate;
	}

	public String getN_isshow() {
		return n_isshow;
	}

	public void setN_isshow(String n_isshow) {
		this.n_isshow = n_isshow;
	}

	public List<NreplyDTO> getReplies() {
        return replies;
    }

    public void setReplies(List<NreplyDTO> replies) {
        this.replies = replies;
    }
    
    public int getCommentCount() {
        return commentCount;
    }

    public void setCommentCount(int commentCount) {
        this.commentCount = commentCount;
    }
    
	@Override
	public String toString() {
		return "NoticeDTO [notice_no=" + notice_no + ", m_nick=" + m_nick + ", n_title=" + n_title + ", n_contents="
				+ n_contents + ", n_regdate=" + n_regdate + ", n_isshow=" + n_isshow + ", replies=" + replies + "]";
	}


}
