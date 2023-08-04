package controller.join;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.member.memberDao;


@WebServlet("/telCheckController")
public class telCheckController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
	}
	
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
	
		String tel = req.getParameter("userTel");

        PrintWriter out = res.getWriter();
		
		memberDao mDao = new memberDao();
		
		int telCheck = mDao.checkTel(tel);
		out.write(telCheck + "");
		out.close();
		
	}

}
