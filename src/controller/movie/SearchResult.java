package controller.movie;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.movie.MovieDTO;
import util.JDBCUtil;

public class SearchResult extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final JDBCUtil util = new JDBCUtil();
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private Statement stmt = null;
	private ResultSet rs = null;

	public SearchResult() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");

		String search = request.getParameter("search");
		List<MovieDTO> searchList = new ArrayList<MovieDTO>();
		int cnt = 0;

		try {
			conn = util.getConnection();
			String sql = "(SELECT * FROM movie WHERE movieNm LIKE '%" + search
					+ "%' AND movieCd NOT IN (SELECT movieCd FROM movie_genre WHERE genreNm LIKE '%성인%') AND watchGradeNm NOT LIKE '%청소년%' AND watchGradeNm NOT LIKE '%19%') "
					+ "UNION "
					+ "(SELECT * FROM movie WHERE movieCd IN (SELECT movieCd FROM actor WHERE peopleNm LIKE '%" + search
					+ "%' OR cast LIKE '%" + search
					+ "%' ) AND  movieCd NOT IN (SELECT movieCd FROM movie_genre WHERE genreNm LIKE '%성인%') AND watchGradeNm NOT LIKE '%청소년%' AND watchGradeNm NOT LIKE '%19%') ORDER BY hits DESC";
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
			rs = stmt.executeQuery(sql);

			rs.last();
			cnt += rs.getRow();
			if (cnt > 0) {
				rs.beforeFirst();
			}
			while (rs.next()) {
				MovieDTO mDTO = new MovieDTO();
				mDTO.setMovieCd(rs.getString("movieCd"));
				mDTO.setMovieNm(rs.getString("movieNm"));
				String openDt = rs.getString("openDt");
				if (rs.getString("openDt") == null) {

				} else {
					mDTO.setOpenDt(rs.getString("openDt").substring(0, 4));
				}
				searchList.add(mDTO);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				rs.close();
				stmt.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		request.setAttribute("searchCnt", cnt);
		request.setAttribute("searchList", searchList);
		RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/jsp/movie/SearchResult.jsp");
		rd.forward(request, response);
	}
}
