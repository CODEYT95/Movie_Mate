package controller.fboard;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import model.freply.FreplyDAO;
import model.freply.FreplyDTO;

@WebServlet("/InsertFreeReplyController")
public class InsertFreeReplyController extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
    public InsertFreeReplyController() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/jsp/fboard/read_fdetail.jsp");
		rd.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    System.out.println("insertNoticeReply doPost");

	    HttpSession session = request.getSession();
	    
	    String mem_nick = (String) session.getAttribute("userNick");
	    String comments = request.getParameter("comments");
	    int no = Integer.parseInt(request.getParameter("f_no"));
	    System.out.println(no);

	    FreplyDTO reply = new FreplyDTO();
	    reply.setFreply_content(comments);
	    reply.setFboard_no(no);
	    reply.setMem_nick(mem_nick);
	    

	    FreplyDAO dao = new FreplyDAO();
	    int updateResult = 0;

	    try {
	        updateResult = dao.insertFreeReply(reply);
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
