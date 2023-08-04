package controller.main;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.GregorianCalendar;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.movie.RankDTO;
import model.movie.ReviewDTO;
import model.notice.NoticeDAO;
import model.notice.NoticeDTO;
import model.fboard.FboardDAO;
import model.fboard.FboardDTO;
import util.JDBCUtil;

@WebServlet("/mainController")
public class mainController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ArrayList<RankDTO> rankList = new ArrayList<RankDTO>();
        ArrayList<ReviewDTO> reviewList = new ArrayList<ReviewDTO>();

        Calendar calendar = new GregorianCalendar();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat sdfMD = new SimpleDateFormat("M월 d일 ");
        calendar.add(Calendar.DATE, -1);
        String yDay = sdf.format(calendar.getTime());
        String yDayMD = sdfMD.format(calendar.getTime());

        JDBCUtil util = new JDBCUtil();
        Connection conn;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM daily_rank AS dr WHERE targetDt = ? ORDER BY dr.rank";
        try {
            conn = util.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, yDay);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                RankDTO rankDTO = new RankDTO();
                rankDTO.setTargetDt(rs.getString("targetDt"));
                rankDTO.setRank(rs.getInt("rank"));
                rankDTO.setMovieCd(rs.getString("movieCd"));
                rankDTO.setMovieNm(rs.getString("movieNm"));
                rankDTO.setOpenDt(rs.getString("openDt"));
                rankDTO.setAudiCnt(rs.getString("audiCnt"));
                rankDTO.setAudiAcc(rs.getString("audiAcc"));
                rankDTO.setUpdateRank(rs.getString("updateRank"));

                if (!rs.getString("poster").equals("empty")) {
                    rankDTO.setPoster("img/poster/" + rs.getString("poster") + ".png");
                }

                rankList.add(rankDTO);
            }

            sql = "SELECT m.movieCd AS movieCd, m.movieNm AS movieNm, r.review AS review, r.memberNc AS memberNc FROM movie AS m JOIN review AS r ON m.movieCd = r.movieCd ORDER BY r.writeDT DESC";

            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                ReviewDTO reviewDTO = new ReviewDTO();
                reviewDTO.setMovieCd(rs.getString("movieCd"));
                reviewDTO.setMovieNm(rs.getString("movieNm"));
                reviewDTO.setReview(rs.getString("review"));
                reviewDTO.setMemberNc(rs.getString("memberNc"));

                reviewList.add(reviewDTO);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
        NoticeDAO nDao = null;
        nDao = new NoticeDAO();
        
        ArrayList<NoticeDTO> noticeList;
		try {
			noticeList = nDao.selectNoticeFive();
			request.setAttribute("noticeList", noticeList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		FboardDAO fDao = null;
        fDao = new FboardDAO();
		
		ArrayList<FboardDTO> fBoardList;
		fBoardList =  fDao.recentFboardWrite();
		request.setAttribute("fBoardList",fBoardList);

        request.setAttribute("yDayMD", yDayMD);
        request.setAttribute("rankList", rankList);
        request.setAttribute("reviewList", reviewList);
        RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/jsp/main/mainPage.jsp");
        rd.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

}
