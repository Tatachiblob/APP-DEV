package servlet.admin;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.DeliveryReceiptDAO;
import dao.DepartmentDAO;
import dao.StockDAO;
import dao.SupplierDAO;
import model.Inventory;
import model.Stock;
import model.Supplier;
import model.User;

@WebServlet("/ReceiveStockProcess")
public class ReceiveStockProcess extends HttpServlet {

	private static final long serialVersionUID = 1L;

    public ReceiveStockProcess() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session  = request.getSession();
		if(session.getAttribute("loginUser") == null){
			request.setAttribute("message", "Redirected Back to Login Page");
			request.getRequestDispatcher("Login?action=Login");
		}
		else{
			User loginUser = (User) session.getAttribute("loginUser");
			String type = request.getParameter("type");
			String message = "";
			if(type.equals("changeSupplier")){
				Supplier chosenSupplier = SupplierDAO.getSupplierById(Integer.parseInt(request.getParameter("supplier")));
				ArrayList<Stock> supplierStock = StockDAO.getStockFromSupplier(chosenSupplier.getSupplierId());
				message = chosenSupplier.getSupplierName() + " chosen";
				request.setAttribute("chosenSupplier", chosenSupplier);
				request.setAttribute("supplierStock", supplierStock);
				request.setAttribute("msg", message);
			}
			if(type.equals("receive")){
				boolean qtyTest = true;
				int supplierID = Integer.parseInt(request.getParameter("supplierID"));
				int comID = DepartmentDAO.getComByUserId(loginUser.getEmpId()).getComId();
				ArrayList<Stock> supplierStock = StockDAO.getStockFromSupplier(supplierID);
				ArrayList<Inventory> deliveryDetails = new ArrayList<>();
				for(int i = 0; i < supplierStock.size(); i++){
					if(request.getParameter("stock" + supplierStock.get(i).getStockId()) == null){
						message = "Invalid Input. Empty input detected.";
						qtyTest = false;
						i = supplierStock.size() + 1;
					}
					else{
						double receiveQty = Double.parseDouble(request.getParameter("stock" + supplierStock.get(i).getStockId()));
						if(receiveQty < 0){
							message = "Receiving Quantity Cannot be lower than 0";
							qtyTest = false;
							i = supplierStock.size() + 1;
						}
						else{
							if(receiveQty != 0){
								Inventory in = new Inventory(supplierStock.get(i), receiveQty);
								deliveryDetails.add(in);
							}
						}
					}
				}
				if(qtyTest){
					if(deliveryDetails.size() != 0){
						if(DeliveryReceiptDAO.addNewDeliveryReceipt(supplierID, comID)){
							int drId = DeliveryReceiptDAO.getLatestDrID();
							DeliveryReceiptDAO.insertDeliveryDetails(drId, deliveryDetails);
							message = "Successfully Received Stocks from Supplier";
						}
						else{
							message = "Cannot Add Delivery Receipt Into System.";
						}
					}
					else{
						message = "Delivery Details Content is Empty. Did not receive any stocks.";
					}
				}
				request.setAttribute("msg", message);
			}
			request.getRequestDispatcher("WEB-INF/jsp/admin/stockReceive.jsp").forward(request, response);
		}
	}

}
