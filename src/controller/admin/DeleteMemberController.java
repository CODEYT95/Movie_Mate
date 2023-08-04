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

/**
 * Servlet implementation class MemberDeleteController
 */
@WebServlet("/DeleteMemberController")
public class DeleteMemberController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final int ITEMS_PER_PAGE = 2;
	memberDao dao = new memberDao();
       
    public DeleteMemberController() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/jsp/admin/select_member.jsp");
        rd.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//Ajax로 전달한 회원 아이디
		String id = request.getParameter("memberId");
		System.out.println(id);
		
		try {
			int isDeleted = dao.deleteMember(id);
			
			if(isDeleted > 0) {
				int currentPage = 1; // Default to the first page
	            String currentPageParam = request.getParameter("currentPage");
	            if (currentPageParam != null) {
	                currentPage = Integer.parseInt(currentPageParam);
	            }
	            
	            int offset = (currentPage - 1) * ITEMS_PER_PAGE;
	            ArrayList<memberDto> result = dao.selectMember(offset, ITEMS_PER_PAGE);

            	request.setAttribute("memberList", result);
            	RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/jsp/admin/select_member.jsp");
            	rd.forward(request, response);
			
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
