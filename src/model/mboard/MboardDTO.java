package model.mboard;

import java.sql.Timestamp;

public class MboardDTO {
    private int boardNo;
    private String mem_nick;
    private String boardTitle;
    private String boardContents;
    private Timestamp boardRegdate;
    private String b_isshow;
    private int setmbTitleCount;
    private int setmreplyContentCount;
    private int viewCount;
    private int replyCount;
	
    public int getBoardNo() {
		return boardNo;
	}
	public void setBoardNo(int boardNo) {
		this.boardNo = boardNo;
	}
    public String getMem_nick() {
        return mem_nick;
    }

    public void setMem_nick(String mem_nick) {
        this.mem_nick = mem_nick;
    }
	public String getBoardTitle() {
		return boardTitle;
	}
	public void setBoardTitle(String boardTitle) {
		this.boardTitle = boardTitle;
	}
	public String getBoardContents() {
		return boardContents;
	}
	public void setBoardContents(String boardContents) {
		this.boardContents = boardContents;
	}
	public Timestamp getBoardRegdate() {
		return boardRegdate;
	}
	public void setBoardRegdate(Timestamp timestamp) {
		this.boardRegdate = timestamp;
	}
	public String getB_isshow() {
		return b_isshow;
	}
	public void setB_isshow(String b_isshow) {
		this.b_isshow = b_isshow;
	}
	public int getSetmbTitleCount() {
		return setmbTitleCount;
	}
	public void setSetmbTitleCount(int setmbTitleCount) {
		this.setmbTitleCount = setmbTitleCount;
	}
	public int getSetmreplyContentCount() {
		return setmreplyContentCount;
	}
	public void setSetmreplyContentCount(int setmreplyContentCount) {
		this.setmreplyContentCount = setmreplyContentCount;
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