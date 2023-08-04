package model.mboard;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import util.JDBCUtil;

public class MboardDAO {
	
	PreparedStatement stmt = null;
	ResultSet rs = null;
	Connection conn = null;

	  //목록 조회
    public ArrayList<MboardDTO> selectAll(){
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        ArrayList<MboardDTO> boardList = new ArrayList<MboardDTO>();
        String sql = "SELECT * FROM mboard where b_isshow='Y'";

        try {
        	conn =JDBCUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            while (rs.next()) {
            	MboardDTO bw = new MboardDTO();
                rs.getString("mem_nick");
                rs.getString("b_title");
                rs.getString("b_contents");
                boardList.add(bw);
            
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
           JDBCUtil.close(rs, pstmt, conn);
        }
        return boardList;
    }
    //업데이트
    public boolean update(int b_no, String b_title, String b_contents) throws SQLException {
        PreparedStatement pstmt = null;
        String sql = "UPDATE mboard SET b_title = ?, b_contents = ? WHERE board_no = ?";
        try {
        	System.out.println("DAO update진입");
            conn = JDBCUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, b_title);
            pstmt.setString(2, b_contents);
            pstmt.setInt(3, b_no); // Set the board_no for the WHERE clause
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
	//공지사항 입력
	public Integer insert(MboardDTO bwDto) throws Exception {
		
	    System.out.println("ok");
	    
	    String sql = "insert into mboard(mem_nick, b_title,b_contents,b_regdate) values(?,?,?,now())";
	    PreparedStatement stmt2 = null;
	    
	    
	    try {
	        conn = JDBCUtil.getConnection();
	        stmt = conn.prepareStatement(sql);
	        stmt.setString(1, bwDto.getMem_nick());
	        stmt.setString(2, bwDto.getBoardTitle());
	        stmt.setString(3, bwDto.getBoardContents());
	        int cnt = stmt.executeUpdate();
	        
	        if(cnt>0) {
	        	stmt2 = conn.prepareStatement("select last_insert_id() from mboard");
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

	//공지사항 상세정보
	public MboardDTO selectDetail(int no) throws Exception {
		
		String sql = "SELECT * FROM mboard WHERE b_isshow='Y' AND board_no = ?";;
		MboardDTO mboard = null;
		
		try {
			conn = JDBCUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			
			stmt.setInt(1, no);
			rs = stmt.executeQuery();
			
			if(rs.next()) {
				mboard = new MboardDTO();
				mboard.setBoardNo(rs.getInt("board_no"));
				mboard.setBoardTitle(rs.getString("b_title"));
				mboard.setBoardContents(rs.getString("b_contents"));
				mboard.setBoardRegdate(rs.getTimestamp("b_regdate"));
				mboard.setB_isshow(rs.getString("b_isshow"));
				
				System.out.println("selectDetail 들어옴");
			}
			return mboard;
		} finally {
			JDBCUtil.close(rs, stmt, conn);
		}
	}
	public int deleteMboard(int no) throws Exception {
		String sql = "UPDATE mboard SET b_isshow = 'N' WHERE board_no = ?";
        PreparedStatement pstmt = null;
        try {
        	System.out.println("DAO delete진입");
            conn = JDBCUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1,no);
            return pstmt.executeUpdate();
          
        } finally{
            JDBCUtil.close(null, pstmt, conn);
        }
	}

	//조회수 카운트
		public void viewCount(int no) throws Exception {
			String sql = "UPDATE mboard SET view_count = view_count +1 WHERE board_no = ?";
			
			System.out.println("매칭보드 조회수 카운트업");
			PreparedStatement pstmt = null;
			try {
				conn = JDBCUtil.getConnection();
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, no);
				int viewCount2 =  pstmt.executeUpdate();
				System.out.println(viewCount2);
			} finally {
				System.out.println("DAO delete진입");
				JDBCUtil.close(null, pstmt, conn);
			}
		}
	
	//최근 글 목록 20개
    public ArrayList<MboardDTO> recentWrite(String MEM_NICK) {
        ArrayList<MboardDTO> result = new ArrayList<>();
        String sql = "SELECT mem_nick,b_title,b_contents FROM mboard WHERE mem_nick = ? ORDER BY board_no DESC LIMIT 20";

        try (Connection conn = JDBCUtil.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, MEM_NICK);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    MboardDTO dto = new MboardDTO();
                    dto.setMem_nick(rs.getString("mem_nick"));
                    dto.setBoardTitle(rs.getString("b_title"));
                    dto.setBoardContents(rs.getString("b_contents"));
                    result.add(dto);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }
    public List<MboardDTO> selectCumm() throws Exception {
        String sql = "SELECT * FROM mboard ORDER BY DESC b_regdate";
        List<MboardDTO> mboardList = new ArrayList<>();

        try {
            conn = JDBCUtil.getConnection();
            stmt = conn.prepareStatement(sql);

            rs = stmt.executeQuery();

            while (rs.next()) {
                MboardDTO mboard = new MboardDTO();
                mboard.setBoardNo(rs.getInt("board_no"));
                mboard.setBoardTitle(rs.getString("b_title"));
                mboard.setBoardContents(rs.getString("b_contents"));
                mboard.setBoardRegdate(rs.getTimestamp("b_regdate"));
                mboard.setB_isshow(rs.getString("b_isshow"));

                mboardList.add(mboard);
            }
        } finally {
            JDBCUtil.close(rs, stmt, conn);
        }

        return mboardList;
    }

  //20개씩 불러오는 메소드
  	public ArrayList<MboardDTO> selectfBoardPage(int offset, int limit) throws Exception {
  	    ArrayList<MboardDTO> mBoardList = new ArrayList<MboardDTO>();

  	    String sql = "SELECT m.*, COUNT(mr.mreply_no) AS reply_count " + 
  	    		"FROM mboard m\r\n" + 
  	    		"LEFT JOIN mboard_reply mr ON m.board_no = mr.board_no " + 
  	    		"WHERE m.b_isshow = 'Y' " + 
  	    		"GROUP BY m.board_no " + 
  	    		"ORDER BY m.b_regdate DESC " + 
  	    		"LIMIT ? OFFSET ?";

  	    try {
  	        Connection conn = JDBCUtil.getConnection();
  	        PreparedStatement stmt = conn.prepareStatement(sql);
  	        stmt.setInt(1, limit);
  	        stmt.setInt(2, offset);
  	        ResultSet rs = stmt.executeQuery();

  	        while (rs.next()) {
  	        	MboardDTO mboard = new MboardDTO();
  	        	mboard.setBoardNo(rs.getInt("board_no"));
  	        	mboard.setMem_nick(rs.getString("mem_nick"));
  	        	mboard.setBoardTitle(rs.getString("b_title"));
  	        	mboard.setBoardContents(rs.getString("b_contents"));
  	        	mboard.setBoardRegdate(rs.getTimestamp("b_regdate"));
  	        	mboard.setViewCount(rs.getInt("view_count"));
  	        	mboard.setReplyCount(rs.getInt("reply_count"));
  	            
  	        	mBoardList.add(mboard);
  	        }
  	    } finally {
  	        JDBCUtil.close(rs, stmt, conn);
  	    }
  	    return mBoardList;
  	}
  	
  //내가 쓴 게시글 댓글 수{
  	public Map<String, Integer[]> getFboardStatisticsByMemNick(String memNick) {
  	    Map<String, Integer[]> mboardMap = new HashMap<>();

  	    try {
  	        String sql = "SELECT m.mem_nick, COUNT(DISTINCT mb.board_no) AS b_title_count, COUNT(mr.mreply_content) AS mreply_content_count " +
  	                "FROM mboard mb " +
  	                "LEFT JOIN mboard_reply mr ON mb.board_no = mr.board_no " +
  	                "JOIN member m ON mb.mem_nick = m.mem_nick " +
  	                "WHERE m.mem_nick = ? " +
  	                "GROUP BY m.mem_nick";

  	        Connection conn = JDBCUtil.getConnection();
  	        PreparedStatement pstmt = conn.prepareStatement(sql);
  	        pstmt.setString(1, memNick);

  	        ResultSet rs = pstmt.executeQuery();
  	        while (rs.next()) {
  	            Integer[] mboardValue = new Integer[2];
  	          mboardValue[0] = rs.getInt("b_title_count");
  	        mboardValue[1] = rs.getInt("mreply_content_count");

  	          mboardMap.put(rs.getString("mem_nick"), mboardValue);
  	        }
  	    } catch (Exception e) {
  	        e.printStackTrace();
  	    }finally {
  	        JDBCUtil.close(rs, stmt, conn);
  	    }
  	    
  	    return mboardMap;
  	}
    

}
