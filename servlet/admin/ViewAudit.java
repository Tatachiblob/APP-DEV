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
import dao.StockDAO;
import model.ComDelivery;
import model.MonthlyInventory;
import model.Stock;
import model.SupplierDRDetails;

@WebServlet("/ViewAudit")
public class ViewAudit extends HttpServlet {

	private static final long serialVersionUID = 1L;

    public ViewAudit() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		if(session.getAttribute("loginUser") == null){
			request.setAttribute("message", "Redirected Back to Login Page");
			request.getRequestDispatcher("Login?action=Login");
		}
		else{
			int comId = Integer.parseInt(request.getParameter("comID"));
			int stockId = Integer.parseInt(request.getParameter("stockID"));
			Stock stock = StockDAO.getStockById(stockId);
			ArrayList<SupplierDRDetails> supplierDelivery = AuditDAO.getSupplierDRDetails(comId, stockId);
			ArrayList<ComDelivery> commissaryDelivery = AuditDAO.getComDeliveryDetails(comId, stockId);
			ArrayList<MonthlyInventory> comMonthly = AuditDAO.getComMonthlyInventory(comId, stockId);
			request.setAttribute("supplierDelivery", supplierDelivery);
			request.setAttribute("commissaryDelivery", commissaryDelivery);
			request.setAttribute("comMonthly", comMonthly);
			request.setAttribute("selectedStock", stock);
			request.setAttribute("msg", "Showing This Month's Audit Trail");
			request.getRequestDispatcher("WEB-INF/jsp/admin/viewStockAudit.jsp").forward(request, response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		if(session.getAttribute("loginUser") == null){
			request.setAttribute("message", "Redirected Back to Login Page");
			request.getRequestDispatcher("Login?action=Login");
		}
		else{
			String msg = "";
			int comId = Integer.parseInt(request.getParameter("comID"));
			int stockId = Integer.parseInt(request.getParameter("stockID"));
			Stock stock = StockDAO.getStockById(stockId);
			String startDate = request.getParameter("startDate");
			String endDate = request.getParameter("endDate");
			ArrayList<SupplierDRDetails> supplierDelivery = null;
			ArrayList<ComDelivery> commissaryDelivery = null;
			ArrayList<MonthlyInventory> comMonthly = null;
			if(AuditDAO.compareDates(startDate, endDate)){
				supplierDelivery = AuditDAO.getSupplierDRDetails(comId, stockId, startDate, endDate);
				commissaryDelivery = AuditDAO.getComDeliveryDetails(comId, stockId, startDate, endDate);
				msg = "Showing Audit Trail from " + startDate + " to " + endDate + ".";
			}
			else{
				supplierDelivery = AuditDAO.getSupplierDRDetails(comId, stockId);
				commissaryDelivery = AuditDAO.getComDeliveryDetails(comId, stockId);
				msg = "Invalid Input of Date Range. Showing Default Audit Trail";
			}
			System.out.println(AuditDAO.compareDates(startDate, endDate));
			comMonthly = AuditDAO.getComMonthlyInventory(comId, stockId);
			request.setAttribute("supplierDelivery", supplierDelivery);
			request.setAttribute("commissaryDelivery", commissaryDelivery);
			request.setAttribute("comMonthly", comMonthly);
			request.setAttribute("selectedStock", stock);
			request.setAttribute("msg", msg);
			request.getRequestDispatcher("WEB-INF/jsp/admin/viewStockAudit.jsp").forward(request, response);
		}
	}

}
