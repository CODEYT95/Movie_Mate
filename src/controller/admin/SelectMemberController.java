package controller.admin;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.member.memberDao;
import model.member.memberDto;

@WebServlet("/SelectMemberController")
public class SelectMemberController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final int ITEMS_PER_PAGE = 2;
	
	private memberDao dao = new memberDao();
	
    public SelectMemberController() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("SelectMemberController");
		 try {
	            int currentPage = 1; 
	            String currentPageParam = request.getParameter("currentPage");
	            
	            if (currentPageParam != null) {
	                currentPage = Integer.parseInt(currentPageParam);
	            }
	            
	            int offset = (currentPage - 1) * ITEMS_PER_PAGE;
	            ArrayList<memberDto> result = dao.selectMember(offset, ITEMS_PER_PAGE);

	            	request.setAttribute("memberList", result);
	            	RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/jsp/admin/select_member.jsp");
	            	rd.forward(request, response);
				
			} catch (Exception e) {
				e.printStackTrace();
			} 
		}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}

