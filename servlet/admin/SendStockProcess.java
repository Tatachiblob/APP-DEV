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
import model.Branch;
import model.Inventory;
import model.User;

@WebServlet("/SendStockProcess")
public class SendStockProcess extends HttpServlet {

	private static final long serialVersionUID = 1L;

    public SendStockProcess() {
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
			String msg = "";
			String action = request.getParameter("action");
			if(action.equals("brChoosing")){
				int branchId = Integer.parseInt(request.getParameter("chosenBranch"));
				Branch br = DepartmentDAO.getBrById(branchId);
				ArrayList<Inventory> comInventory = StockDAO.getComInventory(comId);
				msg = br.getBranchName() + " Selected.";
				request.setAttribute("msg", msg);
				request.setAttribute("branchChosen", br);
				request.setAttribute("comInventory", comInventory);
			}
			if(action.equals("sendDetails")){
				boolean passedQtyTest = true;
				int branchId = Integer.parseInt(request.getParameter("branchId"));
				Branch br = DepartmentDAO.getBrById(branchId);
				ArrayList<Inventory> comInventory = StockDAO.getComInventory(comId);
				ArrayList<Inventory> comDrDetails = new ArrayList<>();
				for(int i = 0; i < comInventory.size(); i++){
					double originalQty = comInventory.get(i).getQuantity();
					double sendQty = Double.parseDouble(request.getParameter("stock" + comInventory.get(i).getStock().getStockId()));
					if(sendQty < 0){
						msg = "Sending Quantity cannot be lower than 0.";
						i = comInventory.size() + 1;
						passedQtyTest = false;
					}
					else if(sendQty > originalQty){
						msg = "Sending Quantity cannot be equal to your current stock or larger.";
						i = comInventory.size() + 1;
						passedQtyTest = false;
					}
					else{
						if(sendQty != 0){
							comDrDetails.add(new Inventory(comInventory.get(i).getStock(), sendQty));
						}
					}
				}
				if(passedQtyTest){
					if(CustomDAO.addNewComDR(comId, branchId)){
						CustomDAO.insertComDRDetails(CustomDAO.getLatestComDR(), comDrDetails);
						msg = "Stocks Sent to " + br.getBranchName() + ".";
					}
					else{
						msg = "New Delivery Receipt was not Created.";
					}
				}
				request.setAttribute("msg", msg);
			}
			request.getRequestDispatcher("WEB-INF/jsp/admin/sendStock.jsp").forward(request, response);
		}
	}

}
