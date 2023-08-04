package controller.community;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.notice.NoticeDAO;
import model.notice.NoticeDTO;
import model.fboard.FboardDAO;
import model.fboard.FboardDTO;

@WebServlet("/freeCommunityController")
public class freeCommunityController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // 한 페이지 당 게시글 수
    private static final int ITEMS_PER_PAGE = 10;
    private NoticeDAO noticeDAO = new NoticeDAO();
    private FboardDAO fBoardDAO = new FboardDAO();
    private FboardDAO fboardDAO = new FboardDAO(); // 클래스 멤버 변수로 FboardDAO 객체 선언

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String mem_nick = (String) session.getAttribute("userNick");
        System.out.println(mem_nick);

        if(mem_nick != null && !mem_nick.equals("null")) {
        
        ArrayList<NoticeDTO> noticeList;
        try {
            noticeList = noticeDAO.selectNoticeAll();
            request.setAttribute("noticeList", noticeList);

            int currentPage = 1;
            String currentPageParam = request.getParameter("currentPage");

            if (currentPageParam != null) {
                currentPage = Integer.parseInt(currentPageParam);
            }

            int offset = (currentPage - 1) * ITEMS_PER_PAGE;

            ArrayList<FboardDTO> fBoardList = fBoardDAO.selectfBoardPage(offset, ITEMS_PER_PAGE);
            request.setAttribute("fBoardList", fBoardList);

            Map<String, Integer[]> fboardMap = fboardDAO.getFboardStatisticsByMemNick(mem_nick);
            if (fboardMap.containsKey(mem_nick)) {
                Integer[] fboardValue = fboardMap.get(mem_nick);
                int fb_title_count = fboardValue[0];
                int freply_content_count = fboardValue[1];
                request.setAttribute("writeCount", fb_title_count);
                request.setAttribute("replyCount", freply_content_count);
            }else {
            	 request.setAttribute("writeCount", 0);
                 request.setAttribute("replyCount", 0);
            }

            RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/jsp/fCommunity/loginFreeBoard.jsp");
            rd.forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        }
        }else {
        	
        	ArrayList<NoticeDTO> noticeList;
            try {
                noticeList = noticeDAO.selectNoticeAll();
                request.setAttribute("noticeList", noticeList);

                int currentPage = 1;
                String currentPageParam = request.getParameter("currentPage");

                if (currentPageParam != null) {
                    currentPage = Integer.parseInt(currentPageParam);
                }

                int offset = (currentPage - 1) * ITEMS_PER_PAGE;

                ArrayList<FboardDTO> fBoardList = fBoardDAO.selectfBoardPage(offset, ITEMS_PER_PAGE);
                request.setAttribute("fBoardList", fBoardList);

                RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/jsp/fCommunity/freeBoard.jsp");
                rd.forward(request, response);
            } catch (Exception e) {
                e.printStackTrace();
            }
        	
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

}
