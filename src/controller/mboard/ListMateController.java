package controller.mboard;

import java.io.IOException;
import java.util.ArrayList;


import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.mboard.MboardDAO;
import model.mboard.MboardDTO;


@WebServlet("/ListMateController")
public class ListMateController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private MboardDAO mdao = new MboardDAO();
  
    public ListMateController() {
        super();
    }
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		
		System.out.println("communityPage doGet");
		try {
			ArrayList<MboardDTO> result = mdao.selectAll();
			
			if(result != null) {
			    req.setAttribute("boardList", result); // 가져온 리스트를 "boardList" 속성으로 설정
			    RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/jsp/mboard/communityPage.jsp");
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
