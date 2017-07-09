
package servlet.admin;



import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.StockDAO;
import model.Stock;

@WebServlet(name = "AddStock", urlPatterns = {"/AddStock"})
public class AddStock extends HttpServlet {
    
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
			String prodname = request.getParameter("prodname");
			String sku = request.getParameter("sku");
			float flrlvl = Float.parseFloat(request.getParameter("flrlvl"));
			String msg = "";
                        Stock newStock = new Stock(prodname, sku, flrlvl);
                        if(StockDAO.addNewStock(newStock)){
                            msg = "Stock Added!";
                        }else{
                            msg = "Unable to add new stock information";
                        }
			request.setAttribute("msg", msg);
			request.getRequestDispatcher("WEB-INF/jsp/admin/addStock.jsp").forward(request, response);
		}
	}
    
    }

 
