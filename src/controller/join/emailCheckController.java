package controller.join;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.member.memberDao;


@WebServlet("/emailCheckController")
public class emailCheckController extends HttpServlet {
	private static final long serialVersionUID = 1L; 
	
		protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
			
		}
	
		protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		    String userEmail = req.getParameter("email");
		    String emailSelect = req.getParameter("option");  // 파라미터 이름을 소문자로 변경합니다.
		    
		    String email = userEmail + "@" + emailSelect;

		    PrintWriter out = res.getWriter();
			
		    memberDao mDao = new memberDao();
		    
		    if(userEmail != "" && userEmail != null && emailSelect != "" && emailSelect != null) {
		    	int emailCheck = mDao.checkEmail(email);
		    out.write(String.valueOf(emailCheck));  // 숫자를 문자열로 변환하여 전송합니다.
		    out.close();
		    }
		}
}
