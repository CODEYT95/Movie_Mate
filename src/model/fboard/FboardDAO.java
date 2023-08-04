package model.fboard;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import model.movie.ReviewDTO;
import util.JDBCUtil;

public class FboardDAO {

	PreparedStatement stmt = null;
	ResultSet rs = null;
	Connection conn = null;

	// 목록 조회
	public ArrayList<FboardDTO> selectFboardAll() {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<FboardDTO> fboardList = new ArrayList<FboardDTO>();
		String sql = "SELECT * FROM fboard where fb_isshow='Y'";

		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				FboardDTO fw = new FboardDTO();
				rs.getString("mem_nick");
				rs.getString("fb_title");
				rs.getString("fb_contents");
				fboardList.add(fw);

			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(rs, pstmt, conn);
		}
		return fboardList;
	}

	// 업데이트
	public boolean update(int fboard_no, String fb_title, String fb_content) throws SQLException {
		PreparedStatement pstmt = null;
		String sql = "UPDATE fboard SET fb_title = ?, fb_contents = ? WHERE fboard_no = ?";
		try {
			System.out.println("DAO update진입");
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, fb_title);
			pstmt.setString(2, fb_content);
			pstmt.setInt(3, fboard_no);
			int cnt = pstmt.executeUpdate();
			if (cnt > 0) {
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(null, pstmt, conn);
		}
		return false;
	}

	// 공지사항 입력
	public Integer insert(FboardDTO fwDto) throws Exception {

		System.out.println("ok");

		String sql = "insert into fboard(mem_nick, fb_title,fb_contents,fb_regdate) values(?,?,?,now())";
		PreparedStatement stmt2 = null;

		try {
			conn = JDBCUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, fwDto.getMem_nick());
			stmt.setString(2, fwDto.getFb_title());
			stmt.setString(3, fwDto.getFb_content());
			int cnt = stmt.executeUpdate();

			if (cnt > 0) {
				stmt2 = conn.prepareStatement("select last_insert_id() from fboard");
				rs = stmt2.executeQuery();
				if (rs.next()) {
					return rs.getInt(1);
				}
			}
			return null;

		} finally {
			JDBCUtil.close(rs, stmt, null);
			JDBCUtil.close(null, stmt2, null);
		}
	}

	// 공지사항 상세정보
	public FboardDTO selectFboardDetail(int no) throws Exception {

		String sql = "SELECT * FROM fboard WHERE fb_isshow='Y' AND fboard_no = ?";
		FboardDTO fboard = null;

		try {
			conn = JDBCUtil.getConnection();
			stmt = conn.prepareStatement(sql);

			stmt.setInt(1, no);
			rs = stmt.executeQuery();

			if (rs.next()) {
				fboard = new FboardDTO();
				fboard.setFboard_no(rs.getInt("fboard_no"));
				fboard.setFb_title(rs.getString("fb_title"));
				fboard.setFb_content(rs.getString("fb_contents"));
				fboard.setFb_regdate(rs.getTimestamp("fb_regdate"));
				fboard.setFb_isshow(rs.getString("fb_isshow"));

				System.out.println("selectDetail 들어옴");
			}
			return fboard;
		} finally {
			JDBCUtil.close(rs, stmt, conn);
		}
	}

	public int deleteFboard(int no) throws Exception {
		String sql = "UPDATE fboard SET fb_isshow = 'N' WHERE fboard_no = ?";
		PreparedStatement pstmt = null;
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, no);
			return pstmt.executeUpdate();

		} finally {
			System.out.println("DAO delete진입");
			JDBCUtil.close(null, pstmt, conn);
		}
	}

	//조회수 카운트
	public int viewCount(int no) throws Exception {
		String sql = "UPDATE fboard SET view_count = view_count+1 WHERE fboard_no = ?";
		PreparedStatement pstmt = null;
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, no);
			return pstmt.executeUpdate();

		} finally {
			System.out.println("DAO delete진입");
			JDBCUtil.close(null, pstmt, conn);
		}
	}
	
	// 내가 쓴 최근 글 목록 20개
	public ArrayList<FboardDTO> myRecentFboardWrite(String MEM_NICK) {
		ArrayList<FboardDTO> result = new ArrayList<>();
		String sql = "SELECT fboard_no, mem_nick,fb_title,fb_contents FROM fboard WHERE mem_nick = ? ORDER BY fboard_no DESC LIMIT 20";

		try (Connection conn = JDBCUtil.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, MEM_NICK);

			try (ResultSet rs = pstmt.executeQuery()) {
				while (rs.next()) {
					FboardDTO fdto = new FboardDTO();
					fdto.setFboard_no(rs.getInt("fboard_no"));
					fdto.setMem_nick(rs.getString("mem_nick"));
					fdto.setFb_title(rs.getString("fb_title"));
					fdto.setFb_content(rs.getString("fb_contents"));
					result.add(fdto);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	//최근 게시글 21개
	public ArrayList<FboardDTO> recentFboardWrite() {
		ArrayList<FboardDTO> result = new ArrayList<>();
		String sql = "SELECT * FROM fboard ORDER BY fb_regdate DESC LIMIT 21";

		try (Connection conn = JDBCUtil.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

			try (ResultSet rs = pstmt.executeQuery()) {
				while (rs.next()) {
					FboardDTO fdto = new FboardDTO();
					fdto.setFboard_no(rs.getInt("fboard_no"));
					fdto.setMem_nick(rs.getString("mem_nick"));
					fdto.setFb_title(rs.getString("fb_title"));
					fdto.setFb_content(rs.getString("fb_contents"));
					result.add(fdto);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	//내가 쓴 게시글 댓글 수{
	public Map<String, Integer[]> getFboardStatisticsByMemNick(String memNick) {
	    Map<String, Integer[]> fboardMap = new HashMap<>();

	    try {
	        String sql = "SELECT f.mem_nick, COUNT(f.fb_title) AS fb_title_count, COUNT(fr.freply_content) AS freply_content_count " +
	                "FROM fboard f " +
	                "LEFT JOIN fboard_reply fr ON f.fboard_no = fr.fboard_no " +
	                "WHERE f.mem_nick = ? " +
	                "GROUP BY f.mem_nick";

	        Connection conn = JDBCUtil.getConnection();
	        PreparedStatement pstmt = conn.prepareStatement(sql);
	        pstmt.setString(1, memNick);

	        ResultSet rs = pstmt.executeQuery();
	        while (rs.next()) {
	            Integer[] fboardValue = new Integer[2];
	            fboardValue[0] = rs.getInt("fb_title_count");
	            fboardValue[1] = rs.getInt("freply_content_count");

	            fboardMap.put(rs.getString("mem_nick"), fboardValue);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }finally {
	        JDBCUtil.close(rs, stmt, conn);
	    }
	    
	    return fboardMap;
	}
	
	
	// 내가 쓴 최근 리뷰 목록 20개
			public ArrayList<ReviewDTO> recentReviewWrite(String MEM_NICK) {
				ArrayList<ReviewDTO> result = new ArrayList<>();
				String sql = "SELECT r.review as review FROM movie AS m JOIN review AS r ON m.movieCd = r.movieCd WHERE r.memberNc = ? ORDER BY r.writeDt DESC LIMIT 20";
				System.out.println(MEM_NICK);
				try {
					conn = JDBCUtil.getConnection();
					PreparedStatement pstmt = null;
					System.out.println(MEM_NICK);
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, MEM_NICK);
					rs = pstmt.executeQuery();
					
					while (rs.next()) {
						ReviewDTO rDTO = new ReviewDTO();
						rDTO.setReview(rs.getString("review"));
						
						result.add(rDTO);
					}
				} catch (SQLException e) {
					e.printStackTrace();
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				return result;
			}
	
	public List<FboardDTO> selectFboardCumm() throws Exception {
		String sql = "SELECT * FROM fboard ORDER BY fb_regdate";
		List<FboardDTO> fboardList = new ArrayList<>();

		try {
			conn = JDBCUtil.getConnection();
			stmt = conn.prepareStatement(sql);

			rs = stmt.executeQuery();

			while (rs.next()) {
				FboardDTO fboard = new FboardDTO();
				fboard.setMem_nick(rs.getString("mem_nick"));
				fboard.setFboard_no(rs.getInt("fboard_no"));
				fboard.setFb_title(rs.getString("fb_title"));
				fboard.setFb_content(rs.getString("fb_contents"));
				fboard.setFb_regdate(rs.getTimestamp("fb_regdate"));
				fboard.setFb_isshow(rs.getString("fb_isshow"));
				
				fboardList.add(fboard);
			}
		} finally {
			JDBCUtil.close(rs, stmt, conn);
		}

		return fboardList;
	}

	//Fboard 무한스크롤 메소드
	public ArrayList<FboardDTO> selectfBoardPage(int offset, int limit) throws Exception {
	    ArrayList<FboardDTO> fboardList = new ArrayList<FboardDTO>();

	    String sql = "SELECT f.*, COUNT(fr.freply_no) AS reply_count " + 
	    		"FROM fboard f " + 
	    		"LEFT JOIN fboard_reply fr ON f.fboard_no = fr.fboard_no " + 
	    		"WHERE f.fb_isshow = 'Y' " + 
	    		"GROUP BY f.fboard_no " + 
	    		"ORDER BY f.fb_regdate DESC " + 
	    		"LIMIT ? OFFSET ?";

	    try {
	        Connection conn = JDBCUtil.getConnection();
	        PreparedStatement stmt = conn.prepareStatement(sql);
	        stmt.setInt(1, limit);
	        stmt.setInt(2, offset);
	        ResultSet rs = stmt.executeQuery();

	        while (rs.next()) {
	        	FboardDTO fboard = new FboardDTO();
	        	fboard.setFboard_no(rs.getInt("fboard_no"));
	        	fboard.setMem_nick(rs.getString("mem_nick"));
	        	fboard.setFb_title(rs.getString("fb_title"));
	        	fboard.setFb_content(rs.getString("fb_contents"));
	        	fboard.setFb_regdate(rs.getTimestamp("fb_regdate"));
	        	fboard.setViewCount(rs.getInt("view_count"));
	        	fboard.setReplyCount(rs.getInt("reply_count"));
	            
	        	fboardList.add(fboard);
	        }
	    } finally {
	        JDBCUtil.close(rs, stmt, conn);
	    }
	    return fboardList;
	}
	
	
	
}
