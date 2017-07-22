package servlet.admin;

import servlet.commissary.*;
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

@WebServlet("/ViewStockAvailability")
public class ViewStockAvailability extends HttpServlet {

	private static final long serialVersionUID = 1L;

    public ViewStockAvailability() {
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
                            forward = "WEB-INF/jsp/admin/viewStockAvailability.jsp";
			}
                        
                        
		}
		RequestDispatcher dispatcher = request.getRequestDispatcher(forward);
		dispatcher.forward(request, response);
	}

}


