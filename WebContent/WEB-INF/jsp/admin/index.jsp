<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="model.User" %>
<%
User loginUser = (User) session.getAttribute("loginUser");
%>
<!DOCTYPE>
<html lang="en">
<head>
<title>Admin Page</title>
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
<nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0; background-color: #003d66;">
	<div class="navbar-header">
		<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
			<span class="sr-only">Toggle navigation</span>
			<span class="icon-bar"></span>
			<span class="icon-bar"></span>
			<span class="icon-bar"></span>
		</button>
		<a style ="color:white;"class="navbar-brand" href="AdminMain?action=dashboard">Komoro Inventory System</a>
	</div><!-- /.navbar-header -->
	<ul class="nav navbar-top-links navbar-right">

	<li class="dropdown">
		<a class="dropdown-toggle" data-toggle="dropdown" href="#">
			<i style = "color: #ffa31a;" class="fa fa-user fa-fw"></i> <i style = "color: white;"class="fa fa-caret-down"></i>
		</a>
		<ul class="dropdown-menu dropdown-user">
			<li><a href="#"><i class="fa fa-user fa-fw"></i> User Profile</a></li>
			<li><a href="#"><i class="fa fa-gear fa-fw"></i> Settings</a></li>
			<li class="divider"></li>
			<li><a href="Logout"><i class="fa fa-sign-out fa-fw"></i> Logout</a></li>
		</ul><!-- /.dropdown-user -->
	</li><!-- /.dropdown -->
	</ul><!-- /.nav navbar-top-links navbar-right -->
	<div class="navbar-default sidebar" role="navigation">
		<div class="sidebar-nav navbar-collapse">
		<ul class="nav" id="side-menu">
			<!--
			<li class="sidebar-search">
				<div class="input-group custom-search-form">
					<input type="text" class="form-control" placeholder="Search...">
					<span class="input-group-btn">
						<button class="btn btn-default" type="button"><i class="fa fa-search"></i></button>
					</span>
				</div><!-- /input-group --
			</li><!--Search Bar-->
			<li><a href="AdminMain?action=dashboard"><i class="fa fa-dashboard fa-fw"></i> Dashboard</a></li>
			<li>
				<a href="#"><i class="fa fa-fw fa-users"></i> Employees<span class="fa arrow"></span></a>
				<ul class="nav nav-second-level">
					<li><a href="#"><i style = "color: #ffa31a;" class="fa fa-fw fa-chevron-right"></i>Add Employee</a></li>
					<li><a href="#"><i style = "color: #ffa31a;" class="fa fa-fw fa-chevron-right"></i>Edit Employee</a></li>
					<li><a href="#"><i style = "color: #ffa31a;" class="fa fa-fw fa-chevron-right"></i>View All Employee</a></li>
					<li>
						<a href="#"> Departments<span class="fa arrow"></span></a>
						<ul class="nav nav-third-level">
							<li><a href="#"><i style = "color: #ffa31a;" class="fa fa-fw fa-chevron-right"></i>Add Department</a></li>
							<li><a href="#"><i style = "color: #ffa31a;" class="fa fa-fw fa-chevron-right"></i>Employee Assignment</a></li>
							<li><a href="#"><i style = "color: #ffa31a;" class="fa fa-fw fa-chevron-right"></i>View Departments</a></li>
						</ul>
					</li>
				</ul>
			</li><!-- Employee Drop Down -->
			<li>
				<a href="#"><i class="fa fa-fw fa-table"></i> Inventory<span class="fa arrow"></span></a>
				<ul class="nav nav-second-level">
					<li><a href="#"><i style = "color: #ffa31a;" class="fa fa-fw fa-chevron-right"></i> Add Inventory</a>
				</ul>
			</li><!-- Inventory Drop Down -->
			<li>
			</li><!-- Reports Drop Down -->
		</ul>
		</div><!-- /.sidebar-nav navbar-collapse -->
	</div><!-- /.navbar-default sidebar -->
</nav><!-- /.navbar -->
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
			<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button><i class="fa fa-info-circle"></i>  <strong>Hello, <%= loginUser.getFirstName() + " " + loginUser.getLastName() %>.</strong> Logged In as Administrator
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
						<div style="font-size:30px;">Users/Departments</div>
					</div>
				</div>
			</div>
			<a href="AdminMain?action=employees">
				<div class="panel-footer">
					<span class="pull-left">View Details</span>
					<span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
					<div class="clearfix"></div>
				</div>
			</a>
		</div>
	</div><!-- Users/Departments Panel -->
	<div class="col-lg-3 col-md-6">
		<div class="panel panel-green">
			<div class="panel-heading">
				<div class="row">
					<div class="col-xs-3">
						<i class="fa fa-table fa-5x"></i>
					</div>
					<div class="col-xs-9 text-right">
						<div style="font-size:30px;">Inventory</div>
					</div>
				</div>
			</div>
			<a href="AdminMain?action=inventory">
				<div class="panel-footer">
					<span class="pull-left">View Details</span>
					<span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
					<div class="clearfix"></div>
				</div>
			</a>
		</div>
	</div><!-- Inventory Panel -->
	<div class="col-lg-3 col-md-6">
		<div class="panel panel-yellow">
			<div class="panel-heading">
				<div class="row">
					<div class="col-xs-3">
						<i class="fa fa-paperclip fa-5x"></i>
					</div>
					<div class="col-xs-9 text-right">
						<div style="font-size:30px;">Reports</div>
					</div>
				</div>
			</div>
			<a href="AdminMain?action=reports">
				<div class="panel-footer">
					<span class="pull-left">View Details</span>
					<span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
					<div class="clearfix"></div>
				</div>
			</a>
		</div>
	</div><!-- Inventory Panel -->
</div><!-- /.row -->
</div><!-- /#page-wrapper -->
</div><!-- /#wrapper -->
</body>
</html>