<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="model.User" %>
<%
User loginUser = (User) session.getAttribute("loginUser");
%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Admin - Suppliers</title>
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
		<h1 class="page-header">Add New Supplier Information</h1>
	</div><!-- /.col-lg-12 -->
</div><!-- /.row -->
<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">New Supplier Entry</div>
			<div class="panel-body">
				<form action="AddSupplier" method="post">
					<div class="form-group">
						<label>Supplier Name</label>
						<input type="text" name="supplierName" class="form-control" placeholder="supplier name" required autofocus>
					</div>
					<div class="form-group">
						<label>Company Contact Information</label>
						<input type="text" name="companyContact" class="form-control" placeholder="company contat" required>
					</div>
					<div class="form-group">
						<label>Contact Person Name</label>
						<input type="text" name="contactPerson" class="form-control" placeholder="contact person name" required>
					</div>
					<div class="form-group">
						<label>Contact Information</label>
						<input type="text" name="contactInfo" class="form-control" placeholder="e-mail, cellphone num, etc" required>
					</div>
					<input type="submit" class="btn btn-primary" value="Submit">
					<input type="reset" class="btn btn-warning" value="Reset">
				</form>
			</div><!-- /.panel-body -->
		</div><!-- /.panel panel-default -->
	</div><!-- /.col-lg-12 -->
</div><!-- /.row -->
</div><!-- /#page-wrapper -->
</div><!-- /#wrapper -->
</body>
</html>