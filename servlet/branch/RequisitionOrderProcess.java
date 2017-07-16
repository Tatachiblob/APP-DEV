package servlet.branch;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.CustomDAO;
import dao.DepartmentDAO;
import dao.StockDAO;
import model.Branch;
import model.Inventory;
import model.User;

/**
 * Servlet implementation class RequisitionOrderProcess
 */
@WebServlet("/RequisitionOrderProcess")
public class RequisitionOrderProcess extends HttpServlet {

	private static final long serialVersionUID = 1L;

    public RequisitionOrderProcess() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		if(session.getAttribute("loginUser") == null){
			request.setAttribute("message", "Redirected Back to Login Page");
			request.getRequestDispatcher("Login?action=Login");
		}
		else{
			String msg = "";
			User loginUser = (User)session.getAttribute("loginUser");
			Branch br = DepartmentDAO.getBranchByUserId(loginUser.getEmpId());
			ArrayList<Inventory> inventory = StockDAO.getBranchInventory(br.getBranchId());
			for(Inventory i : inventory){
				i.setQuantity(Double.parseDouble(request.getParameter("endingInventory" + i.getStock().getStockId())));
			}
			if(CustomDAO.createRequisition(br.getBranchId())){
				int reqId = CustomDAO.getLatestRequisition();
				if(CustomDAO.insertRequisitionDetails(reqId, inventory)){
					msg = "Requisition Order Created";
				}
				else{
					msg = "Fail to Create Requisition Order";
				}
			}
			else{
				msg = "Fail to Create Requisition Order : Requisition Order already sent.";
			}
			request.setAttribute("msg", msg);
			request.getRequestDispatcher("WEB-INF/jsp/branch/index.jsp").forward(request, response);
		}
	}

}
