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
import model.Inventory;
import model.User;

@WebServlet("/EndingInventoryProcess")
public class EndingInventoryProcess extends HttpServlet {

	private static final long serialVersionUID = 1L;

    public EndingInventoryProcess() {
        super();
    }
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String msg = "";
		if(session.getAttribute("loginUser") == null){
			request.setAttribute("message", "Redirected Back to Login Page");
			request.getRequestDispatcher("Login?action=Login");
		}
		else{
			User loginUser = (User) session.getAttribute("loginUser");
			int comId = Integer.parseInt(request.getParameter("comId"));
			ArrayList<Inventory> comInventory = CustomDAO.getCurrentComInventory(comId);
			ArrayList<Inventory> endingInventory = new ArrayList<>();
			for(Inventory i : comInventory){
				double endingQty = Double.parseDouble(request.getParameter("stock" + i.getStock().getStockId()));
				endingInventory.add(new Inventory(i.getStock(), endingQty));
				System.out.println("Stock Name: " + i.getStock().getName());
				System.out.println("Ending Stock Qty: " + endingQty + i.getStock().getUnit());
			}
			if(CustomDAO.insertComMonthlyInventory(comId)){
				int monthlyInv = CustomDAO.getLatestMonthlyInventoryID(comId);
				CustomDAO.insertMonthlyInventory(monthlyInv, endingInventory);
				msg = "Adusted Commissary's Ending Inventory";
			}
			else{
				msg = "Cannot Add Monthly Inventory at the Same Month";
			}
			request.setAttribute("message", msg);
			request.getRequestDispatcher("WEB-INF/jsp/admin/index.jsp").forward(request, response);
		}
	}

}
