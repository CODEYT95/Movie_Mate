package model.mreply;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import util.JDBCUtil;

public class MreplyDAO {
	
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs= null;
	
	//공지사항 댓글 입력
	public int insertMateReply(MreplyDTO reply) throws Exception {
		
	    System.out.println("insertReply");
	    
	    String sql = "insert into mboard_reply(board_no,mem_nick,mreply_content,mreply_regdate,mreply_isshow) "
	    						+ "values(?,?,?,now(),'Y')";
	    
	    int cnt = 0;
	    
	    try {
	        conn = JDBCUtil.getConnection();
	        stmt = conn.prepareStatement(sql);
	        stmt.setInt(1,reply.getBoard_no());
	        stmt.setString(2, reply.getMem_nick());
	        stmt.setString(3,reply.getMreply_content());
	        cnt = stmt.executeUpdate();
	        
	    }  finally {
	        JDBCUtil.close(null, stmt, conn); 
	    }
	    System.out.println("Dao"+cnt);
	    return cnt;
	}
	
	//댓글보기 (하나)
	public MreplyDTO selectMateReplyOne(int no) throws Exception {
		String sql = "SELECT * FROM mboard_reply WHERE mreply_isshow='Y' AND mreply_no=?";
		MreplyDTO reply = null;
		
		try {
			conn = JDBCUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			
			stmt.setInt(1, no);
			rs = stmt.executeQuery();
			
			if(rs.next()) {
				reply = new MreplyDTO();
				reply.setBoard_no(rs.getInt("board_no"));
                reply.setMreply_no(rs.getInt("mreply_no"));
                reply.setMreply_content(rs.getString("mreply_content"));
                reply.setMem_nick(rs.getString("mem_nick"));
                reply.setMreply_regdate(rs.getTimestamp("mreply_regdate"));
                reply.setMr_isshow(rs.getString("mreply_isshow"));
			}
			return reply;
		}finally {
			JDBCUtil.close(rs, stmt, conn);
		}
	}
	
	// 댓글 보기(무한)
	public ArrayList<MreplyDTO> selectMateReplies(int no) throws Exception {
	    String sql = "SELECT * FROM mboard_reply WHERE board_no = ? AND mreply_isshow='Y';";
	    ArrayList<MreplyDTO> replies = new ArrayList<>();

	    try {
		    	 Connection conn = JDBCUtil.getConnection();
		         PreparedStatement stmt = conn.prepareStatement(sql);
	
		        stmt.setInt(1, no);
		        ResultSet rs = stmt.executeQuery();
	        
	            while (rs.next()) {
	                MreplyDTO reply = new MreplyDTO();
	                reply.setBoard_no(rs.getInt("board_no"));
	                reply.setMreply_no(rs.getInt("mreply_no"));
	                reply.setMreply_content(rs.getString("mreply_content"));
	                reply.setMem_nick(rs.getString("mem_nick"));
	                reply.setMreply_regdate(rs.getTimestamp("mreply_regdate"));
	                reply.setMr_isshow(rs.getString("mreply_isshow"));
	                replies.add(reply); 
            
	        }
	    } finally {
	        JDBCUtil.close(rs, stmt, conn);
	    }

	    return replies; 
	}
	
	//댓글 수정하기
	public boolean updateMateReply(int no, String mem_nick, String replyContent) {
		String sql = "UPDATE mboard_reply SET mreply_content = ?, mem_nick = ? WHERE mreply_no = ?";
		try {
			conn = JDBCUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, replyContent);
			stmt.setString(2, mem_nick);
			stmt.setInt(3, no);
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
		String sql = "UPDATE mboard_reply SET mreply_isshow = 'N' WHERE mreply_no = ?";
		
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
