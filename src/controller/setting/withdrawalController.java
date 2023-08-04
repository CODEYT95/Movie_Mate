package controller.setting;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.member.memberDao;
import model.member.memberDto;

@WebServlet("/withdrawalController")
public class withdrawalController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		String val = req.getParameter("next");
		
		if(val == null) {
			RequestDispatcher rd = req.getRequestDispatcher("/WEB-INF/jsp/setting/withdrawal1.jsp");
			rd.forward(req, resp);
		}else {
			RequestDispatcher rd = req.getRequestDispatcher("/WEB-INF/jsp/setting/withdrawal2.jsp");
			rd.forward(req, resp);
		}
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("userId");
		
		memberDao mDao = memberDao.getInstance();
		memberDto mDto = new memberDto();
		
		mDto.setM_id(id);
		
		int deleteUserInfo = mDao.deleteMember(mDto);
		
		if(deleteUserInfo == 1) {
			session.invalidate(); // 세션 무효화
	        response.setStatus(HttpServletResponse.SC_OK); 
			response.sendRedirect("mainController");
		}
	}

}
