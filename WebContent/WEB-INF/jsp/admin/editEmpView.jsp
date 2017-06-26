<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList, model.User, dao.EmployeeDAO" %>
<%
ArrayList<User> employees = EmployeeDAO.getEmps();
User loginUser = (User) session.getAttribute("loginUser");
String msg = (String) request.getAttribute("msg");
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Admin Page - Edit Employee(View)</title>
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
		<h1>Edit Employees(View)</h1>
	</div><!-- /.col-lg-12 -->
</div><!-- /.row -->
<% if(msg != null){ %>
<div class="row">
	<div class="col-lg-12">
		<div class="alert alert-info alert-dismissable">
			<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button><i class="fa fa-info-circle"></i>  <strong><%= msg %></strong>
		</div>
	</div>
</div><!-- /.row -->
<% } %>
<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">All Employed Users</div>
			<div class="panel-body">
				<table width="100%" class="table table-striped table-bordered table-hover" id="empTable">
					<thead>
						<tr>
							<th>Username</th>
							<th>Full Name</th>
							<th>User Type</th>
							<th>Edit Employee</th>
						</tr>
					</thead>
					<tbody>
						<%for(User u : employees){ %>
						<%if(u.getIsEmployed() && loginUser.getEmpId() != u.getEmpId()){ %>
						<tr>
							<td><%=u.getUserName() %></td>
							<td><%=u.getLastName() + " " + u.getFirstName() %></td>
							<%if(u.getUserType() == 101){ %>
							<td>Administrator</td>
							<%}else if(u.getUserType() == 102){ %>
							<td>Branch Manager</td>
							<%}else if(u.getUserType() == 103){ %>
							<td>Commissary Clerk</td>
							<%} %>
							<td align="center"><a href="EditEmp?emp=<%=EmployeeDAO.passFunction(Integer.toString(u.getEmpId()))%>"><i class="fa fa-edit"></i></a></td>
						</tr>
						<%} %>
						<%} %>
					</tbody>
				</table><!-- /#empTable -->
			</div><!-- /.panel-body -->
		</div><!-- /.panel panel-default -->
	</div><!-- /.col-lg-12 -->
</div><!-- /.row -->
</div><!-- /#page-wrapper -->
</div><!-- /#wrapper -->
</body>
<script type="text/javascript">
$(document).ready(function(){
	$('#empTable').DataTable({
		responsive : true
	});
});
</script>
</html>