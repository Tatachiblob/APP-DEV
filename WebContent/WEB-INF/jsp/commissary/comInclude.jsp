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

			<li><a href="ComMain?action=dashboard"><i class="fa fa-dashboard fa-fw"></i> Dashboard</a></li>

			<li>
				<a href="#"><i class="fa fa-fw fa-table"></i> Inventory Management<span class="fa arrow"></span></a>
				<ul class="nav nav-second-level">
					<li><a href="ComMain?action=receiveStock"><i style = "color: #ffa31a;" class="fa fa-fw fa-chevron-right"></i> Receive Stock</a>
				</ul>
			</li><!-- Inventory Drop Down -->
			<li>
			</li><!-- Reports Drop Down -->
		</ul>
		</div><!-- /.sidebar-nav navbar-collapse -->
	</div><!-- /.navbar-default sidebar -->
</nav><!-- /.navbar -->