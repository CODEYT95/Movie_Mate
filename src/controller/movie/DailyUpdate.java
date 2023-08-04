package controller.movie;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.MalformedURLException;
import java.net.URL;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.TimerTask;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import model.movie.RankDTO;
import util.JDBCUtil;

public class DailyUpdate extends TimerTask {

	@Override
	public void run() {

		JDBCUtil util = new JDBCUtil();
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "INSERT INTO daily_rank (`targetDt`, `rank`, `movieCd`, `movieNm`, `openDt`, `audiCnt`, `audiAcc`, `updateRank`, `poster`) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
		String key = "29f10974e0116f86bc64f754583e62f7";
		Calendar calender = new GregorianCalendar();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd");
		calender.add(Calendar.DATE, -1);
		String yDay = sdf.format(calender.getTime());
		String result = null;
		ResultSet rs = null;

		try {
			conn = util.getConnection();
			URL url = new URL(
					"http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=" + key
							+ "&targetDt=" + yDay);
			BufferedReader bf;

			bf = new BufferedReader(new InputStreamReader(url.openStream(), "UTF-8"));
			result = bf.readLine();

			JSONParser jsonPaser = new JSONParser();
			JSONObject jsonObject = (JSONObject) jsonPaser.parse(result);
			JSONObject boxOfficeResult = (JSONObject) jsonObject.get("boxOfficeResult");
			JSONArray dailyBoxOfficeList = (JSONArray) boxOfficeResult.get("dailyBoxOfficeList");

			for (int i = 0; i < 10; i++) {
				JSONObject movie = (JSONObject) dailyBoxOfficeList.get(i);

				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, (sdf2.format(calender.getTime())));
				pstmt.setInt(2, Integer.parseInt((String) movie.get("rank")));
				pstmt.setString(3, (String) movie.get("movieCd"));
				pstmt.setString(4, (String) movie.get("movieNm"));
				pstmt.setString(5, (String) movie.get("openDt"));
				pstmt.setString(6, (String) movie.get("audiCnt"));
				pstmt.setString(7, (String) movie.get("audiAcc"));
				pstmt.setString(9, (String) movie.get("movieCd"));

				String rankInten = null;
				if (((String) movie.get("rankOldAndNew")).equals("NEW")) {
					rankInten = "NEW";
				} else if (Integer.parseInt((String) movie.get("rankInten")) > 0) {
					rankInten = "▲" + ((String) movie.get("rankInten"));
				} else if (Integer.parseInt((String) movie.get("rankInten")) < 0) {
					rankInten = "▼" + (Integer.parseInt((String) movie.get("rankInten")) * (-1));
				} else {
					rankInten = "-";
				}

				pstmt.setString(8, rankInten);

				pstmt.executeUpdate();
			}

		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (ParseException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			util.close(rs, pstmt, conn);
		}
	}
}
