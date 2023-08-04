package controller.movie;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import util.JDBCUtil;

public class InsertReview extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final JDBCUtil util = new JDBCUtil();

	public InsertReview() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html; charset=UTF-8");
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		
		String reviewText = request.getParameter("reviewText");
		String movieCd = request.getParameter("movieCd");
		String userId = (String) session.getAttribute("userId");
		String userNc = (String) session.getAttribute("userNick");

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "INSERT INTO review VALUES (?, ?, ?, ?, ?)";
		Timestamp reviewTm = new Timestamp(System.currentTimeMillis());
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String reviewTmString = sdf.format(reviewTm);

		try {
			conn = util.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, movieCd);
			pstmt.setString(2, userId);
			pstmt.setString(3, userNc);
			pstmt.setString(4, reviewText);
			pstmt.setString(5, reviewTmString);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			util.close(rs, pstmt, conn);
		}
	}
}
