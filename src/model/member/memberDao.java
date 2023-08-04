package model.member;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import util.JDBCUtil;

public class memberDao {

	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private static memberDao instance;
	memberDto mDto = new memberDto();
	
	// 싱글톤 패턴
    public static synchronized memberDao getInstance(){
        if(instance==null) {
            instance=new memberDao();
        }
        return instance;
    }
    
    //회원정보 insert
    public int insertMember(memberDto member) {
    	
  	  
  	  int result = 0;
  	  
  	  try {
  	    conn = JDBCUtil.getConnection();
  	    
  	    StringBuffer sql = new StringBuffer();
  	    sql.append("INSERT INTO member (MEM_ID, MEM_PW, MEM_NAME, MEM_NICK, MEM_BIRTH, MEM_EMAIL, MEM_GENDER, MEM_TEL, MEM_ADDRESS) ")
  	         .append(" VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)");
  	    pstmt = conn.prepareStatement(sql.toString());
  	    
  	    // 회원 정보 설정
  	    pstmt.setString(1, member.getM_id());
  	    pstmt.setString(2, member.getM_pw());
  	    pstmt.setString(3, member.getM_name());
  	    pstmt.setString(4, member.getM_nick());
  	    pstmt.setDate(5, (Date) member.getM_birth());
  	    pstmt.setString(6, member.getM_email());
  	    pstmt.setString(7, member.getM_gender());
  	    pstmt.setString(8, member.getM_pn());
  	    pstmt.setString(9, member.getM_address());
  	    
  	    // 쿼리 실행
  	    result = pstmt.executeUpdate();

  	  } catch (Exception e) {
  	    e.printStackTrace();
  	  } finally {
  	    JDBCUtil.close(null, pstmt, conn);
  	  }
  	  
  	  return result;
  	}
    
    
  //장르insert
    public int insertGenre(String m_id, String m_genre1, String m_genre2, String m_genre3){
        int result = 0;

        try {
            conn = JDBCUtil.getConnection();

            StringBuffer sql = new StringBuffer();
            sql.append("INSERT INTO member_genre (MEM_ID, MEM_GENRE1, MEM_GENRE2, MEM_GENRE3) ")
               .append(" VALUES (?, ?, ?, ?)");
            pstmt = conn.prepareStatement(sql.toString());

            // 회원 정보 설정
            pstmt.setString(1, m_id);
            pstmt.setString(2, m_genre1);
            pstmt.setString(3, m_genre2);
            pstmt.setString(4, m_genre3);

            // 쿼리 실행
            result = pstmt.executeUpdate();
            

        } catch (Exception e) {
            e.printStackTrace();
         
        } finally {
            JDBCUtil.close(null, pstmt, conn);
        }

        return result;
    }
    
    //회원정보 수정
    
    public  int updateMember(memberDto member) {
    	int result = 0;
    	
    	try {
			conn = JDBCUtil.getConnection();
			
			StringBuffer sql = new StringBuffer();
            sql.append("UPDATE member ")
               .append(" SET MEM_PW = ?, MEM_NICK = ?, MEM_TEL = ?, MEM_ADDRESS=? ")
               .append("WHERE MEM_ID = ?");
            pstmt = conn.prepareStatement(sql.toString());
			
            pstmt.setString(1, member.getM_pw());
            pstmt.setString(2, member.getM_nick());
            pstmt.setString(3, member.getM_pn());
            pstmt.setString(4, member.getM_address());
            pstmt.setString(5, member.getM_id());
            
            result = pstmt.executeUpdate();
            
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
            JDBCUtil.close(null, pstmt, conn);
		}
    	return result;
    }
    
//회원정보 삭제
    
    public  int deleteMember(memberDto member) {
    	int result = 0;
    	
    	try {
			conn = JDBCUtil.getConnection();
			
			StringBuffer sql = new StringBuffer();
            sql.append("DELETE ")
               .append(" FROM member ")
               .append("WHERE MEM_ID = ?");
            pstmt = conn.prepareStatement(sql.toString());
			
            pstmt.setString(1, member.getM_id());
            
            result = pstmt.executeUpdate();
            
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
            JDBCUtil.close(null, pstmt, conn);
		}
    	return result;
    }
    
