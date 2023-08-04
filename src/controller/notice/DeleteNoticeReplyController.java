package controller.notice;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import model.nreply.NreplyDAO;
import model.nreply.NreplyDTO;

@WebServlet("/DeleteNoticeReplyController")
public class DeleteNoticeReplyController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private NreplyDAO mdao = new NreplyDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/jsp/notice/read_detail.jsp");
        rd.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	System.out.println("대글삭제~");
      
        try {
        	int no = Integer.parseInt(request.getParameter("no"));
            int rno = Integer.parseInt(request.getParameter("rno")); // 수정할 게시글의 번호
            System.out.println(rno);
            
            
            int isDeleted = mdao.deleteUpNoticeReply(rno);

            if (isDeleted>0) {
                // 수정이 성공적으로 이루어진 경우, Gson을 사용하여 JSON 응답 생성
            	ArrayList<NreplyDTO> result = mdao.selectReplies(no);
            	
                Gson gson = new Gson();
                String json = gson.toJson(result); // result 객체를 JSON 문자열로 변환

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
