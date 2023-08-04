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

import model.fboard.FboardDAO;
import model.fboard.FboardDTO;

@WebServlet("/DeleteFreeController")
public class DeleteFreeController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private FboardDAO mdao = new FboardDAO();

    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
    	RequestDispatcher rd = req.getRequestDispatcher("/WEB-INF/jsp/fboard/read_fdetail.jsp");
        rd.forward(req, res);
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

      
        try {
            int no = Integer.parseInt(req.getParameter("f_no")); // 수정할 게시글의 번호
            System.out.println(no);
            
            
            int isDeleted = mdao.deleteFboard(no);

            if (isDeleted>0) {
                // 수정이 성공적으로 이루어진 경우, Gson을 사용하여 JSON 응답 생성
            	ArrayList<FboardDTO> result = mdao.selectFboardAll();
            	
                Gson gson = new Gson();
                String json = gson.toJson(result); // result 객체를 JSON 문자열로 변환

                // JSON 응답 보내기
                res.setContentType("application/json");
                res.setCharacterEncoding("UTF-8");
                res.getWriter().write(json);
            } else {
            	res.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            	res.getWriter().write("삭제실패");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
}