    //로그인 메소드
    public Map<String, String> login(memberDto member){
        Map<String, String> result = new HashMap<>();
        System.out.println("컨트롤러 접속");
        
        try {
            conn = JDBCUtil.getConnection();
            StringBuffer sql = new StringBuffer();
            sql.append("SELECT MEM_PW, MEM_NICK, MEM_TEMP FROM member WHERE MEM_ID = ?");
            
            pstmt = conn.prepareStatement(sql.toString());
            
            pstmt.setString(1, member.getM_id());
            
            rs = pstmt.executeQuery();
            if (rs.next()) {
            	result.put("MEM_PW", rs.getString("MEM_PW"));
            	result.put("MEM_NICK", rs.getString("MEM_NICK"));
            	result.put("MEM_TEMP", rs.getString("MEM_TEMP"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JDBCUtil.close(rs, pstmt, conn);
        }
        
        return result;
    }
    
    //아이디 유효성 체크
    public int checkId(String m_id) {
    	
    	
    	PreparedStatement pstmt = null;
    	ResultSet rs = null;
    	int idCount = 0;
    	
    	StringBuffer sql = new StringBuffer(); 
    	sql.append("SELECT COUNT(*) AS cnt ")
    	     .append("FROM member ")
    	     .append("WHERE MEM_ID = ?");
    	
    	try {
    		conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql.toString());
			
			pstmt.setString(1, m_id);
			
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
			       
				idCount = rs.getInt(1);
			       
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			
		}finally {
			JDBCUtil.close(rs, pstmt, conn);
		}
		return idCount;
    	
    }

   //닉네임 유효성 체크
    public int checkNick(String m_nick){
    	Connection conn = null;
    	
    	PreparedStatement pstmt = null;
    	ResultSet rs = null;
    	int nickCount = 0;
    	
    	StringBuffer sql = new StringBuffer(); 
    	sql.append("SELECT COUNT(*) AS cnt ")
    	     .append("FROM member ")
    	     .append("WHERE MEM_NICK = ?");
    	
    	try {
    		conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql.toString());
			
			pstmt.setString(1, m_nick);
			
			rs = pstmt.executeQuery();
			if (rs.next()) {
				
			       nickCount = rs.getInt("cnt");
			       
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			
		}finally {
			JDBCUtil.close(rs, pstmt, conn);
		}
		return nickCount;
    	
    }
 
    //이메일 유효성 체크
    public int checkEmail(String m_email){
    	Connection conn = null;
    	
    	PreparedStatement pstmt = null;
    	ResultSet rs = null;
    	int emailCount = 0;
    	
    	StringBuffer sql = new StringBuffer(); 
    	sql.append("SELECT COUNT(*) AS cnt ")
    	     .append("FROM member ")
    	     .append("WHERE MEM_EMAIL = ?");
    	
    	try {
    		conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql.toString());
			
			pstmt.setString(1, m_email);
			
			rs = pstmt.executeQuery();
			if (rs.next()) {
				
				emailCount = rs.getInt("cnt");
			       
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			
		}finally {
			JDBCUtil.close(rs, pstmt, conn);
		}
		return emailCount;
    	
    }
    
  //번호 유효성 체크
    public int checkTel(String m_tel){
    	Connection conn = null;
    	
    	PreparedStatement pstmt = null;
    	ResultSet rs = null;
    	int telCount = 0;
    	
    	StringBuffer sql = new StringBuffer(); 
    	sql.append("SELECT COUNT(*) AS cnt ")
    	     .append("FROM member ")
    	     .append("WHERE MEM_TEL = ?");
    	
    	try {
    		conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql.toString());
			
			pstmt.setString(1, m_tel);
			
			rs = pstmt.executeQuery();
			if (rs.next()) {
				
			       telCount = rs.getInt("cnt");
			       
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			
		}finally {
			JDBCUtil.close(rs, pstmt, conn);
		}
		return telCount;
    	
    }
    
    //회원조회
    public ArrayList<memberDto> selectMember(int offset, int limit) throws Exception{
    	ArrayList<memberDto> memberList = new ArrayList<>();
    	
    	String sql = "SELECT MEM_ID, MEM_NAME, MEM_NICK, MEM_BIRTH, "
    						+ "MEM_EMAIL, MEM_GENDER, MEM_ADDRESS, MEM_TEMP " 
    						+ "FROM member ORDER BY MEM_ID LIMIT ? OFFSET ?";
    	
    	try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, limit);
	        pstmt.setInt(2, offset);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				memberDto member = new memberDto();
				member.setM_id(rs.getString("MEM_ID"));
				member.setM_nick(rs.getString("MEM_NICK"));
				member.setM_name(rs.getString("MEM_NAME"));
				member.setM_birth(rs.getDate("MEM_BIRTH"));
				member.setM_email(rs.getString("MEM_EMAIL"));
				member.setM_gender(rs.getString("MEM_GENDER"));
				member.setM_address(rs.getString("MEM_ADDRESS"));
				member.setM_temp(rs.getFloat("MEM_TEMP"));
				memberList.add(member);
			}
		}finally {
			JDBCUtil.close(rs, pstmt, conn);
		}
    	return memberList;
    	
    }
    
    //회원삭제
    public int deleteMember(String id) throws Exception {
    	String sql = "DELETE FROM member where MEM_ID = ?";
    	
    	try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			return pstmt.executeUpdate();
		} finally {
			JDBCUtil.close(null, pstmt, conn);
		}
    	
    }
    
    //회원 검색
    public ArrayList<memberDto> searchMemberId(String searchKeyword) throws Exception {
    	ArrayList<memberDto> memberList = new ArrayList<>();
    	
    	String sql ="SELECT MEM_ID, MEM_NAME, MEM_NICK, MEM_BIRTH, "
			    			+ "MEM_EMAIL, MEM_GENDER, MEM_ADDRESS, MEM_TEMP "
			                + "FROM member WHERE MEM_ID LIKE ?";
    	
    	try {
    		conn = JDBCUtil.getConnection();
    		pstmt = conn.prepareStatement(sql);
    		pstmt.setString(1, "%" + searchKeyword + "%");
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				memberDto member = new memberDto();
				member.setM_id(rs.getString("MEM_ID"));
				member.setM_nick(rs.getString("MEM_NICK"));
				member.setM_name(rs.getString("MEM_NAME"));
				member.setM_birth(rs.getDate("MEM_BIRTH"));
				member.setM_email(rs.getString("MEM_EMAIL"));
				member.setM_gender(rs.getString("MEM_GENDER"));
				member.setM_address(rs.getString("MEM_ADDRESS"));
				member.setM_temp(rs.getFloat("MEM_TEMP"));
				memberList.add(member);
			}
		} finally {
			JDBCUtil.close(rs, pstmt, conn);
		}
    	return memberList;
    	
    }
    
}