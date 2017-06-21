package servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.EmployeeDAO;
import model.User;

@WebServlet("/Login")
public class Login extends HttpServlet {

	private static final long serialVersionUID = 1L;

    public Login() {}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp");
		dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String userName = request.getParameter("username");
		String password = request.getParameter("password");
		//System.out.println(userName);
		//System.out.println(password);
		User tryLogin =  EmployeeDAO.getUser(userName, password);
		String forward = "";
		if(tryLogin != null){
			HttpSession session = request.getSession();
			session.setAttribute("loginUser", tryLogin);
			if(tryLogin.getUserType() == 101){
				forward = "AdminMain?action=dashboard";
				response.sendRedirect(forward);
			}
			else if(tryLogin.getUserType() == 102){
				forward = "BranchMain?action=dashboard";
				response.sendRedirect(forward);
			}
			else if(tryLogin.getUserType() == 103){
				forward = "ComMain?action=dashboard";
				response.sendRedirect(forward);
			}
		}
		else{
			forward = "index.jsp";
			String message = "Username or Password is incorrect";
			request.setAttribute("message", message);
			RequestDispatcher dispatcher = request.getRequestDispatcher(forward);
			dispatcher.forward(request, response);
		}
	}

}
