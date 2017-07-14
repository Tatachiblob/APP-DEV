<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="model.User" %>
<%
User loginUser = (User) session.getAttribute("loginUser");
%>
<!DOCTYPE html>
<%if(!loginUser.getIsEmployed()){ %>
<%
String msg = "This accout is no longer available";
request.setAttribute("msg", msg);
%>
<jsp:forward page="error.jsp"></jsp:forward>
<%}if(!loginUser.getIsActive()){ %>
<jsp:forward page="../activateAccount.jsp"></jsp:forward>
<%} %>
<html>
<head>
<title>Branch Page</title>
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
<%@ include file="branchInclude.jsp" %>
<div id="page-wrapper">
<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">Dashboard</h1>
		<ol style="background-color:#ffebcc;"class="breadcrumb">
			<li class="active"><i class="fa fa-dashboard"></i> Dashboard</li>
		</ol>
	</div>
</div><!-- /.row -->
<div class="row">
	<div class="col-lg-12">
		<div class="alert alert-info alert-dismissable">
			<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button><i class="fa fa-info-circle"></i>  <strong>Hello, <%= loginUser.getFirstName() + " " + loginUser.getLastName() %>.</strong> Logged In as Branch Manager
		</div>
	</div>
</div><!-- /.row -->
<div class="row">
	<div class="col-lg-12">
		<div class="alert alert-info alert-dismissable">
			<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button><i class="fa fa-info-circle"></i>  <strong>Hello, <%= loginUser.getIsActive() + " " + loginUser.getIsEmployed() %>.</strong>
		</div>
	</div>
</div><!-- /.row -->
<div class="row">
	<div class="col-lg-3 col-md-6">
		<div class="panel panel-primary">
			<div class="panel-heading">
				<div class="row">
					<div class="col-xs-3">
						<i class="fa fa-users fa-5x"></i>
					</div>
					<div class="col-xs-9 text-right">
						<div style="font-size:30px;">Requisition Order</div>
					</div>
				</div>
			</div>
			<a href="BranchMain?action=requisition">
			<!--<a href="AdminMain?action=employees">-->
				<div class="panel-footer">
					<span class="pull-left">View Details</span>
					<span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
					<div class="clearfix"></div>
				</div>
			</a>
		</div>
	</div><!-- Users/Departments Panel -->
</div><!-- /.row -->
</div><!-- /#page-wrapper -->
</div><!-- /#wrapper -->
</body>
</html>