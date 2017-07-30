package servlet.admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.DepartmentDAO;
import dao.RequisitionDAO;
import model.Branch;
import model.RequisitionOrder;

@WebServlet("/ViewAllRequisition")
public class ViewAllRequisition extends HttpServlet {

	private static final long serialVersionUID = 1L;

    public ViewAllRequisition() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		if(session.getAttribute("loginUser") == null){
			request.setAttribute("message", "Redirected Back to Login Page");
			request.getRequestDispatcher("Login?action=Login");
		}
		else{
			int reqId = Integer.parseInt(request.getParameter("i"));
			Branch br = DepartmentDAO.getBrById(Integer.parseInt(request.getParameter("b")));
			RequisitionOrder requisitionOrder = RequisitionDAO.getSpecificRequisition(reqId);
			request.setAttribute("requisitionOrder", requisitionOrder);
			request.setAttribute("br", br);
			request.getRequestDispatcher("WEB-INF/jsp/admin/viewRequisitionDetails.jsp").forward(request, response);;
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}

}
