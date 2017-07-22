package servlet.admin;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/AdminMain")
public class AdminMain extends HttpServlet {

	private static final long serialVersionUID = 1L;

    public AdminMain() {
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
			if(action.equals("addDept")){
				forward = "WEB-INF/jsp/admin/addDept.jsp";
			}
			if(action.equals("addEmp")){
				forward = "WEB-INF/jsp/admin/addEmp.jsp";
			}
			if(action.equals("editEmp")){
				forward = "WEB-INF/jsp/admin/editEmpView.jsp";
			}
			if(action.equals("viewDept")){
				forward = "WEB-INF/jsp/admin/viewDept.jsp";
			}
			if(action.equals("reqOrders")){
				forward = "WEB-INF/jsp/admin/viewRequisitionOrder.jsp";
			}
			if(action.equals("receiveStock")){
				forward = "WEB-INF/jsp/admin/stockReceive.jsp";
			}
			if(action.equals("sendStock")){
				forward = "WEB-INF/jsp/admin/sendStock.jsp";
			}
			if(action.equals("newInventory")){
				forward = "WEB-INF/jsp/admin/addStock.jsp";
			}
			if(action.equals("newSupplier")){
				forward = "WEB-INF/jsp/admin/newSupplier.jsp";
			}
		}
		RequestDispatcher dispatcher = request.getRequestDispatcher(forward);
		dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {}

}
