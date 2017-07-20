package servlet.commissary;

import dao.StockDAO;
import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Stock;

@WebServlet(name = "deleteAddItem", urlPatterns = {"/deleteAddItem"})
public class deleteAddItem extends HttpServlet {
    private static final long serialVersionUID = 1L;

	public deleteAddItem() {
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
                        String stocknametodel = (String) request.getParameter("deleteStock");
                        Stock stockobjtodel = StockDAO.getStockByName(stocknametodel);
                        ((ArrayList<Stock>)session.getAttribute("ALsuppStocks")).add(stockobjtodel);
                        
                        ArrayList<Stock> modAddedStocks = (ArrayList<Stock>)session.getAttribute("ALaddedStocks");
                        for(int i = 0;i<modAddedStocks.size();i++){
                        if(modAddedStocks.get(i).getStockId() == stockobjtodel.getStockId()){
                            modAddedStocks.remove(i);
                            }
                        }
                        session.setAttribute("ALaddedStocks", modAddedStocks);
                        
                        String msg ="Stock " + stockobjtodel.getName() + " has been deleted";
                        request.setAttribute("msg", msg);
			request.getRequestDispatcher("WEB-INF/jsp/commissary/receiveStock.jsp").forward(request, response);
                }
    }


}
