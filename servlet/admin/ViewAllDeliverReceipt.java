package servlet.admin;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.DepartmentDAO;
import dao.ReceiptDAO;
import dao.SupplierDAO;
import model.Branch;
import model.Commissary;
import model.Inventory;
import model.Supplier;

@WebServlet("/ViewAllDeliverReceipt")
public class ViewAllDeliverReceipt extends HttpServlet {

	private static final long serialVersionUID = 1L;

    public ViewAllDeliverReceipt() {
        super();

    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		if(session.getAttribute("loginUser") == null){
			request.setAttribute("message", "Redirected Back to Login Page");
			request.getRequestDispatcher("Login?action=Login");
		}
		else{
			String action = request.getParameter("action");
			String forward = "";
			if(action.equals("supplier")){
				int supDrId = Integer.parseInt(request.getParameter("i"));
				Supplier supplier = SupplierDAO.getSupplierById(Integer.parseInt(request.getParameter("s")));
				ArrayList<Inventory> deliveryDetails = ReceiptDAO.getSupplierDeliveryDetails(supDrId);
				request.setAttribute("deliveryDetails", deliveryDetails);
				request.setAttribute("deliverySupplier", supplier);
				forward = "WEB-INF/jsp/admin/viewSpecificSupplierDelivery.jsp";
			}
			if(action.equals("comDr")){
				int comDrId = Integer.parseInt(request.getParameter("i"));
				Commissary com = DepartmentDAO.getComById( Integer.parseInt(request.getParameter("com")));
				Branch br = DepartmentDAO.getBrById(Integer.parseInt(request.getParameter("b")));
				ArrayList<Inventory> ComDrDetails = ReceiptDAO.getSpecificComDr(comDrId);
				request.setAttribute("com", com);
				request.setAttribute("comDrDetails", ComDrDetails);
				request.setAttribute("br", br);
				forward = "WEB-INF/jsp/admin/viewSpecificComDr.jsp";
			}
			request.getRequestDispatcher(forward).forward(request, response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}

}
