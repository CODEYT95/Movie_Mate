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

import model.notice.NoticeDAO;
import model.notice.NoticeDTO;

@WebServlet("/InsertNoticeController")
public class InsertNoticeController extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
    public InsertNoticeController() {
        super();
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/jsp/notice/notice_insert.jsp");
		rd.forward(request, response);
	}

	 protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
	        
	 	System.out.println("dopost");

	 	
        String title = request.getParameter("title");
        String content = request.getParameter("content");

        NoticeDTO notice = new NoticeDTO();
        notice.setN_title(title);
        notice.setN_contents(content);
        
        NoticeDAO dao = new NoticeDAO();
        int insertResult = 0;

        try {
			insertResult = dao.insertNotice(notice);
            System.out.println(insertResult);
            if(insertResult>0) {
            	
            	Gson gson = new Gson();
            	String jsonResponse = gson.toJson(insertResult);

                // Send the response JSON back to the client
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                PrintWriter out = response.getWriter();
                out.print(jsonResponse);
                out.flush();
            }else {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                response.getWriter().write("입력실패");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } 

	    }
}