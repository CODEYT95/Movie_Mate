package controller.mboard;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import model.mreply.MreplyDAO;
import model.mreply.MreplyDTO;

@WebServlet("/UpdateMateReplyController")
public class UpdateMateReplyController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private MreplyDAO mreplyDAO = new MreplyDAO();
       
    public UpdateMateReplyController() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try {
			int rno = Integer.parseInt(request.getParameter("rno"));
			MreplyDTO reply = mreplyDAO.selectMateReplyOne(rno);
			
			if(reply != null) {
				int  noticeNo = reply.getBoard_no();
				int replyNo = reply.getMreply_no();
				String userNick = reply.getMem_nick();
				String replyContent = reply.getMreply_content();
				
				request.setAttribute("noticeNo", noticeNo);
				request.setAttribute("replyNo", replyNo);
				request.setAttribute("userNick", userNick);
				request.setAttribute("replyContent", replyContent);
				
				RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/mboard/read_mdetail.jsp");
	            dispatcher.forward(request, response);
				}
			 else {
				response.setStatus(HttpServletResponse.SC_BAD_REQUEST); // 잘못된 요청 상태코드(400) 반환
			}
		} catch (NumberFormatException e) {
			response.setStatus(HttpServletResponse.SC_BAD_REQUEST); // 잘못된 요청 상태코드(400) 반환
			e.printStackTrace();
		} catch (Exception e) {
			response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR); // 서버 에러 상태코드(500) 반환
			e.printStackTrace();


		} 
	}

    		  

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		System.out.println("댓글 수정 컨트롤러 진입 POST");
		try {
			HttpSession session = request.getSession();
			int rno = Integer.parseInt(request.getParameter("rno"));
			String replyContent = request.getParameter("content");
			String mem_nick = (String) session.getAttribute("userNick");
			
			
		      boolean isUpdated = mreplyDAO.updateMateReply(rno, mem_nick, replyContent);

		      if (isUpdated) {
		        MreplyDTO updatedReply = mreplyDAO.selectMateReplyOne(rno);

		        Gson gson = new Gson();
		        String json = gson.toJson(updatedReply);

		        response.setContentType("application/json");
		        response.setCharacterEncoding("UTF-8");
		        response.getWriter().write(json);
		      } else {
		        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
		        response.getWriter().write("수정실패");
		      }
		    } catch (Exception e) {
		      e.printStackTrace();
		    }
		  }
	}
