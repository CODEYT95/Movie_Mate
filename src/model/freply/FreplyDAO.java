package model.freply;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import util.JDBCUtil;

public class FreplyDAO {
	
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs= null;
	
	//공지사항 댓글 입력
	public int insertFreeReply(FreplyDTO reply) throws Exception {
		
	    System.out.println("insertReply");
	    
	    String sql = "insert into fboard_reply(fboard_no,mem_nick,freply_content,freply_regdate,freply_isshow) "
	    						+ "values(?,?,?,now(),'Y')";
	    
	    int cnt = 0;
	    
	    try {
	        conn = JDBCUtil.getConnection();
	        stmt = conn.prepareStatement(sql);
	        stmt.setInt(1,reply.getFboard_no());
	        stmt.setString(2, reply.getMem_nick());
	        stmt.setString(3,reply.getFreply_content());
	        cnt = stmt.executeUpdate();
	        
	    }  finally {
	        JDBCUtil.close(null, stmt, conn); 
	    }
	    System.out.println("Dao"+cnt);
	    return cnt;
	}
	
	//댓글보기 (하나)
	public FreplyDTO selectFreeReplyOne(int no) throws Exception {
		String sql = "SELECT * FROM fboard_reply WHERE freply_isshow='Y' AND freply_no=?";
		FreplyDTO freply = null;
		
		try {
			conn = JDBCUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			
			stmt.setInt(1, no);
			rs = stmt.executeQuery();
			
			if(rs.next()) {
				freply = new FreplyDTO();
				freply.setFboard_no(rs.getInt("fboard_no"));
				freply.setFreply_no(rs.getInt("freply_no"));
				freply.setFreply_content(rs.getString("freply_content"));
				freply.setMem_nick(rs.getString("mem_nick"));
				freply.setFreply_regdate(rs.getTimestamp("freply_regdate"));
				freply.setFr_isshow(rs.getString("freply_isshow"));
			}
			return freply;
		}finally {
			JDBCUtil.close(rs, stmt, conn);
		}
	}
	
	// 댓글 보기(무한)
	public ArrayList<FreplyDTO> selectFreeReplies(int no) throws Exception {
	    String sql = "SELECT * FROM fboard_reply WHERE fboard_no = ? AND freply_isshow='Y';";
	    ArrayList<FreplyDTO> replies = new ArrayList<>();

	    try {
		    	 Connection conn = JDBCUtil.getConnection();
		         PreparedStatement stmt = conn.prepareStatement(sql);
	
		        stmt.setInt(1, no);
		        ResultSet rs = stmt.executeQuery();
	        
	            while (rs.next()) {
	                FreplyDTO reply = new FreplyDTO();
	                reply.setFboard_no(rs.getInt("fboard_no"));
	                reply.setFreply_no(rs.getInt("freply_no"));
	                reply.setFreply_content(rs.getString("freply_content"));
	                reply.setMem_nick(rs.getString("mem_nick"));
	                reply.setFreply_regdate(rs.getTimestamp("freply_regdate"));
	                reply.setFr_isshow(rs.getString("freply_isshow"));
	                replies.add(reply); 
            
	        }
	    } finally {
	        JDBCUtil.close(rs, stmt, conn);
	    }

	    return replies; 
	}
	
	//댓글 수정하기
	public boolean updateFreeReply(int no, String replyContent) {
		String sql = "UPDATE fboard_reply SET freply_content = ? WHERE freply_no = ?";
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
	public int deleteUpMateReply(int no) throws Exception {
		String sql = "UPDATE fboard_reply SET freply_isshow = 'N' WHERE freply_no = ?";
		
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
