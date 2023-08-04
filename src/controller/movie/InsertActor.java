package controller.movie;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.MalformedURLException;
import java.net.URL;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import kr.or.kobis.kobisopenapi.consumer.rest.KobisOpenAPIRestService;
import util.JDBCUtil;

public class InsertActor extends JDBCUtil {
	private final static String key = "d8b57e47c963e69619777b7f5d613263";
	private final static KobisOpenAPIRestService service = new KobisOpenAPIRestService(key);
	private static String sql1 = "SELECT movieCd FROM MOVIE";
	private static String sql2 = "INSERT IGNORE INTO actor VALUES(?, ?, ?)";
	private static Statement stmt = null;
	private static PreparedStatement pstmt = null;

	public static void main(String[] args) {
		JDBCUtil util = new JDBCUtil();
		Connection conn = null;
		ResultSet rs = null;
		String result = "";
		ResultSetMetaData rsmd = null;
		String[] movieCdCnt = null;
		BufferedReader bf = null;
		int cnt = 0;

		try {
			conn = util.getConnection();
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
			rs = stmt.executeQuery(sql1);

			rs.last();
			movieCdCnt = new String[rs.getRow()];
			rs.beforeFirst();

			while (rs.next()) {
				movieCdCnt[cnt] = rs.getString(1);
				cnt++;
			}
		} catch (SQLException e2) {
			e2.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			util.close(rs, pstmt, conn);
			System.out.println(movieCdCnt.length);
		}

		cnt = 0;

		try {
			conn = util.getConnection();
			pstmt = conn.prepareStatement(sql2);

			for (int x = 41000; x < 41718; x++) {
				URL url = new URL("http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json?key="
						+ key + "&movieCd=" + movieCdCnt[x]);
				bf = new BufferedReader(new InputStreamReader(url.openStream(), "UTF8"));
				result = bf.readLine();
				JSONParser jsonParser = new JSONParser();
				JSONObject jsonObject = (JSONObject) jsonParser.parse(result);
				JSONObject movieInfoResult = (JSONObject) jsonObject.get("movieInfoResult");
				JSONObject movieInfo = (JSONObject) movieInfoResult.get("movieInfo");
				JSONArray actors = (JSONArray) movieInfo.get("actors");
				if (actors.isEmpty()) {

				} else {
					for (int i = 0; i < actors.size(); i++) {
						JSONObject actorsPeopleNm = (JSONObject) actors.get(i);
						String peopleNm = (String) actorsPeopleNm.get("peopleNm");
						String cast = (String) actorsPeopleNm.get("cast");
						pstmt.setString(1, movieCdCnt[x]);
						pstmt.setString(2, peopleNm);
						pstmt.setString(3, cast);
 
						pstmt.addBatch();
						pstmt.clearParameters();
					}
				}
				if ((x % 100) == 0) {
					pstmt.executeBatch();
					pstmt.clearBatch();
					System.out.println(x);
				}
			}
		} catch (IOException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ParseException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}

		try {
			pstmt.executeBatch();
			pstmt.clearBatch();
			System.out.println("완료");
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			util.close(rs, pstmt, conn);
		}
	}
}
