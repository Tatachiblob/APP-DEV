package servlet.admin;

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
import dao.SupplierDAO;
import model.Inventory;
import model.Stock;
import model.Supplier;
import model.User;

@WebServlet("/CreatePurchaseOrder")
public class CreatePurchaseOrder extends HttpServlet {

	private static final long serialVersionUID = 1L;

    public CreatePurchaseOrder() {
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
			User loginUser = (User) session.getAttribute("loginUser");
			int comId = DepartmentDAO.getComByUserId(loginUser.getEmpId()).getComId();
			String action = request.getParameter("action");
			String msg = "";
			if(action.equals("changeSupplier")){
				int supplierId = Integer.parseInt(request.getParameter("supplier"));
				Supplier supplier = SupplierDAO.getSupplierById(supplierId);
				ArrayList<Stock> supplierStock = StockDAO.getStockFromSupplier(supplierId);
				msg = supplier.getSupplierName() + " Chosen";
				request.setAttribute("supplier", supplier);
				request.setAttribute("supplierStock", supplierStock);
				request.setAttribute("msg", msg);
			}
			if(action.equals("purchase")){
				int supplierID = Integer.parseInt(request.getParameter("supplierID"));
				Supplier supplier = SupplierDAO.getSupplierById(supplierID);
				ArrayList<Stock> supplierStock = StockDAO.getStockFromSupplier(supplierID);
				ArrayList<Inventory> purchaseStock = new ArrayList<>();
				for(Stock s : supplierStock){
					double purchaseQty = Double.parseDouble(request.getParameter("stock" + s.getStockId()));
					if(purchaseQty != 0){
						purchaseStock.add(new Inventory(s, purchaseQty));
					}
				}
				if(purchaseStock.size() == 0){
					msg = "Purchase Order Detail is Empty. Please Fill in Quantity to ";
				}
				else{
					if(CustomDAO.insertPurchaseOrder(comId, supplierID)){
						int poId = CustomDAO.getLatestPurchaseOrderId(comId);
						CustomDAO.insertPurchaseOrderDetails(poId, purchaseStock);
						msg = "Success in Creating Purchase Order.";
					}
					else{
						msg = "Failed to Create Purchase Order.";
					}
				}
				request.setAttribute("msg", msg);
			}
			request.getRequestDispatcher("WEB-INF/jsp/admin/createPurchaseOrder.jsp").forward(request, response);
		}
	}

}
