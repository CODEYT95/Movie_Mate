package controller.fboard;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.freply.FreplyDAO;
import model.fboard.FboardDAO;
import model.freply.FreplyDTO;
import model.fboard.FboardDTO;


@WebServlet("/ReadFreeDetailController")
public class ReadFreeDetailController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private FboardDAO mdao = new FboardDAO();
    private FreplyDAO replyDAO = new FreplyDAO();
  
    public ReadFreeDetailController() {
        super();
    }
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		System.out.println("read_free_mdetail doGet");
	    int no = Integer.parseInt((String)req.getParameter("f_no"));
	    System.out.println(no);
	    ArrayList<FreplyDTO> result = null;
	    try {
	    	mdao.viewCount(no);
	        result = replyDAO.selectFreeReplies(no);
	        if (result == null) {
	            result = new ArrayList<FreplyDTO>();
	        }
	    } catch (Exception e1) {
	        e1.printStackTrace();
	    }
	    req.setAttribute("result", result);
		try {
			FboardDTO fboard = mdao.selectFboardDetail(no);
			
			if(fboard != null) {
				int  fboardNo = fboard.getFboard_no();
				String m_nick = fboard.getMem_nick();
				String fboardTitle = fboard.getFb_title();
				String fboardContent = fboard.getFb_content();
				Date fboardRegDate = fboard.getFb_regdate();
				String fboardisshow = fboard.getFb_isshow();
				
				req.setAttribute("fboardNo", fboardNo);
				req.setAttribute("m_nick", m_nick);
				req.setAttribute("fboardTitle", fboardTitle);
				req.setAttribute("fboardContent", fboardContent);
				req.setAttribute("fboardRegDate", fboardRegDate);
				req.setAttribute("fboardisshow", fboardisshow);
		        
				RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/jsp/fboard/read_fdetail.jsp");
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
