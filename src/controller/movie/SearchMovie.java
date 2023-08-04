package controller.movie;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.movie.MovieDTO;
import util.JDBCUtil;

public class SearchMovie extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public SearchMovie() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		JDBCUtil util = new JDBCUtil();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT movieCd, movieNm FROM movie WHERE movieCd NOT IN "
				+ "(SELECT movieCd FROM movie_genre WHERE genreNm LIKE '%성인%') AND watchGradeNm NOT LIKE '%청소년%' AND watchGradeNm NOT LIKE '%19%' "
				+ "ORDER BY hits DESC LIMIT 10";
		ArrayList<MovieDTO> hitsRank = new ArrayList<MovieDTO>();

		try {
			conn = util.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				MovieDTO mDTO = new MovieDTO();
				mDTO.setMovieCd(rs.getString("movieCd"));
				mDTO.setMovieNm(rs.getString("movieNm"));
				hitsRank.add(mDTO);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			util.close(rs, pstmt, conn);
		}

		request.setAttribute("hitsRank", hitsRank);
		RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/jsp/movie/SearchMovie.jsp");
		rd.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}
}
