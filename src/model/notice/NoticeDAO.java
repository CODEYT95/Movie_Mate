package model.notice;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import model.nreply.NreplyDTO;
import util.JDBCUtil;

public class NoticeDAO {
	
	PreparedStatement stmt = null;
	ResultSet rs = null;
	Connection conn = null;

	//공지사항 입력
	public Integer insertNotice(NoticeDTO notice) throws Exception {
		
	    System.out.println("ok");
	    
	    String sql = "insert into notice(n_title,mem_nick,n_contents,n_regdate) values(?,?,?,now())";
	    PreparedStatement stmt2 = null;
	    
	    
	    try {
	        conn = JDBCUtil.getConnection();
	        stmt = conn.prepareStatement(sql);
	        stmt.setString(1, notice.getN_title());
	        stmt.setString(2, notice.getM_nick());
	        stmt.setString(3, notice.getN_contents());
	        int cnt = stmt.executeUpdate();
	        
	        if(cnt>0) {
	        	stmt2 = conn.prepareStatement("select last_insert_id() from notice");
	        	rs = stmt2.executeQuery();
	        	if(rs.next()) {
	        		return rs.getInt(1);
	        	}
	        }
	        return null;
	        
	    }  finally {
	        JDBCUtil.close(rs, stmt, null);
	        JDBCUtil.close(null,stmt2,null);
	    }
	}


//	private Timestamp toTimestamp(Date date) {
//		return new Timestamp(date.getTime());
//	}
	//공지사항 상세정보
	public NoticeDTO selectDetail(int no) throws Exception {
		String sql = "SELECT n.notice_no, n.mem_nick, n.n_title, n.n_contents, n.n_regdate, n.n_isshow, n.nreply_count, nr.nreply_no, nr.nreply_content, nr.mem_nick, nr.nreply_regdate, nr.nreply_isshow " + 
				"FROM notice n " + 
				"LEFT JOIN notice_reply nr on n.notice_no = nr.notice_no " + 
				"WHERE n.notice_no = ?";
		NoticeDTO notice = null;
		
		try {
			conn = JDBCUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			
			stmt.setInt(1, no);
			rs = stmt.executeQuery();
			
			if(rs.next()) {
				notice = new NoticeDTO();
				notice.setNotice_no(rs.getInt("notice_no"));
				notice.setN_title(rs.getString("n_title"));
				notice.setM_nick(rs.getString("mem_nick"));
				notice.setN_contents(rs.getString("n_contents"));
				notice.setN_regdate(rs.getTimestamp("n_regdate"));
				notice.setN_isshow(rs.getString("n_isshow"));
			
				
				System.out.println("selectDetail 들어옴");
			}
			return notice;
		} finally {
			JDBCUtil.close(rs, stmt, conn);
		}
	}

