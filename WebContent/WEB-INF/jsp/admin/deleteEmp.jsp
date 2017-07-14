<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="model.User" %>
<%
User loginUser = (User) session.getAttribute("loginUser");
User editUser = (User) request.getAttribute("editableUser");
String fullName = editUser.getFirstName() + ", " + editUser.getLastName();
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Admin - Delete Employee</title>
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
		<h1 class="page-header">Delete Employee</h1>
	</div><!-- /.col-lg-12 -->
</div><!-- /.row -->
<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">Delete Employee Entry</div>
			<div class="panel-body">
				<div class="row">
					<div class="col-lg-6">
						<form action="Delete" method="post">
							<input type="hidden" name="empId" value="<%=editUser.getEmpId()%>">
							<input type="hidden" name="empType" value="<%=editUser.getUserType() %>">
							<fieldset disabled>
								<div class="form-group">
									<label>Employee Name</label>
									<input class="form-control" type="text" placeholder="<%=fullName%>" disabled>
								</div>
							</fieldset>
							<input type="submit" class="btn btn-danger" value="Delete">
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
</html>