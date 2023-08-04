package controller.admin;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import model.member.memberDao;
import model.member.memberDto;

@WebServlet("/SearchMemberController")
public class SearchMemberController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public SearchMemberController() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// GET 요청- 회원 조회 화면
		RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/jsp/admin/select_member.jsp");
        rd.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // POST 요청- 회원 검색
        String searchKeyword = request.getParameter("searchKeyword");
        System.out.println(searchKeyword);
        
        memberDao dao = new memberDao();
        ArrayList<memberDto> memberList = null;

        try {
            // 아이디로 회원 검색
            memberList = dao.searchMemberId(searchKeyword);
        } catch (Exception e) {
            e.printStackTrace();
        }

        if (memberList == null) {
            memberList = new ArrayList<>();
        }

        // 검색 결과를 JSON 형태로 변환하여 응답으로 전송
        Gson gson = new Gson();
        String json = gson.toJson(memberList);

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(json);
    }

}
