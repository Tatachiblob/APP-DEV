package servlet.admin;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.StockDAO;
import dao.SupplierDAO;
import model.Stock;
import model.Supplier;

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
			request.getRequestDispatcher("WEB-INF/jsp/admin/stockReceive.jsp").forward(request, response);
		}
	}

}
