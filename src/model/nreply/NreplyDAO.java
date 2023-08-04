package model.nreply;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import util.JDBCUtil;

public class NreplyDAO {
	
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs= null;
	
	//공지사항 댓글 입력
	public int insertNoticeReply(NreplyDTO reply) throws Exception {
		
	    System.out.println("insertNoticeReply");
	    
	    String sql = "insert into notice_reply(notice_no,mem_nick,nreply_content,nreply_regdate,nreply_isshow) "
	    						+ "values(?,?,?,now(),'Y')";
	    
	    int cnt = 0;
	    
	    try {
	        conn = JDBCUtil.getConnection();
	        stmt = conn.prepareStatement(sql);
	        stmt.setInt(1,reply.getNotice_no());
	        stmt.setString(2, reply.getMem_nick());
	        stmt.setString(3,reply.getNreply_content());
	        cnt = stmt.executeUpdate();
	        
	    }  finally {
	        JDBCUtil.close(null, stmt, conn); 
	    }
	    System.out.println("Dao"+cnt);
	    return cnt;
	}
	
	//댓글보기 (하나)
	public NreplyDTO selectReplyOne(int no) throws Exception {
		String sql = "SELECT * FROM notice_reply WHERE nreply_isshow='Y' AND nreply_no=?";
		NreplyDTO reply = null;
		
		try {
			conn = JDBCUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			
			stmt.setInt(1, no);
			rs = stmt.executeQuery();
			
			if(rs.next()) {
				reply = new NreplyDTO();
				reply.setNotice_no(rs.getInt("notice_no"));
                reply.setNreply_no(rs.getInt("nreply_no"));
                reply.setNreply_content(rs.getString("nreply_content"));
                reply.setMem_nick(rs.getString("mem_nick"));
                reply.setNreply_regdate(rs.getTimestamp("nreply_regdate"));
                reply.setNr_isshow(rs.getString("nreply_isshow"));
			}
			return reply;
		}finally {
			JDBCUtil.close(rs, stmt, conn);
		}
	}
	
	// 댓글 보기(무한)
	public ArrayList<NreplyDTO> selectReplies(int no) throws Exception {
	    String sql = "SELECT * FROM notice_reply WHERE notice_no = ? AND nreply_isshow='Y';";
	    ArrayList<NreplyDTO> replies = new ArrayList<>();

	    try {
		    	 Connection conn = JDBCUtil.getConnection();
		         PreparedStatement stmt = conn.prepareStatement(sql);
	
		        stmt.setInt(1, no);
		        ResultSet rs = stmt.executeQuery();
	        
	            while (rs.next()) {
	                NreplyDTO reply = new NreplyDTO();
	                reply.setNotice_no(rs.getInt("notice_no"));
	                reply.setNreply_no(rs.getInt("nreply_no"));
	                reply.setNreply_content(rs.getString("nreply_content"));
	                reply.setMem_nick(rs.getString("mem_nick"));
	                reply.setNreply_regdate(rs.getTimestamp("nreply_regdate"));
	                reply.setNr_isshow(rs.getString("nreply_isshow"));
	                replies.add(reply); 
            
	        }
	    } finally {
	        JDBCUtil.close(rs, stmt, conn);
	    }

	    return replies; 
	}
	
	//댓글 수정하기
	public boolean updateNoticeReply(int no, String replyContent) {
		String sql = "UPDATE notice_reply SET nreply_content = ? WHERE nreply_no = ?";
		try {
			conn = JDBCUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, replyContent);
			stmt.setInt(2, no);
			int cnt = stmt.executeUpdate();
			if(cnt>0){
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			JDBCUtil.close(null, stmt, conn);
		}
		return false;
	}
	
	//댓글 숨기기
	public int deleteUpNoticeReply(int no) throws Exception {
		String sql = "UPDATE notice_reply SET nreply_isshow = 'N' WHERE nreply_no = ?";
		
		PreparedStatement stmt = null;
		System.out.println("댓글숨기기~");
		
		try {
			conn = JDBCUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, no);
			return stmt.executeUpdate();
		}finally {
			JDBCUtil.close(null, stmt, conn);
		}
	}
	//댓글 삭제

}
