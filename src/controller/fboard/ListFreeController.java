package controller.fboard;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.fboard.FboardDAO;
import model.fboard.FboardDTO;


@WebServlet("/ListFreeController")
public class ListFreeController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private FboardDAO mdao = new FboardDAO();
  
    public ListFreeController() {
        super();
    }
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		
		System.out.println("communityPage doGet");
		try {
			ArrayList<FboardDTO> result = mdao.selectFboardAll();
			
			if(result != null) {
			    req.setAttribute("boardList", result); // 가져온 리스트를 "boardList" 속성으로 설정
			    RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/jsp/fboard/communityPage.jsp");
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
