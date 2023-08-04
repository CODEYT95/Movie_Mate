package controller.notice;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.notice.NoticeDAO;
import model.notice.NoticeDTO;
import model.nreply.NreplyDAO;
import model.nreply.NreplyDTO;


@WebServlet("/ReadNoticeDetailController")
public class ReadNoticeDetailController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private NoticeDAO noticeDAO = new NoticeDAO();
    private NreplyDAO replyDAO = new NreplyDAO();

    public ReadNoticeDetailController() {
        super();
    }
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		int no = Integer.parseInt(request.getParameter("no"));
		
		ArrayList<NreplyDTO> result = null;
		try {
			result = replyDAO.selectReplies(no);
			request.setAttribute("result", result);
			System.out.println(result);
		} catch (Exception e1) {
			e1.printStackTrace();
		}
		request.setAttribute("result", result);
		
		System.out.println("readNoticeDetail doGetppp");
		try {
			NoticeDTO notice = noticeDAO.selectDetail(no);
			
			if(notice != null) {
				int  noticeNo = notice.getNotice_no();
				String noticeTitle = notice.getN_title();
				String memberNick = notice.getM_nick();
				String noticeContent = notice.getN_contents();
				Date noticeRegDate = notice.getN_regdate();
				String noticeIsshow = notice.getN_isshow();
				
				request.setAttribute("noticeNo", noticeNo);
				request.setAttribute("noticeTitle", noticeTitle);
				request.setAttribute("memberNick", memberNick);
				request.setAttribute("noticeContent", noticeContent);
				request.setAttribute("noticeRegDate", noticeRegDate);
				request.setAttribute("noticeIsshow", noticeIsshow);
		        
				RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/notice/read_detail.jsp");
				dispatcher.forward(request, response);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int no = Integer.parseInt(request.getParameter("no"));
		request.getSession().setAttribute("noticeNo", no);
		response.sendRedirect(request.getContextPath() + "/noticeBoardController");
	}

}
