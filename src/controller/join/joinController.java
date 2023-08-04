
package controller.join;

import java.io.IOException;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.member.memberDao;
import model.member.memberDto;

@WebServlet("/joinController")
public class joinController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private static final String agreeview = "/WEB-INF/jsp/join/agreeView.jsp";
    private static final String joinview1 = "/WEB-INF/jsp/join/joinView1.jsp";
    private static final String joinview2 = "/WEB-INF/jsp/join/joinView2.jsp";
    private static final String joinview3 = "/WEB-INF/jsp/join/joinView3.jsp";
    private static final String joinview4 = "/WEB-INF/jsp/join/joinView4.jsp";
    private static final String joinview5 = "/WEB-INF/jsp/join/joinView5.jsp";
    private static final String complete = "/WEB-INF/jsp/join/joinView6.jsp";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        	RequestDispatcher rd = req.getRequestDispatcher(agreeview);
            rd.forward(req, resp);       
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        String next = req.getParameter("next");
       
        switch (next) {
      
        	case "1":
        		RequestDispatcher rd = req.getRequestDispatcher(joinview1);
        		
                rd.forward(req, resp); 
                break;
        	case "2":
                String name = req.getParameter("userName");
                String gender = req.getParameter("userGender");

                String year = req.getParameter("year");
                String month = req.getParameter("month");
                String day = req.getParameter("day");

                String dateString = year + "-" + month + "-" + day;

                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

                java.sql.Date birthDate = null;
                try {
                    java.util.Date utilDate = dateFormat.parse(dateString);
                    birthDate = new java.sql.Date(utilDate.getTime());
                } catch (ParseException e) {
                    e.printStackTrace();
                }

                req.getSession().setAttribute("join_name", name);
                req.getSession().setAttribute("join_gender", gender);
                req.getSession().setAttribute("join_birth", birthDate);
                
                RequestDispatcher rd1 = req.getRequestDispatcher(joinview2);
                rd1.forward(req, resp); 

                break;

            case "3":
                String id = req.getParameter("userId");
                String pw = req.getParameter("userPw");

                req.getSession().setAttribute("join_id", id);
                req.getSession().setAttribute("join_pw", pw);

                RequestDispatcher rd2 = req.getRequestDispatcher(joinview3);
                rd2.forward(req, resp); 
                
                break;

            case "4":
                String nick = req.getParameter("userNick");

                req.getSession().setAttribute("join_nick", nick);

                RequestDispatcher rd3 = req.getRequestDispatcher(joinview4);
                rd3.forward(req, resp); 
                
                break;

            case "5":
                String tel = req.getParameter("userTel");
                String[] addressArr = req.getParameterValues("userAddr_Gu[]");
                String address = "서울시" + " " +  addressArr[0];

                req.getSession().setAttribute("join_tel", tel);
                req.getSession().setAttribute("join_address", address);
                
                RequestDispatcher rd4 = req.getRequestDispatcher(joinview5);
                rd4.forward(req, resp); 

                break;

            case "6":
                String email1 = req.getParameter("userEmail");
                String[] emailArr = req.getParameterValues("userEmail[]");
                String emailselect = emailArr[0];
                String email = email1 + "@" + emailselect;

                req.getSession().setAttribute("join_email", email);
                
                RequestDispatcher rd5 = req.getRequestDispatcher(complete);
                rd5.forward(req, resp); 

                break;

            case "7":
                String[] m_genre = req.getParameterValues("genre[]");
                if (m_genre == null) {
                    m_genre = new String[3];
                }

                String m_name = (String) req.getSession().getAttribute("join_name");
                String m_gender = (String) req.getSession().getAttribute("join_gender");
                Date m_birth = (Date) req.getSession().getAttribute("join_birth");
                String m_id = (String) req.getSession().getAttribute("join_id");
                String m_pw = (String) req.getSession().getAttribute("join_pw");
                String m_nick = (String) req.getSession().getAttribute("join_nick");
                String m_tel = (String) req.getSession().getAttribute("join_tel");
                String m_address = (String) req.getSession().getAttribute("join_address");
                String m_email = (String) req.getSession().getAttribute("join_email");
                String m_genre1 = m_genre[0];
                String m_genre2 = m_genre[1];
                String m_genre3 = m_genre[2];
                
                memberDao mDao = memberDao.getInstance();
                memberDto mDto = new memberDto();

                mDto.setM_id(m_id);
                mDto.setM_pw(m_pw);
                mDto.setM_name(m_name);
                mDto.setM_nick(m_nick);
                mDto.setM_birth(m_birth);
                mDto.setM_email(m_email);
                mDto.setM_gender(m_gender);
                mDto.setM_pn(m_tel);
                mDto.setM_address(m_address);
                mDto.setM_genre1(m_genre1);
                mDto.setM_genre2(m_genre2);
                mDto.setM_genre3(m_genre3);

                int insertUserInfo = mDao.insertMember(mDto);
                
                

                if (insertUserInfo == 1) {
                	mDao.insertGenre(m_id, m_genre1, m_genre2, m_genre3);
                	
                	HttpSession session = req.getSession();
                	session.removeAttribute("join_name");
                	session.removeAttribute("join_gender");
                	session.removeAttribute("join_birth");
                	session.removeAttribute("join_id");
                	session.removeAttribute("join_pw");
                	session.removeAttribute("join_nick");
                	session.removeAttribute("join_tel");
                	session.removeAttribute("join_address");
                	session.removeAttribute("join_email");
                	
                	
                	resp.sendRedirect(req.getContextPath() + "/LoginController");
                	
                } else {
                	
                	resp.sendRedirect(req.getContextPath() + "/LoginController");
                	
                }
                break;

            default:
                resp.sendRedirect(req.getContextPath() + "joinController");
                break;
        }
    }
}
