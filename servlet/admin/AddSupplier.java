package servlet.admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.ContactPerson;
import model.Supplier;

@WebServlet("/AddSupplier")
public class AddSupplier extends HttpServlet {

	private static final long serialVersionUID = 1L;

    public AddSupplier() {
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
			String supplierName = request.getParameter("supplierName");
			String companyContact = request.getParameter("companyContact");
			String contactPerson = request.getParameter("contactPerson");
			String contactInfo = request.getParameter("contactInfo");
			Supplier newSupplier = new Supplier(supplierName, companyContact);
			ContactPerson newContact = new ContactPerson();
			newContact.setContactName(contactPerson);
			newContact.setContactInfo(contactInfo);


		}
	}

}
