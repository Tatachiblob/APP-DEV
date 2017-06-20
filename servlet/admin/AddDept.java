package servlet.admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.DepartmentDAO;
import model.Branch;
import model.Commissary;

@WebServlet("/AddDept")
public class AddDept extends HttpServlet {

	private static final long serialVersionUID = 1L;

    public AddDept() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String deptType = request.getParameter("deptType");
		String deptName = request.getParameter("deptName");
		String deptAddress = request.getParameter("deptAddress");
		String msg = "";
		if(deptType.equals("com")){
			Commissary newCom = new Commissary(deptName, deptAddress);
			if(DepartmentDAO.addNewDepartment(newCom)){
				msg = "Commissary:success";
			}
			else{
				msg = "Commissary:error";
			}
		}
		else if(deptType.equals("branch")){
			int comId = Integer.parseInt(request.getParameter("assignCom"));
			Branch newBr = new Branch(deptName, deptAddress);
			newBr.setComId(comId);
			if(DepartmentDAO.addNewDepartment(newBr)){
				msg = "Branch:success";
			}
			else{
				msg = "Branch:error";
			}
		}
		else{
			msg = "Unknown:error";
		}
		request.setAttribute("msg", msg);
		request.getRequestDispatcher("WEB-INF/jsp/admin/addDept.jsp").forward(request, response);
	}

}
