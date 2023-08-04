package controller.movie;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.movie.ReviewDTO;
import util.JDBCUtil;

public class Review extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public Review() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setContentType("text/html; charset=utf-8");

        ArrayList<ReviewDTO> reviewList = new ArrayList<ReviewDTO>();
        JDBCUtil util = new JDBCUtil();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "SELECT m.movieCd, m.movieNm, r.memberNc, r.review, r.writeDt " +
                     "FROM movie AS m JOIN review AS r ON m.movieCd = r.movieCd " +
                     "ORDER BY r.writeDt DESC";

        try {
            conn = util.getConnection();
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                ReviewDTO rDTO = new ReviewDTO();
                rDTO.setMovieCd(rs.getString("movieCd"));
                rDTO.setMovieNm(rs.getString("movieNm"));
                rDTO.setMemberNc(rs.getString("memberNc"));
                rDTO.setReview(rs.getString("review"));
                rDTO.setWriteDt(rs.getString("writeDt"));
                reviewList.add(rDTO);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            util.close(rs, pstmt, conn);
        }

        request.setAttribute("reviewList", reviewList);
        RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/jsp/movie/Review.jsp");
        rd.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }
}
