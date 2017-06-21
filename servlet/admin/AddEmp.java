package servlet.admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.User;

@WebServlet("/AddEmp")
public class AddEmp extends HttpServlet {

	private static final long serialVersionUID = 1L;

    public AddEmp() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String firstName = request.getParameter("firstName");
		String lastName = request.getParameter("lastName");
		int userType = Integer.parseInt(request.getParameter("userType"));
		String msg = "";
		User newUser = null;
		if(userType == 101){
			int comId = Integer.parseInt(request.getParameter("assignCom"));
			newUser = new User(username, password, firstName, lastName, 101);

		}
		if(userType == 102){
			int brId = Integer.parseInt(request.getParameter("assignBr"));
			newUser = new User(username, password, firstName, lastName, 102);
		}
		if(userType == 103){
			int comId = Integer.parseInt(request.getParameter("assignCom"));
			newUser = new User(username, password, firstName, lastName, 103);
		}
		else{
			msg = "Fail : Unknown error";
		}
		/*
		System.out.println("Username: " + username);
		System.out.println("Password:" + password);
		System.out.println("First Name: " + firstName);
		System.out.println("Last Name: " + lastName);
		System.out.println("User Type: " + userType);
		*/
	}

}
