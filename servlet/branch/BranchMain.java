package servlet.branch;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/BranchMain")
public class BranchMain extends HttpServlet {

	private static final long serialVersionUID = 1L;

    public BranchMain() {
    	super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("action");
		String forward = "";
		HttpSession session = request.getSession();
		if(session.getAttribute("loginUser") == null){
			request.setAttribute("message", "Redirected Back to Login Page");
			request.getRequestDispatcher("Login?action=Login");
		}
		else{
			if(action.equals("dashboard")){
				forward = "WEB-INF/jsp/branch/index.jsp";
			}
			if(action.equals("requisition")){
				forward = "WEB-INF/jsp/branch/reqOrders.jsp";
			}
			RequestDispatcher dispatcher = request.getRequestDispatcher(forward);
			dispatcher.forward(request, response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {}

}
