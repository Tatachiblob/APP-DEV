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

/**
 * Servlet implementation class DeleteEmp
 */
@WebServlet("/Delete")
public class DeleteEmp extends HttpServlet {

	private static final long serialVersionUID = 1L;

    public DeleteEmp() {
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
			int editUserId = Integer.parseInt(request.getParameter("empId"));
			int userType = Integer.parseInt(request.getParameter("empType"));
			if(userType == 101 || userType == 103){
				//System.out.println("Admin or Commissary");
				DepartmentDAO.updateEmpComToDate(editUserId);
			}
			else if(userType == 102){
				//System.out.println("Branch Manager");
				DepartmentDAO.updateEmpBrToDate(editUserId);
			}
			String msg = "";
			if(EmployeeDAO.deleteEmployee(editUserId)){
				msg = "Success in deleting the selected employee.";
			}
			else{
				msg = "Failed to delete the selected employee.";
			}
			request.setAttribute("msg", msg);
			request.getRequestDispatcher("WEB-INF/jsp/admin/editEmpView.jsp").forward(request, response);
		}
	}

}
