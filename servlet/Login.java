package servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.EmployeeDAO;
import model.User;

@WebServlet("/Login")
public class Login extends HttpServlet {

	private static final long serialVersionUID = 1L;

    public Login() {}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String userName = request.getParameter("username");
		String password = request.getParameter("password");
		//System.out.println(userName);
		//System.out.println(password);
		User tryLogin =  EmployeeDAO.getUser(userName, password);
		String forward = "";
		if(tryLogin != null){
			if(tryLogin.getUserType() == 1){
				forward = "WEB-INF/jsp/admin/index.jsp";
			}
			else if(tryLogin.getUserType() == 2){
				forward = "WEB-INF/jsp/branch/index.jsp";
			}
			else if(tryLogin.getUserType() == 3){
				forward = "WEB-INF/jsp/commissary/index.jsp";
			}
		}
		else{
			forward = "index.jsp";
			String message = "Username or Password is incorrect";
			request.setAttribute("message", message);
		}
		RequestDispatcher dispatcher = request.getRequestDispatcher(forward);
		dispatcher.forward(request, response);
	}

}
