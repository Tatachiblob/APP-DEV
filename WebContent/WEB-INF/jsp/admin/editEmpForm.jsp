<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="model.User, model.Commissary, model.Branch, java.util.ArrayList, dao.DepartmentDAO" %>
<%
User loginUser = (User) session.getAttribute("loginUser");
User editUser = (User) request.getAttribute("editableUser");
ArrayList<Commissary> coms = DepartmentDAO.getAllCommissary();
ArrayList<Branch> branches = DepartmentDAO.getAllBranch();
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Admin Page - Edit Employee(Form)</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 <meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<%@ include file="../../../styleinclude.jsp" %>
</head>
<body>
<div id="wrapper">
<%@ include file="adminInclude.jsp" %>
<div id="page-wrapper">
<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">Edit Employee</h1>
	</div><!-- /.col-lg-12 -->
</div><!-- /.row -->
<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">Edit Employee Entry</div>
			<div class="panel-body">
				<div class="row">
					<div class="col-lg-6">
						<form action="EditEmp" method="post">
							<div class="form-group">
								<label>Username</label>
								<input type="hidden" name="empId" value="<%=editUser.getEmpId()%>">
								<input type="hidden" name="originalUserType" value="<%=editUser.getUserType()%>">
								<input type="text" name="username" class="form-control" placeholder="<%=editUser.getUserName() %>" value="<%=editUser.getUserName()%>" readonly>
							</div>
							<div class="form-group">
								<label>New Password</label>
								<input type="password" name="password" class="form-control" placeholder="new password" required>
							</div>
							<div class="form-group">
								<label>First Name</label>
								<input type="text" name="firstName" class="form-control" placeholder="<%=editUser.getFirstName() %>" value="<%=editUser.getFirstName()%>" readonly>
							</div>
							<div class="form-group">
								<label>Last Name</label>
								<input type="text" name="lastName" class="form-control" placeholder="<%=editUser.getLastName() %>" value="<%=editUser.getLastName()%>" readonly>
							</div>
							<div class="form-group">
								<lable>User Type</lable>
								<div class="radio">
									<label><input id="101" type="radio" name="userType" value="101" <%if(editUser.getUserType() == 101){%>checked<%} %>  required>Admin</label>
								</div>
								<div class="radio">
									<label><input id="102" type="radio" name="userType" value="102" <%if(editUser.getUserType() == 102){%>checked<%} %> required>Branch Manager</label>
								</div>
								<div class="radio">
									<label><input id="103" type="radio" name="userType" value="103" <%if(editUser.getUserType() == 103){%>checked<%} %> required>Commissary Clerk</label>
								</div>
							</div>
							<div class="form-group">
								<fieldset id="kom">
									<label>Commissary Assignment</label>
									<select class="form-control" name="assignCom" required>
										<option value="">Please Select One</option>
										<% for(Commissary c : coms){ %>
										<option value="<%=c.getComId()%>"><%= c.getComName() %></option>
										<% } %>
									</select>
								</fieldset>
							</div>
							<div class="form-group">
								<fieldset id="br">
								<label>Branch Assignment</label>
								<select class="form-control" name="assignBr" required>
									<option value="">Please Select One</option>
									<% for(Branch b : branches){ %>
									<option value="<%=b.getBranchId()%>"><%= b.getBranchName() %></option>
									<% } %>
								</select>
							</fieldset>
							</div>
							<input type="submit" class="btn btn-primary" value="Submit">
							<input type="reset" class="btn btn-warning" value="Reset">
						</form>
					</div><!-- /.col-lg-6 -->
				</div><!-- /.row -->
			</div><!-- /.panel-body -->
		</div><!--/.panel panel-default -->
	</div><!-- /.col-lg-12 -->
</div><!-- /.row -->
</div><!-- /#page-wrapper -->
</div><!-- /#wrapper -->
</body>
<script type="text/javascript">
$(document).ready(function(){
	function checkradiobox(){
		var radio = $("input[name='userType']:checked").val();
		$('#kom').attr('disabled', true);
		$('#br').attr('disabled', true);
		if(radio == '101' || radio == '103'){
			$('#kom').attr('disabled', false);
			$('#br').attr('disabled', true);
		}
		if(radio == '102'){
			$('#kom').attr('disabled', true);
			$('#br').attr('disabled', false);
		}
		$("#101, #102, #103").change(function(){
			checkradiobox();
		});
	}
	checkradiobox();
});
</script>
</html>