package servlet.admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.DepartmentDAO;
import model.Commissary;

/**
 * Servlet implementation class ViewDept
 */
@WebServlet("/ViewDept")
public class ViewDept extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public ViewDept() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		if(session.getAttribute("loginUser") == null){
			request.setAttribute("message", "Redirected Back to Login Page");
			request.getRequestDispatcher("Login?action=Login");
		}
		else{
			String deptId = request.getParameter("deptId");
			String deptType = request.getParameter("deptType");
			if(deptType.equals("com")){
				Commissary com = DepartmentDAO.getComById(deptId);
				request.setAttribute("com", com);
				request.getRequestDispatcher("WEB-INF/jsp/admin/viewCommissary.jsp").forward(request, response);
			}
			if(deptType.equals("br")){

			}
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}

}
