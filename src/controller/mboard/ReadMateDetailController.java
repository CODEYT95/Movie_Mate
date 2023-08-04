package controller.mboard;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.mreply.MreplyDAO;
import model.mboard.MboardDAO;
import model.mreply.MreplyDTO;
import model.mboard.MboardDTO;


@WebServlet("/ReadMateDetailController")
public class ReadMateDetailController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private MboardDAO mdao = new MboardDAO();
    private MreplyDAO replyDAO = new MreplyDAO();
  
    public ReadMateDetailController() {
        super();
    }
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		int no = Integer.parseInt(req.getParameter("no"));
		
		System.out.println("read_mdetail doGet");
		ArrayList<MreplyDTO> result = null;
		try {
			
			mdao.viewCount(no);
			result = replyDAO.selectMateReplies(no);
		} catch (Exception e1) {
			e1.printStackTrace();
		}
		req.setAttribute("result", result);
		try {
			MboardDTO mboard = mdao.selectDetail(no);
			if(mboard != null) {
				int  boardNo = mboard.getBoardNo();
				String m_nick = mboard.getMem_nick();
				String boardTitle = mboard.getBoardTitle();
				String boardContent = mboard.getBoardContents();
				Date boardRegDate = mboard.getBoardRegdate();
				String boardisshow = mboard.getB_isshow();
				
				req.setAttribute("boardNo", boardNo);
				req.setAttribute("m_nick", m_nick);
				req.setAttribute("boardTitle", boardTitle);
				req.setAttribute("boardContent", boardContent);
				req.setAttribute("boardRegDate", boardRegDate);
				req.setAttribute("boardisshow", boardisshow);
		        
				RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/jsp/mboard/read_mdetail.jsp");
				dispatcher.forward(req, res);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doGet(req, res);
	}

}
