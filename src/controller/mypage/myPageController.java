package controller.mypage;

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
import javax.servlet.http.HttpSession;

import model.fboard.FboardDAO;
import model.fboard.FboardDTO;
import model.movie.RankDTO;
import model.movie.ReviewDTO;
import util.JDBCUtil;

@WebServlet("/myPageController")
public class myPageController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private static FboardDAO fbDao = null;   
	
    @Override
    public void init() throws ServletException {
    	fbDao = new FboardDAO();
    }
	
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String MEM_NICK = (String) session.getAttribute("userNick");
        System.out.println(MEM_NICK);
        
        if(MEM_NICK != null && !MEM_NICK.equals("null")) {
        
        ArrayList<FboardDTO> fbList = fbDao.myRecentFboardWrite(MEM_NICK);
        
        request.setAttribute("fbList", fbList);
        
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

            sql = "SELECT r.movieCd, m.movieNm, r.review, r.memberNc " + 
            		"FROM movie m " + 
            		"JOIN review r ON m.movieCd = r.movieCd " + 
            		"WHERE r.memberNc = ? " + 
            		"LIMIT 20;";

            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, MEM_NICK);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                ReviewDTO reviewDTO = new ReviewDTO();
                reviewDTO.setMovieNm(rs.getString("movieNm"));
                reviewDTO.setReview(rs.getString("review"));
                reviewDTO.setMemberNc(rs.getString("memberNc"));
                reviewDTO.setMovieCd(rs.getString("movieCd"));

                reviewList.add(reviewDTO);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
        request.setAttribute("reviewList", reviewList);
        
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/myPage/myPage.jsp");
        dispatcher.forward(request, response);
        }else {
        	
        	 RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/login/login.jsp");
             dispatcher.forward(request, response);	
        }
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
