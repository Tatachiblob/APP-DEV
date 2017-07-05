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
</div><!-- /#page-wrapper -->
</div><!-- /#wrapper -->
</body>
</html>