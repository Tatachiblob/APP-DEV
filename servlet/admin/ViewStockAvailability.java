package servlet.admin;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.CustomDAO;
import dao.DepartmentDAO;
import model.Branch;
import model.Inventory;

@WebServlet("/ViewStockAvailability")
public class ViewStockAvailability extends HttpServlet {

	private static final long serialVersionUID = 1L;

    public ViewStockAvailability() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int brId = Integer.parseInt(request.getParameter("chosenBranch"));
		Branch br = DepartmentDAO.getBrById(brId);
		ArrayList<Inventory> brInventory = CustomDAO.getCurrentBrInventory(br.getBranchId());
		request.setAttribute("curBranch", br);
		request.setAttribute("brInventory", brInventory);
		request.getRequestDispatcher("WEB-INF/jsp/admin/viewStockAvailability.jsp").forward(request, response);;
	}

}
