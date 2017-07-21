package servlet.commissary;

import dao.BranchDAO;
import dao.CommissaryDAO;
import dao.StockDAO;
import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Branch;
import model.Stock;
import model.User;

@WebServlet("/sendStock")
public class sendStock extends HttpServlet {

	private static final long serialVersionUID = 1L;

    public sendStock() {
    	super();
    }
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
                String action = request.getParameter("action");
		String forward = "";
		HttpSession session = request.getSession();
		if(session.getAttribute("loginUser") == null){
			request.setAttribute("message", "Redirected Back to Login Page");
			request.getRequestDispatcher("Login?action=Login");
		}
		else{
			if(action.equals("changeBranch")){
                            Branch selectedBranch = BranchDAO.getBranchById(Integer.parseInt(request.getParameter("choosebranch")));
                            String msg = "Branch was changed to " + selectedBranch.getBranchName();
                            request.setAttribute("msg", msg);
                            session.setAttribute("selectedBranch", selectedBranch);
                            forward = "WEB-INF/jsp/commissary/sendStock.jsp";
			}
                        if(action.equals("sendStocks")){
                        User currentEmp = (User)session.getAttribute("loginUser");
                        Branch branch = (Branch) session.getAttribute("selectedBranch");
                        int numofitems = Integer.parseInt(request.getParameter("numofitems"));
                        int empID = currentEmp.getEmpId();
                        int drID = CommissaryDAO.makeDR(empID, branch.getBranchId());
                        int stockchosenID = 0;
                        int stockqty = 0;
                        int j = 0;
			String msg = "Updated stocks: ";
                        for(int i = 0;i<numofitems;i++){
                            try{
                            Stock currStock = StockDAO.getStockByName(request.getParameter("choosestock_" + Integer.toString(i)));
                            stockchosenID = currStock.getStockId();
                            stockqty = Integer.parseInt(request.getParameter("quantity_" + Integer.toString(i)));
                            if(stockqty != 0){
                                if(CommissaryDAO.sendStock(empID, stockqty, stockchosenID,branch.getBranchId(),drID)){
                                    if(j == 0){
                                        msg += currStock.getName();
                                        j++;
                                        }
                                    else
                                        msg += ", " + currStock.getName();
                                }
                            }
                            }
                            catch(Exception e){
                                msg += "\nUnable to set new values for stock: " + stockchosenID;
                                System.out.println("FAILED UPDATION");
                                System.out.println("SQL ERROR: " + e);
                            }
                        }
                        session.setAttribute("selectedBranch", null);
                        request.setAttribute("msg", msg);
                        forward = "WEB-INF/jsp/commissary/sendStock.jsp";
                        }
                        
		}
		RequestDispatcher dispatcher = request.getRequestDispatcher(forward);
		dispatcher.forward(request, response);
	}

}


