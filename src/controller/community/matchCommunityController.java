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
import model.mboard.MboardDAO;
import model.mboard.MboardDTO;

@WebServlet("/matchCommunityController")
public class matchCommunityController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	 // 한 페이지 당 게시글 수
    private static final int ITEMS_PER_PAGE = 10;
    private NoticeDAO noticeDAO = new NoticeDAO();
    private MboardDAO mBoardDAO = new MboardDAO();
    private MboardDAO mboardDAO = new MboardDAO(); // 클래스 멤버 변수로 FboardDAO 객체 선언
	
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

                ArrayList<MboardDTO> mBoardList = mBoardDAO.selectfBoardPage(offset, ITEMS_PER_PAGE);
                request.setAttribute("mBoardList", mBoardList);

                Map<String, Integer[]> mboardMap = mBoardDAO.getFboardStatisticsByMemNick(mem_nick);
                if (mboardMap.containsKey(mem_nick)) {
                	System.out.println();
                    Integer[] mboardValue = mboardMap.get(mem_nick);
                    int mb_title_count = mboardValue[0];
                    int mreply_content_count = mboardValue[1];
                    request.setAttribute("writeCount", mb_title_count);
                    request.setAttribute("replyCount", mreply_content_count);
                } else {
                    request.setAttribute("writeCount", 0);
                    request.setAttribute("replyCount", 0);
                }

                RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/jsp/mCommunity/loginMatchBoard.jsp");
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

                    ArrayList<MboardDTO> mBoardList = mboardDAO.selectfBoardPage(offset, ITEMS_PER_PAGE);
                    request.setAttribute("mBoardList", mBoardList);

                    RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/jsp/mCommunity/matchBoard.jsp");
                    rd.forward(request, response);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            	
            }
        
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
	
	}

}
