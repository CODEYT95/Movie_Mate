package controller.fboard;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import model.fboard.FboardDAO;
import model.fboard.FboardDTO;

@WebServlet("/UpdateFreeController")
public class UpdateFreeController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private FboardDAO mdao = new FboardDAO();

    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        try {
            int no = Integer.parseInt(req.getParameter("no")); // 업데이트할 게시글의 번호
            
            System.out.println("updateFreeController doGet"+no);
            FboardDTO result = mdao.selectFboardDetail(no);

            if (result != null) {
            	int fboardNo = result.getFboard_no();
                String boardTitle = result.getFb_title();
                String m_nick = result.getMem_nick();
                String boardContents = result.getFb_content();

                req.setAttribute("fboardNo",fboardNo);
                req.setAttribute("m_nick", m_nick);
                req.setAttribute("boardTitle", boardTitle);
                req.setAttribute("boardContents", boardContents);

                RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/jsp/fboard/free_update.jsp");
                dispatcher.forward(req, res);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        System.out.println("UpdateMateController - doPost");
        System.out.println("no: " + req.getParameter("no"));
        System.out.println("boardTitle: " + req.getParameter("boardTitle"));
        System.out.println("boardContents: " + req.getParameter("boardContents"));
        try {
            int no = Integer.parseInt(req.getParameter("no")); // 수정할 게시글의 번호
            String boardTitle = req.getParameter("boardTitle"); // 수정할 글 제목
            String boardContents = req.getParameter("boardContents"); // 수정할 글 내용
           
            System.out.println(no);
            System.out.println(boardTitle);
            System.out.println(boardContents);
            
            
            boolean isUpdated = mdao.update(no, boardTitle, boardContents);

            if (isUpdated) {
                // 수정이 성공적으로 이루어진 경우, Gson을 사용하여 JSON 응답 생성
            	FboardDTO result = mdao.selectFboardDetail(no);
            	
                Gson gson = new Gson();
                String json = gson.toJson(result); // result 객체를 JSON 문자열로 변환

                // JSON 응답 보내기
                res.setContentType("application/json");
                res.setCharacterEncoding("UTF-8");
                res.getWriter().write(json);
            } else {
            	res.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            	res.getWriter().write("수정실패");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
}
