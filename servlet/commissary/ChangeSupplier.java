
package servlet.commissary;

import dao.SupplierDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Stock;
import model.Supplier;

@WebServlet(name = "ChangeSupplier", urlPatterns = {"/ChangeSupplier"})
public class ChangeSupplier extends HttpServlet {
    private static final long serialVersionUID = 1L;

	public ChangeSupplier() {
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
                        Supplier selectedsupp = SupplierDAO.getSupplierById(Integer.parseInt(request.getParameter("choosesupp")));
                        String msg = "Supplier was changed to " + selectedsupp.getSupplierName();
                        request.setAttribute("msg", msg);
                        session.setAttribute("receivehasAdded", "SHIT");
                        ((ArrayList<Stock>)session.getAttribute("ALaddedStocks")).clear();
                        session.setAttribute("receivesupplier", selectedsupp);
			request.getRequestDispatcher("WEB-INF/jsp/commissary/receiveStock.jsp").forward(request, response);
                }
    }


}
