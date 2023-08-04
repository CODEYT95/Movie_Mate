package controller.movie;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.movie.MovieDTO;
import model.movie.ReviewDTO;
import util.JDBCUtil;

public class MovieInfo extends HttpServlet {
    private static final long serialVersionUID = 1L;

	public MovieInfo() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");

		String movieCd = request.getParameter("movieCd");
		ArrayList<String> genre = new ArrayList<String>();
		List<MovieDTO> movieList = new ArrayList<MovieDTO>();
		ArrayList<ReviewDTO> reviewList = new ArrayList<ReviewDTO>();
		MovieDTO dto = new MovieDTO();
		HashMap<String, String> actor = new HashMap<String, String>();
		JDBCUtil util = new JDBCUtil();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT * FROM movie WHERE movieCd = ?";

		try {
			conn = util.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, movieCd);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				dto.setMovieCd(movieCd);
				dto.setMovieNm(rs.getString("movieNm"));
				dto.setShowTm(rs.getString("showTm"));
				dto.setOpenDt(rs.getString("openDt"));
				dto.setNationNm(rs.getString("nationNm"));
				dto.setWatchGradeNm(rs.getString("watchGradeNm"));
			}
			rs = null;

			sql = "SELECT genreNm FROM movie_genre WHERE movieCd = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, movieCd);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				genre.add(rs.getString("genreNm"));
			}
			dto.setGenre(genre);

			rs = null;

			sql = "UPDATE movie SET hits = hits + 1 WHERE movieCd = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getMovieCd());
			pstmt.executeUpdate();

			sql = "SELECT peopleNm, cast FROM actor WHERE movieCd = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, movieCd);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				actor.put(rs.getString("peopleNm"), rs.getString("cast"));
			}
			dto.setActor(actor);
			movieList.add(dto);

			rs = null;

			sql = "SELECT m.movieNm, r.memberNc, r.review, r.writeDt FROM movie AS m JOIN review AS r ON m.movieCd = r.movieCd WHERE r.movieCd = ? ORDER BY writeDt DESC";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, movieCd);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				ReviewDTO rDTO = new ReviewDTO();
				rDTO.setMovieNm(rs.getString("movieNm"));
				rDTO.setMemberNc(rs.getString("memberNc"));
				rDTO.setReview(rs.getString("review"));
				rDTO.setWriteDt(rs.getString("writeDt"));
				reviewList.add(rDTO);
			}

			rs = null;

		} catch (SQLException e1) {
			e1.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			util.close(rs, pstmt, conn);
		}

		request.setAttribute("reviewList", reviewList);
		request.setAttribute("movieList", movieList);
		RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/jsp/movie/MovieInfo.jsp");
		rd.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

	}
}
