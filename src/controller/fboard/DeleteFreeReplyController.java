package controller.fboard;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import model.freply.FreplyDAO;
import model.freply.FreplyDTO;

@WebServlet("/DeleteFreeReplyController")
public class DeleteFreeReplyController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private FreplyDAO mdao = new FreplyDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/jsp/fboard/read_fdetail.jsp");
        rd.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
        	int no = Integer.parseInt(request.getParameter("no"));
            int rno = Integer.parseInt(request.getParameter("rno")); // 수정할 게시글의 번호
            System.out.println(rno);
            
            
            int isDeleted = mdao.deleteUpMateReply(rno);

            if (isDeleted>0) {
            	
            	ArrayList<FreplyDTO> result = mdao.selectFreeReplies(no);
            	
                Gson gson = new Gson();
                String json = gson.toJson(result);

                // JSON 응답 보내기
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write(json);
            } else {
            	response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            	response.getWriter().write("삭제실패");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
}
