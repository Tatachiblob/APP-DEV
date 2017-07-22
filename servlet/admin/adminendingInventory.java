package servlet.admin;

import dao.CommissaryDAO;
import dao.StockDAO;
import java.io.IOException;
import javax.servlet.RequestDispatcher;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Commissary;
import model.Stock;
import model.User;

@WebServlet("/adminendingInventory")
public class adminendingInventory extends HttpServlet {

	private static final long serialVersionUID = 1L;

    public adminendingInventory() {
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
                        if(action.equals("countItems")){
                        User currentEmp = (User)session.getAttribute("loginUser");
                        Commissary thisCom = (Commissary) session.getAttribute("selectedCom");
                        
                        int numofitems = Integer.parseInt(request.getParameter("numofrows"));
                        int cominvID = CommissaryDAO.getMaxCommissaryInventoryID();
                        int stockdispncyqty = 0;
                        int stockchosenID = 0;
                        int stockqty = 0;
                        int adjustqty = 0;
			String msg = "";
                        String inimsg = "";
                        CommissaryDAO.inventoryCount(thisCom.getComId());
                        for(int i = 0;i<numofitems;i++){
                            try{
                            Stock currStock = StockDAO.getStockByName(request.getParameter("countstock_" + Integer.toString(i)));
                            stockchosenID = currStock.getStockId();
                            stockqty = Integer.parseInt(request.getParameter("countstockqty_" + Integer.toString(i)));
                            adjustqty = Integer.parseInt(request.getParameter("ending_" + Integer.toString(i)));
                            int diff = adjustqty - stockqty;
                            System.out.println("TO PASS: " + " COMINVID: " + cominvID + " STOCKCHOSENID: " + stockchosenID + " STOCKQTY: " + stockqty + " DIFF: " + diff + " THISCOMID: " + thisCom.getComId() );
                            CommissaryDAO.inventoryCountItems(cominvID, stockchosenID, stockqty, diff, adjustqty, thisCom.getComId());
                            if(diff > 0){
                                inimsg += "\nStock " + currStock.getName() + " has a SURPLUS discrepancy.";
                                }
                            else if(diff < 0){
                                inimsg += "\nStock " + currStock.getName() + " has a LOSS discrepancy.";
                                }
                            }
                            catch(Exception e){
                                msg += "ERROR: Ending inventory Error in Loop iteration: " + i;
                                System.out.println("SQL ERROR: " + e.toString());
                            }
                        }
                        msg = "Counting done. " + inimsg;
                        request.setAttribute("msg", msg);
                        forward = "WEB-INF/jsp/admin/endingInventory.jsp";
                        }
                        
		}
		RequestDispatcher dispatcher = request.getRequestDispatcher(forward);
		dispatcher.forward(request, response);
	}

}


