package util;

import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Connection;

public class JDBCUtil {
	
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	
		//DB 커넥션
		public static  Connection getConnection() throws Exception {
	    	String url = "jdbc:mysql://172.30.1.95:80/moviemate?useUnicode=true&characterEncoding=utf8";
	    	String id  = "MMAdmin";
	    	String pw  = "elwuTwy";

	    	Class.forName("com.mysql.cj.jdbc.Driver");
	    	Connection conn = DriverManager.getConnection(url, id, pw);

	    	return conn;
		}
		//자원반환
		public static void close(ResultSet rs, PreparedStatement stmt, Connection conn){
			try {
				if(rs!=null) {rs.close();}
				if(stmt!=null) {stmt.close();}
				if(conn!=null) {conn.close();}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
}
