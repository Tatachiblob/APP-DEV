package servlet.admin;

import java.io.IOException;

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

@WebServlet("/AddStock")
public class AddStock extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public AddStock() {
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
			String prodname = request.getParameter("stockName");
			String sku = request.getParameter("sku");
			double flrlvl = Double.parseDouble(request.getParameter("floorLvl"));
			double ceilLvl = Double.parseDouble(request.getParameter("ceilLvl"));
			int supplierId = Integer.parseInt(request.getParameter("assignSupplier"));
			String msg = "";
			Stock newStock = new Stock(prodname, sku, flrlvl, ceilLvl);
			Supplier supplier = SupplierDAO.getSupplierById(supplierId);
			if(flrlvl >= ceilLvl){
				msg = "Unable to Add New Stock : Floor Level cannot be grater than Ceil Level";
			}
			else{
				if(StockDAO.addNewStock(newStock)){
					newStock = StockDAO.getStockByName(prodname);
					if(StockDAO.assignSupplier(supplier, newStock)){
						msg = "Stock Added and Assigned to a supplier";
					}
					else{
						msg = "Stock Added but failed to be assigned to a supplier";
					}
				}
				else{
					msg = "Unable to add new stock information";
				}
			}
			request.setAttribute("msg", msg);
			request.getRequestDispatcher("WEB-INF/jsp/admin/addStock.jsp").forward(request, response);
		}
	}

    }


