package controller.join;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.member.memberDao;


@WebServlet("/idCheckController")
public class idCheckController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String userId = req.getParameter("userId");
		
		PrintWriter out = res.getWriter();
		
		memberDao mDao = new memberDao();
		
		int idCheck = mDao.checkId(userId);	
		
		out.write(idCheck + "");
		out.close();
	}

}
