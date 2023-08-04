package controller.notice;

import java.io.IOException;
import java.util.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import model.notice.NoticeDAO;
import model.notice.NoticeDTO;

@WebServlet("/UpdateNoticeController")
public class UpdateNoticeController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private NoticeDAO noticeDAO = new NoticeDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int no = Integer.parseInt(request.getParameter("no")); // 업데이트할 게시글의 번호
            
            System.out.println("updateMateController doGet"+no);
            NoticeDTO notice = noticeDAO.selectDetail(no);

            if (notice != null) {
				int  noticeNo = notice.getNotice_no();
				String noticeTitle = notice.getN_title();
				String memberNick = notice.getM_nick();
				String noticeContent = notice.getN_contents();
				Date noticeRegDate = notice.getN_regdate();
				String noticeisshow = notice.getN_isshow();
				
				request.setAttribute("noticeNo", noticeNo);
				request.setAttribute("noticeTitle", noticeTitle);
				request.setAttribute("memberNick", memberNick);
				request.setAttribute("noticeContent", noticeContent);
				request.setAttribute("noticeRegDate", noticeRegDate);
				request.setAttribute("noticeisshow", noticeisshow);

                RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/notice/notice_update.jsp");
                dispatcher.forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        try {
            int no = Integer.parseInt(request.getParameter("no")); // 수정할 게시글의 번호
            String noticeTitle = request.getParameter("noticeTitle"); // 수정할 글 제목
            String noticeContent = request.getParameter("noticeContent"); // 수정할 글 내용
            
            System.out.println(no);
            
            boolean isUpdated = noticeDAO.updateNotice(no, noticeTitle, noticeContent);

            if (isUpdated) {
                // 수정이 성공적으로 이루어진 경우, Gson을 사용하여 JSON 응답 생성
            	NoticeDTO notice = noticeDAO.selectDetail(no);

                Gson gson = new Gson();
                String json = gson.toJson(notice); // result 객체를 JSON 문자열로 변환

                // JSON 응답 보내기
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
