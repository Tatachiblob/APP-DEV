package servlet.admin;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/AdminMain")
public class AdminMain extends HttpServlet {

	private static final long serialVersionUID = 1L;

    public AdminMain() {
    	super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("action");
		String forward = "";
		if(action.equals("dashboard")){
			forward = "WEB-INF/jsp/admin/index.jsp";
		}
		if(action.equals("inventory")){
			//forward = "WEB-INF/jsp/admin/inventory.jsp";
		}
		if(action.equals("employees")){
			//forward = "WEB-INF/jsp/admin/account.jsp";
		}
		if(action.equals("reports")){
			//forward = "WEB-INF/jsp/admin/reports.jsp";
		}
		RequestDispatcher dispatcher = request.getRequestDispatcher(forward);
		dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {}

}
