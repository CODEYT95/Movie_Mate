package controller.notice;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.notice.NoticeDAO;
import model.notice.NoticeDTO;

@WebServlet("/noticeBoardController")
public class noticeBoardController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	private static NoticeDAO nDao = null;
	
	@Override
	public void init() throws ServletException {
		nDao = new NoticeDAO();
	}

	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	
	try {
		ArrayList<NoticeDTO> noticeList = nDao.selectNoticeAll();
		
        for (NoticeDTO notice : noticeList) {
            int noticeNo = notice.getNotice_no();
            int commentCount = nDao.getCommentCount(noticeNo);
            notice.setCommentCount(commentCount);
        }

		req.setAttribute("noticeList", noticeList);
		
		RequestDispatcher rd = req.getRequestDispatcher("/WEB-INF/jsp/notice/noticeBoard.jsp");
		rd.forward(req, resp);
        
	} catch (Exception e) {
		e.printStackTrace();
	}
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
