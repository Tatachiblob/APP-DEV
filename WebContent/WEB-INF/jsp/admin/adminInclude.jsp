<%@page import="model.User"%>
<%
    User test = (User) session.getAttribute("loginUser");
%>
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
        <li style="color:white;"> <%= test.getFirstName() + " " + test.getLastName() %> </li>
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
					<li><a href="AdminMain?action=addEmp"><i style = "color: #ffa31a;" class="fa fa-fw fa-chevron-right"></i>Add Employee</a></li>
					<li><a href="AdminMain?action=editEmp"><i style = "color: #ffa31a;" class="fa fa-fw fa-chevron-right"></i>Edit Employee</a></li>
					<li><a href="#"><i style = "color: #ffa31a;" class="fa fa-fw fa-chevron-right"></i>View All Employee</a></li>
					<li>
						<a href="#"> Departments<span class="fa arrow"></span></a>
						<ul class="nav nav-third-level">
							<li><a href="AdminMain?action=addDept"><i style = "color: #ffa31a;" class="fa fa-fw fa-chevron-right"></i>Add Department</a></li>
							<li><a href="AdminMain?action=viewDept"><i style = "color: #ffa31a;" class="fa fa-fw fa-chevron-right"></i>View Departments</a></li>
						</ul>
					</li>
				</ul>
			</li><!-- Employee Drop Down -->
			<li>
				<a href="#"><i class="fa fa-fw fa-table"></i> Inventory Management<span class="fa arrow"></span></a>
				<ul class="nav nav-second-level">
					<li><a href="AdminMain?action=newInventory"><i style = "color: #ffa31a;" class="fa fa-fw fa-chevron-right"></i> Add Inventory</a>
					<li><a href="AdminMain?action=newSupplier"><i style = "color: #ffa31a;" class="fa fa-fw fa-chevron-right"></i> Add Supplier</a>
					<li><a href="AdminMain?action=reqOrders"><i style = "color: #ffa31a;" class="fa fa-fw fa-chevron-right"></i>View Recent Requisition</a></li>
					<li><a href="AdminMain?action=receiveStock"><i style = "color: #ffa31a;" class="fa fa-fw fa-chevron-right"></i>Receive Stocks</a></li>
                                        <li><a href="AdminMain?action=viewStockAvailability"><i style = "color: #ffa31a;" class="fa fa-fw fa-chevron-right"></i>View Stock Availability</a></li>
				</ul>
			</li><!-- Inventory Drop Down -->
			<li>
                                <a href="#"><i class="glyphicon glyphicon-stats"></i> Reports<span class="fa arrow"></span></a>
				<ul class="nav nav-second-level">
                                    <li><a href="ComMain?action=endingInventory"><i style = "color: #ffa31a;" class="fa fa-fw fa-chevron-right"></i> Ending Inventory Count</a>
				</ul>
			</li><!-- Reports Drop Down -->
		</ul>
		</div><!-- /.sidebar-nav navbar-collapse -->
	</div><!-- /.navbar-default sidebar -->
</nav><!-- /.navbar -->