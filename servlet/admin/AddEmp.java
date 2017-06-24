package servlet.admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.EmployeeDAO;
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
			if(EmployeeDAO.addNewUser(newUser, comId)){
				int empId = EmployeeDAO.getEmpID(username);
				if(EmployeeDAO.assignEmployeeCom(comId, empId)){
					msg = "Success : New Admin Added";
				}
				else{
					msg = "Fail : Employee cannot be added";
				}
			}
			else{
				msg = "Fail : Employee cannot be added";
			}
		}
		else if(userType == 102){
			int brId = Integer.parseInt(request.getParameter("assignBr"));
			newUser = new User(username, password, firstName, lastName, 102);
			if(EmployeeDAO.addNewUser(newUser, brId)){
				int empId = EmployeeDAO.getEmpID(username);
				if(EmployeeDAO.assignEmplyeeBranch(brId, empId)){
					msg = "Success : New Branch Manager Added";
				}
				else{
					msg = "Fail : Employee cannot be added";
				}
			}
			else{
				msg = "Fail : Employee cannot be added";
			}
		}
		else if(userType == 103){
			int comId = Integer.parseInt(request.getParameter("assignCom"));
			newUser = new User(username, password, firstName, lastName, 103);
			if(EmployeeDAO.addNewUser(newUser, comId)){
				int empId = EmployeeDAO.getEmpID(username);
				if(EmployeeDAO.assignEmployeeCom(comId, empId)){
					msg = "Success : New Commissary Clerk Added";
				}
				else{
					msg = "Fail : Employee cannot be added";
				}
			}
			else{
				msg = "Fail : Employee Cannot be added";
			}
		}
		else{
			msg = "Fail : Unknown error";
		}
		request.setAttribute("msg", msg);
		request.getRequestDispatcher("WEB-INF/jsp/admin/addEmp.jsp").forward(request, response);
	}

}
