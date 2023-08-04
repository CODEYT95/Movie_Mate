package controller.login;

import java.io.IOException;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.member.memberDao;
import model.member.memberDto;

@WebServlet("/LoginController")
public class LoginController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/jsp/login/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("utf-8");

        String id = req.getParameter("ID");
        
        String pwd = req.getParameter("PW");

        System.out.println(id);
        System.out.println(pwd);

        memberDao mDao = memberDao.getInstance();
        memberDto mDto = new memberDto();

        mDto.setM_id(id);

        Map<String, String> loginResult = mDao.login(mDto);
        
        System.out.println( loginResult.get("MEM_NICK"));
        
        //세션에 저장된 ex)아이디를 jsp에서 불러올 때
      	//<%String userId = (String)request.getSession().getAttribute("userId");%>
        
        if ("leeyunji".equals(id) && "leeyunji".equals(pwd)) {
        	System.out.println("관리자로그인");
            HttpSession session = req.getSession();
            session.setAttribute("userId", id);
            req.getSession().setMaxInactiveInterval(1800);
            req.getRequestDispatcher("/WEB-INF/jsp/member/agreeView.jsp").forward(req, resp);
            
        } else if(loginResult!= null && loginResult.get("MEM_PW").equals(pwd)) {
        	System.out.println("회원로그인");
            HttpSession session = req.getSession();
            session.setAttribute("userNick", loginResult.get("MEM_NICK"));
            session.setAttribute("userTemp", loginResult.get("MEM_TEMP"));
            session.setAttribute("userId", id);
            req.getSession().setMaxInactiveInterval(1800);
            resp.sendRedirect("mainContorller");
            
        } else {
        	  String errorMessage = "등록되지 않은 아이디 이거나 아이디 또는 비밀번호가 맞지 않습니다";
        	  String script = "<script type='text/javascript'>alert('" + errorMessage + "');</script>";
        	  resp.getWriter().write(script);
        	}
        }
}
