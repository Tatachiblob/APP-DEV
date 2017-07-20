package servlet.commissary;

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
import model.Stock;
import model.Supplier;
import model.User;

@WebServlet("/ReceiveStock")
public class ReceiveStock extends HttpServlet {

	private static final long serialVersionUID = 1L;

    public ReceiveStock() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
                RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp");
		dispatcher.forward(request, response);
        }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		if(session.getAttribute("loginUser") == null){
			request.setAttribute("message", "Redirected Back to Login Page");
			request.getRequestDispatcher("Login?action=Login");
		}
                else{
                       
                        User currentEmp = (User)session.getAttribute("loginUser");
                        Supplier supp = (Supplier) session.getAttribute("receivesupplier");
                        int numofitems = Integer.parseInt(request.getParameter("hiddenTextBox"));
                        int empID = currentEmp.getEmpId();
                        int drID = StockDAO.getMaxdrID(empID,supp.getSupplierId());
                        int stockchosenID = 0;
                        int stockqty = 0;
                        ArrayList<Stock> allStock = StockDAO.getStocksfromSupp(currentEmp.getEmpId(),supp.getSupplierId());

			String msg = "";
                        System.out.println("numofitems is: " + numofitems);
                        for(int i = 0;i<numofitems;i++){
                            try{
                            System.out.println("I is now: " + i);
                            Stock currStock = StockDAO.getStockByName(request.getParameter("choosestock_" + Integer.toString(i)));
                            stockchosenID = currStock.getStockId();
                                System.out.println("CURRY CHOSEN ID: " + stockchosenID);
                                
                            stockqty = Integer.parseInt(request.getParameter("quantity_" + Integer.toString(i)));
                            
                            
                            if(StockDAO.receiveStock(empID, stockqty, stockchosenID,supp.getSupplierId(),drID)){
                                msg += "\nReceived stocks for stock: " + stockchosenID;
                                System.out.println("UPDATED STOCK: " + stockchosenID);
                            }
                            }
                            catch(Exception e){
                                msg += "\nUnable to set new values for stock: " + stockchosenID;
                                System.out.println("FAILED UPDATION");
                                System.out.println("SQL ERROR: " + e);
                            }
                        }
                        // RESET THE ADDED STOCKS TABLE
                        ((ArrayList<Stock>)session.getAttribute("ALaddedStocks")).clear();
                        session.setAttribute("receivesupplier", null);
                        session.setAttribute("addItemTrigger", "0");
                        //
                        request.setAttribute("msg", msg);   
			request.getRequestDispatcher("WEB-INF/jsp/commissary/receiveStock.jsp").forward(request, response);
                    }

        }
}
