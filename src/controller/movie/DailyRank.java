package controller.movie;

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
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.movie.RankDTO;
import util.JDBCUtil;

public class DailyRank extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public DailyRank() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ArrayList<RankDTO> rList = new ArrayList<RankDTO>();

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
                RankDTO rDTO = new RankDTO();
                rDTO.setTargetDt(rs.getString("targetDt"));
                rDTO.setRank(rs.getInt("rank"));
                rDTO.setMovieCd(rs.getString("movieCd"));
                rDTO.setMovieNm(rs.getString("movieNm"));
                rDTO.setOpenDt(rs.getString("openDt"));
                rDTO.setAudiCnt(rs.getString("audiCnt"));
                rDTO.setAudiAcc(rs.getString("audiAcc"));
                rDTO.setUpdateRank(rs.getString("updateRank"));

                if (!rs.getString("poster").equals("empty")) {
                    rDTO.setPoster("img/poster/" + rs.getString("poster") + ".png");
                }

                rList.add(rDTO);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("yDayMD", yDayMD);
        request.setAttribute("rankList", rList);
        RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/jsp/movie/DailyRank.jsp");
        rd.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}