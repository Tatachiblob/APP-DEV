package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.EmployeeDAO;
import model.User;

@WebServlet("/ActivateAccount")
public class ActivateAccount extends HttpServlet {

	private static final long serialVersionUID = 1L;

    public ActivateAccount() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User loginUser = (User) session.getAttribute("loginUser");
		String newPassword = request.getParameter("newPassword");
		String confirmation = request.getParameter("confirmation");
		String msg = "";
		if(!newPassword.equals(confirmation)){
			msg = "New Password does not match with the confirmation. Please try again.";
			request.setAttribute("msg", msg);
			request.getRequestDispatcher("WEB-INF/jsp/activateAccount.jsp").forward(request, response);
		}
		else{
			loginUser.setPassword(newPassword);
			if(EmployeeDAO.setNewEmployeePassword(loginUser)){
				msg = "Password successfully changed. Please proceed to the login page.";
				request.setAttribute("msg", msg);
				request.getRequestDispatcher("WEB-INF/jsp/activateSuccess.jsp").forward(request, response);;
			}
			else{
				msg = "There was an error in the Database.";
				request.setAttribute("msg", msg);
				request.getRequestDispatcher("WEB-INF/jsp/activateAccount.jsp").forward(request, response);
			}
		}
	}

}