	//공지사항 수정
	public boolean updateNotice(int no, String noticeTitle, String noticeContent) {
		
		String sql = "UPDATE notice SET n_title=?, n_contents=? WHERE notice_no=?";
		
		try {
			conn = JDBCUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, noticeTitle);
			stmt.setString(2, noticeContent);
			stmt.setInt(3, no);
			int cnt = stmt.executeUpdate();
			if(cnt>0) {
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			JDBCUtil.close(null, stmt, conn);
		}
		return false;
	}

	
	//공지사항 목록 list (화면 띄우기용)
			public ArrayList<NoticeDTO> selectNoticeAll() throws Exception{
				ArrayList<NoticeDTO> noticeList = new ArrayList<>();
				
				String sql = "SELECT * FROM notice WHERE n_isshow='Y' ORDER BY notice_no desc";
				
				try {
					Connection conn = JDBCUtil.getConnection();
					PreparedStatement stmt = conn.prepareStatement(sql);
					ResultSet rs = stmt.executeQuery();
					
					while(rs.next()) {
						NoticeDTO notice = new NoticeDTO();
						notice.setNotice_no(rs.getInt("notice_no"));
						notice.setM_nick(rs.getString("mem_nick"));
						notice.setN_title(rs.getString("n_title"));
						notice.setN_contents(rs.getString("n_contents"));
						notice.setN_regdate(rs.getTimestamp("n_regdate"));
						notice.setN_isshow(rs.getString("n_isshow"));
						noticeList.add(notice); // 추가된 부분
					}
				} finally {
					JDBCUtil.close(rs, stmt, conn);
				}
				return noticeList;
			}

	
			public NoticeDTO selectDetail2(int no) throws Exception {
			    String sql = "SELECT n.notice_no, n.mem_nick, n.n_title, n.n_contents, n.n_regdate, n.n_isshow, n.nreply_count, nr.nreply_no, nr.nreply_content, nr.mem_nick as reply_mem_nick, nr.nreply_regdate, nr.nreply_isshow " +
			            "FROM notice n " +
			            "LEFT JOIN notice_reply nr on n.notice_no = nr.notice_no " +
			            "WHERE n.notice_no = ?";
			    NoticeDTO notice = null;

			    try {
			        conn = JDBCUtil.getConnection();
			        stmt = conn.prepareStatement(sql);

			        stmt.setInt(1, no);
			        rs = stmt.executeQuery();

			        if (rs.next()) {
			            notice = new NoticeDTO();
			            notice.setNotice_no(rs.getInt("notice_no"));
			            notice.setN_title(rs.getString("n_title"));
			            notice.setM_nick(rs.getString("mem_nick"));
			            notice.setN_contents(rs.getString("n_contents"));
			            notice.setN_regdate(rs.getTimestamp("n_regdate"));
			            notice.setN_isshow(rs.getString("n_isshow"));

			            // Create a list to hold associated replies
			            List<NreplyDTO> replies = new ArrayList<>();

			            // Check if the first row contains reply data
			            if (rs.getInt("nreply_no") != 0) {
			                do {
			                    NreplyDTO reply = new NreplyDTO();
			                    reply.setNreply_no(rs.getInt("nreply_no"));
			                    reply.setNreply_content(rs.getString("nreply_content"));
			                    reply.setMem_nick(rs.getString("reply_mem_nick"));
			                    reply.setNreply_regdate(rs.getTimestamp("nreply_regdate"));
			                    reply.setNr_isshow(rs.getString("nreply_isshow"));

			                    // Add the reply to the list of replies
			                    replies.add(reply);
			                } while (rs.next() && rs.getInt("nreply_no") != 0);
			            }

			            // Set the list of replies in the NoticeDTO object
			            notice.setReplies(replies);
			        }

			        return notice;
			    } finally {
			        JDBCUtil.close(rs, stmt, conn);
			    }
			}
			
			
			//공지사항 목록 list (메인 띄우기용)
			public ArrayList<NoticeDTO> selectNoticeFive() throws Exception{
				ArrayList<NoticeDTO> noticeList = new ArrayList<>();
				
				String sql = "SELECT * FROM notice WHERE n_isshow='Y' ORDER BY notice_no ASC LIMIT 5";
				
				try {
					Connection conn = JDBCUtil.getConnection();
					PreparedStatement stmt = conn.prepareStatement(sql);
					ResultSet rs = stmt.executeQuery();
					
					while(rs.next()) {
						NoticeDTO notice = new NoticeDTO();
						notice.setNotice_no(rs.getInt("notice_no"));
						notice.setM_nick(rs.getString("mem_nick"));
						notice.setN_title(rs.getString("n_title"));
						notice.setN_contents(rs.getString("n_contents"));
						notice.setN_regdate(rs.getTimestamp("n_regdate"));
						notice.setN_isshow(rs.getString("n_isshow"));
						noticeList.add(notice); // 추가된 부분
					}
				} finally {
					JDBCUtil.close(rs, stmt, conn);
				}
				return noticeList;
			}
			
			
	//공지사항 숨기기
		public int deleteUpNotice(int no) throws Exception {
			String sql = "UPDATE notice SET n_isshow = 'N' WHERE notice_no = ?";
	        PreparedStatement stmt = null;
	        try {
	        	System.out.println("DAO deleteUp진입");
	            conn = JDBCUtil.getConnection();
	            stmt = conn.prepareStatement(sql);
	            stmt.setInt(1,no);
	            return stmt.executeUpdate();
	          
	        } finally{
	            JDBCUtil.close(null, stmt, conn);
	        }
		}

		//댓글조회
		public int getCommentCount(int noticeNo) throws Exception {
			String sql = "SELECT COUNT(*) AS commentCount FROM notice_reply WHERE notice_no = ? AND nreply_isshow='Y'";
			int commentCount = 0;
			
			try {
				Connection conn = JDBCUtil.getConnection();
				PreparedStatement stmt = conn.prepareStatement(sql);
				stmt.setInt(1, noticeNo);
				ResultSet rs = stmt.executeQuery();
				
				if (rs.next()) {
	                commentCount = rs.getInt("commentCount");
	            }
	        } finally {
	            JDBCUtil.close(rs, stmt, conn);
	        }

	        return commentCount;
	    }
		
		//공지 무한 스크롤
		public ArrayList<NoticeDTO> selectNoticePage(int offset, int limit) throws Exception {
		    ArrayList<NoticeDTO> noticeList = new ArrayList<NoticeDTO>();

		    String sql = "SELECT n.*, COUNT(nr.notice_no) AS reply_count " + 
		    		"FROM notice n " + 
		    		"LEFT JOIN notice_reply nr ON n.notice_no = nr.notice_no " + 
		    		"WHERE n.n_isshow = 'Y' " + 
		    		"GROUP BY n.notice_no " + 
		    		"ORDER BY n.n_regdate DESC " + 
		    		"LIMIT ? OFFSET ?";

		    try {
		        Connection conn = JDBCUtil.getConnection();
		        PreparedStatement stmt = conn.prepareStatement(sql);
		        stmt.setInt(1, limit);
		        stmt.setInt(2, offset);
		        ResultSet rs = stmt.executeQuery();

		        while (rs.next()) {
		        	NoticeDTO notice = new NoticeDTO();
		        	notice.setNotice_no(rs.getInt("notice_no"));
		        	notice.setM_nick(rs.getString("mem_nick"));
		        	notice.setN_title(rs.getString("n_title"));
		        	notice.setN_contents(rs.getString("n_contents"));
		        	notice.setN_regdate(rs.getTimestamp("n_regdate"));
		            
		        	noticeList.add(notice);
		        }
		    } finally {
		        JDBCUtil.close(rs, stmt, conn);
		    }
		    return noticeList;
		}
	
}
