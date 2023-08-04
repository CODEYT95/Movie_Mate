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

@WebServlet("/updateController")
public class updateController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		String userNick = (String) session.getAttribute("userNick");
		System.out.println(userNick);
		
		if(userNick==null) {
			RequestDispatcher rd = req.getRequestDispatcher("/LoginController");
			rd.forward(req, resp);
		}else {
			RequestDispatcher rd = req.getRequestDispatcher("/WEB-INF/jsp/setting/editInfo.jsp");
			rd.forward(req, resp);
		} 
		
		
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();

		
		String id = (String) session.getAttribute("userId");
		String pw = req.getParameter("updatePw");
		String nick = req.getParameter("updateNick");
		String tel = req.getParameter("updateTel");
		String[] addr = req.getParameterValues("userAddr_Gu[]");
		String address = "서울시" + " " + addr[0];
		
		memberDao mDao = memberDao.getInstance();
		memberDto mDto = new memberDto();
		
		mDto.setM_id(id);
		mDto.setM_pw(pw);
		mDto.setM_nick(nick);
		mDto.setM_pn(tel);
		mDto.setM_address(address);
		
		int updateUserInfo = mDao.updateMember(mDto);
		System.out.println("메소드 통과함"+updateUserInfo);
	
		if(updateUserInfo == 1) {
			resp.sendRedirect("settingController");
			
	}
}
}
