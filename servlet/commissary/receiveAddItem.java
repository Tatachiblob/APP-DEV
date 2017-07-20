package servlet.commissary;

import dao.StockDAO;
import dao.SupplierDAO;
import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Stock;

@WebServlet(name = "receiveAddItem", urlPatterns = {"/receiveAddItem"})
public class receiveAddItem extends HttpServlet {
    private static final long serialVersionUID = 1L;

	public receiveAddItem() {
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
                        int stockID = Integer.parseInt(request.getParameter("stocktoadd"));
                        int qty = Integer.parseInt(request.getParameter("quantitytoadd"));
                        Stock stocktoAdd = StockDAO.getStockByID(stockID);
                        stocktoAdd.setQty(qty);
                        ((ArrayList<Stock>)session.getAttribute("ALaddedStocks")).add(stocktoAdd);
                        
                        
                        ArrayList<Stock> modSuppStocks = (ArrayList<Stock>)session.getAttribute("ALsuppStocks");
                        for(int i = 0;i<modSuppStocks.size();i++){
                        if(modSuppStocks.get(i).getStockId() == stocktoAdd.getStockId()){
                            modSuppStocks.remove(i);
                            }
                        }
                        session.setAttribute("addItemTrigger", "1");
                        session.setAttribute("ALsuppStocks", modSuppStocks);
                        
                        String msg="Item " + stocktoAdd.getName() + " has been added.";
                        request.setAttribute("receiveAddThis", stocktoAdd);
                        request.setAttribute("msg", msg);
                        session.setAttribute("receivehasAdded", "1");
			request.getRequestDispatcher("WEB-INF/jsp/commissary/receiveStock.jsp").forward(request, response);
                }
    }


}
