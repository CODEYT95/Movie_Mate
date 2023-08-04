package controller.notice;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import model.nreply.NreplyDAO;
import model.nreply.NreplyDTO;

@WebServlet("/InsertNoticeReplyController")
public class InsertNoticeReplyController extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
    public InsertNoticeReplyController() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/jsp/notice/read_detail.jsp");
		rd.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    System.out.println("insertNoticeReply doPost");

	    
	    String comments = request.getParameter("comments");
	    int no = Integer.parseInt(request.getParameter("no"));
	    String replyNick =  (String) request.getSession().getAttribute("userNick");
	    System.out.println(no);

	    NreplyDTO reply = new NreplyDTO();
	    reply.setNreply_content(comments);
	    reply.setNotice_no(no);
	    reply.setMem_nick(replyNick);

	    NreplyDAO dao = new NreplyDAO();
	    int updateResult = 0;

	    try {
	        updateResult = dao.insertNoticeReply(reply);
	        if (updateResult > 0) {

                Gson gson = new Gson();
                String jsonResponse = gson.toJson(updateResult);

                // Send the response JSON back to the client.
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                PrintWriter out = response.getWriter();
                out.print(jsonResponse);
                out.flush();
	        } else {
	            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
	            response.getWriter().write("입력실패");
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	}

}
