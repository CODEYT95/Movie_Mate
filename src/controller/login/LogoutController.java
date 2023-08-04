package controller.login;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/LogoutController")
public class LogoutController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	
    	HttpSession session = request.getSession();
        session.invalidate(); // 세션 무효화
        response.setStatus(HttpServletResponse.SC_OK); 
        
        response.sendRedirect("http://localhost:8081/MovieMate/mainController");

    	
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	
    	
    	System.out.println("세션 무효화");
    	HttpSession session = request.getSession();
        session.invalidate(); // 세션 무효화
        response.setStatus(HttpServletResponse.SC_OK); 

        
    }

}
