package servlet.admin;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.AuditDAO;
import dao.DepartmentDAO;
import dao.ReceiptDAO;
import model.PurchaseOrder;
import model.User;

@WebServlet("/ViewPurchaseOrder")
public class ViewPurchaseOrder extends HttpServlet {

	private static final long serialVersionUID = 1L;

    public ViewPurchaseOrder() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		if(session.getAttribute("loginUser") == null){
			request.setAttribute("message", "Redirected Back to Login Page");
			request.getRequestDispatcher("Login?action=Login");
		}
		else{
			User loginUser = (User) session.getAttribute("loginUser");
			int poId = Integer.parseInt(request.getParameter("p"));
			int comId = DepartmentDAO.getComByUserId(loginUser.getEmpId()).getComId();
			PurchaseOrder po = ReceiptDAO.getPODetails(poId, comId);
			request.setAttribute("purchaseOrder", po);
			request.getRequestDispatcher("WEB-INF/jsp/admin/viewPODetails.jsp").forward(request, response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		if(session.getAttribute("loginUser") == null){
			request.setAttribute("message", "Redirected Back to Login Page");
			request.getRequestDispatcher("Login?action=Login");
		}
		else{
			User loginUser = (User) session.getAttribute("loginUser");
			int comId = Integer.parseInt(request.getParameter("comId"));
			String msg = "";
			String startDate = request.getParameter("startDate");
			String endDate = request.getParameter("endDate");
			ArrayList<PurchaseOrder> allPo = new ArrayList<>();
			if(AuditDAO.compareDates(startDate, endDate)){
				allPo = ReceiptDAO.getAllPo(comId, startDate, endDate);
				msg = "Showing Purchase Order From " + startDate + " To " + endDate + ".";
			}
			else{
				allPo = ReceiptDAO.getAllPo(DepartmentDAO.getComByUserId(loginUser.getEmpId()).getComId());
				msg = "Invalid Input of Date. Showing All Purchase Order.";
			}
			request.setAttribute("allPo", allPo);
			request.setAttribute("msg", msg);
			request.getRequestDispatcher("WEB-INF/jsp/admin/viewAllPO.jsp").forward(request, response);;
		}
	}

}
