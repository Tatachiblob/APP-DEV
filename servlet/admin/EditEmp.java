package servlet.admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.DepartmentDAO;
import dao.EmployeeDAO;
import model.User;

@WebServlet("/EditEmp")
public class EditEmp extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public EditEmp() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		if(session.getAttribute("loginUser") == null){
			request.setAttribute("message", "Redirected Back to Login Page");
			request.getRequestDispatcher("Login?action=Login");
		}
		else{
			String emp = request.getParameter("emp");
			User editableUser = null;
			for(User u : EmployeeDAO.getEmps()){
				if(EmployeeDAO.passFunction(Integer.toString(u.getEmpId())).equals(emp)){
					editableUser = u;
				}
			}
			request.setAttribute("editableUser", editableUser);
			request.getRequestDispatcher("WEB-INF/jsp/admin/editEmpForm.jsp").forward(request, response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		if(session.getAttribute("loginUser") == null){
			request.setAttribute("message", "Redirected Back to Login Page");
			request.getRequestDispatcher("Login?action=Login").forward(request, response);;
		}
		else{
			String msg = "";
			int empId = Integer.parseInt(request.getParameter("empId"));
			int originalUserType = Integer.parseInt(request.getParameter("originalUserType"));
			String username = request.getParameter("username");
			String password = request.getParameter("password");
			String firstName = request.getParameter("firstName");
			String lastName = request.getParameter("lastName");
			int userType = Integer.parseInt(request.getParameter("userType"));
			User editUser = new User(empId, username, password, firstName, lastName, userType);
			EmployeeDAO.setEmployed(empId);
			if(originalUserType == 101 || originalUserType == 103){
				DepartmentDAO.updateEmpComToDate(empId);
			}
			else if(originalUserType == 102){
				DepartmentDAO.updateEmpBrToDate(empId);
			}
			if(userType == 101){
				int comId = Integer.parseInt(request.getParameter("assignCom"));
				if(EmployeeDAO.addNewUser(editUser, comId)){
					int newEmpId = EmployeeDAO.getEmpID(username);
					if(EmployeeDAO.assignEmployeeCom(comId, newEmpId)){
						msg = "Success : Employee Account Edited";
					}
				}
			}
			else if(userType == 102){
				int brId = Integer.parseInt(request.getParameter("assignBr"));
				if(EmployeeDAO.addNewUser(editUser, brId)){
					int newEmpId = EmployeeDAO.getEmpID(username);
					if(EmployeeDAO.assignEmplyeeBranch(brId, newEmpId)){
						msg = "Success : Employee Account Edited";
					}
				}
			}
			else if(userType == 103){
				int comId = Integer.parseInt(request.getParameter("assignCom"));
				if(EmployeeDAO.addNewUser(editUser, comId)){
					int newEmpId = EmployeeDAO.getEmpID(username);
					if(EmployeeDAO.assignEmployeeCom(comId, newEmpId)){
						msg = "Success : Employee Account Edited";
					}
				}
			}
			else{
				msg = "Fail : Unknown Error";
			}
			request.setAttribute("msg", msg);
			request.getRequestDispatcher("WEB-INF/jsp/admin/editEmpView.jsp").forward(request, response);
		}
	}

}
