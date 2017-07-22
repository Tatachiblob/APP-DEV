package servlet.commissary;

import dao.BranchDAO;
import java.io.IOException;
import javax.servlet.RequestDispatcher;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Branch;

@WebServlet("/ComMain")
public class ComMain extends HttpServlet {

	private static final long serialVersionUID = 1L;

    public ComMain() {
    	super();
    }
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("action");
		String forward = "";
		HttpSession session = request.getSession();
                session.setAttribute("JAKEZYRUS", "DYEYK");
		if(session.getAttribute("loginUser") == null){
			request.setAttribute("message", "Redirected Back to Login Page");
			request.getRequestDispatcher("Login?action=Login");
		}
		else{
			if(action.equals("dashboard")){
				forward = "WEB-INF/jsp/commissary/index.jsp";
			}
			if(action.equals("receiveStock")){
				forward = "WEB-INF/jsp/commissary/receiveStock.jsp";
			}
			if(action.equals("sendStock")){
				forward = "WEB-INF/jsp/commissary/sendStock.jsp";
			}
                        if(action.equals("viewStockAvailability")){
                                forward = "WEB-INF/jsp/commissary/viewStockAvailability.jsp";
                        }
		}
		RequestDispatcher dispatcher = request.getRequestDispatcher(forward);
		dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}

}


