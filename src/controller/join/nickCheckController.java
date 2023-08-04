package controller.join;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.member.memberDao;


@WebServlet("/nickCheckController")
public class nickCheckController extends HttpServlet {
	private static final long serialVersionUID = 1L; 
	
	 public nickCheckController() {
	    }


		protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
			
		}
	
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String nickName = req.getParameter("userNick");

        PrintWriter out = res.getWriter();
		
		memberDao mDao = new memberDao();
		
		int nickCheck = mDao.checkNick(nickName);
		
		out.write(nickCheck + "");
		out.close();
	}

}
