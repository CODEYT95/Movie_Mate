package controller.login;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.member.memberDao;
import model.member.memberDto;

@WebServlet("/LoginCheckController")
public class LoginCheckController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public LoginCheckController() {
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		int num = 0;
		

        String id = req.getParameter("userId");
        
        String pwd = req.getParameter("userPw");

        System.out.println(id);
        System.out.println(pwd);

        memberDao mDao = memberDao.getInstance();
        memberDto mDto = new memberDto();

        mDto.setM_id(id);

        Map<String, String> loginResult = mDao.login(mDto);
        
        PrintWriter out = resp.getWriter();
        
        //세션에 저장된 ex)아이디를 jsp에서 불러올 때
      	//<%String userId = (String)request.getSession().getAttribute("userId");%>
        
        if ("leeyunji".equals(id) && "leeyunji".equals(pwd)) {
        	System.out.println("관리자로그인");
            HttpSession session = req.getSession();
            session.setAttribute("userId", id);
            req.getSession().setMaxInactiveInterval(1800);
            
            num = 1;

            out.write(String.valueOf(num));  // 숫자를 문자열로 변환하여 전송합니다.
		    out.close();
            
            
        } else if(loginResult!= null && loginResult.get("MEM_PW").equals(pwd)) {
        	System.out.println("회원로그인");
            HttpSession session = req.getSession();
            session.setAttribute("userNick", loginResult.get("MEM_NICK"));
            session.setAttribute("userTemp", loginResult.get("MEM_TEMP"));
            session.setAttribute("userId", id);
            req.getSession().setMaxInactiveInterval(1800);
            
            num = 2;

            out.write(String.valueOf(num));  // 숫자를 문자열로 변환하여 전송합니다.
		    out.close();
            
        } else if (loginResult!= null && !loginResult.get("MEM_PW").equals(pwd)){
        
        	num = 3;
        	
        	out.write(String.valueOf(num));  // 숫자를 문자열로 변환하여 전송합니다.
		    out.close();
        	
        }
	
	}
}
