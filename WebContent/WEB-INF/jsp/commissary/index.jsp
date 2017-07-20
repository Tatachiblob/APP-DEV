<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList, model.Stock,model.User,dao.StockDAO" %>
<%
User loginUser = (User) session.getAttribute("loginUser");
ArrayList<Stock> allStock = StockDAO.getStocks(loginUser.getEmpId());
ArrayList<Stock> addedStocks = new ArrayList<Stock>();
session.setAttribute("ALaddedStocks", addedStocks);
System.out.println("ISJAKE: " + session.getAttribute("JAKEZYRUS"));
session.setAttribute("addItemTrigger", "0");
session.setAttribute("receivesupplier",null);
%>
<!DOCTYPE>
<%if(!loginUser.getIsEmployed()){ %>
<%
String msg = "This accout is no longer available";
request.setAttribute("msg", msg);
%>
<jsp:forward page="error.jsp"></jsp:forward>
<%}if(!loginUser.getIsActive()){%>
<jsp:forward page="../activateAccount.jsp"></jsp:forward>
<%} %>
<html lang="en">
<head>
<title>Commissary Page</title>
 <meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<%@ include file="../../../styleinclude.jsp" %>
</head>
<body>
<div id="wrapper">
<%@ include file="comInclude.jsp" %>
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
			<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button><i class="fa fa-info-circle"></i>  <strong>Hello, <%= loginUser.getFirstName() + " " + loginUser.getLastName() %>.</strong> Logged In as Commissary
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
		<div class="panel panel-red">
			<div class="panel-heading">
				<div class="row">
					<div class="col-xs-3">
						<i class="glyphicon glyphicon-exclamation-sign fa-5x"></i>
					</div>
					<div class="col-xs-9 text-right">
						<div style="font-size:30px;">Sample Text</div>
					</div>
				</div>
			</div>
			<a href="#">
			<!--<a href="AdminMain?action=employees">-->
				<div class="panel-footer">
					<span class="pull-left">View Details</span>
					<span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
					<div class="clearfix"></div>
				</div>
			</a>
		</div>
            
        
            
	</div><!-- Users/Departments Panel -->
        
        
        
	<div class="col-lg-3 col-md-6">
		<div class="panel panel-info">
			<div class="panel-heading">
				<div class="row">
					<div class="col-xs-3">
						<i class="glyphicon glyphicon-exclamation-sign fa-5x fa-5x"></i>
					</div>
					<div class="col-xs-9 text-right">
						<div style="font-size:30px;">Owl City - Fireflies</div>
					</div>
				</div>
			</div>
			<a href="#">
			<!--<a href="AdminMain?action=inventory">-->
				<div class="panel-footer">
					<span class="pull-left">View Details</span>
					<span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
					<div class="clearfix"></div>
				</div>
			</a>
		</div>
	</div><!-- Inventory Panel -->
	<div class="col-lg-3 col-md-6">
		<div class="panel panel-green">
			<div class="panel-heading">
				<div class="row">
					<div class="col-xs-3">
						<i class="glyphicon glyphicon-exclamation-sign fa-5x fa-5x"></i>
					</div>
					<div class="col-xs-9 text-right">
						<div style="font-size:30px;">Despacito</div>
					</div>
				</div>
			</div>
			<a href="#">
			<!--<a href="AdminMain?action=reports">-->
				<div class="panel-footer">
					<span class="pull-left">View Details</span>
					<span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
					<div class="clearfix"></div>
				</div>
			</a>
		</div>
	</div><!-- Inventory Panel -->
</div><!-- /.row -->

<div class="row">
    <div class="panel panel-primary">
                            <div class="panel-heading">
                                <i class="fa fa-bar-chart"></i> Stock Status
                            </div>
                            <!-- /.panel-heading -->
                            <div class="panel-body">
                              <table width="100%" class="table table-striped table-bordered table-hover" id="dataTables-example">
                                  <thead>
                                      <tr>
                                          <th>Stock Name</th>
                                          <th>Current Quantity</th>
                                          <th><strong>Product Status</strong></th>
                                      </tr>
                                  </thead>
                                  <tbody>
                                      <%for(Stock stox : allStock){ %>
                                        <tr>
                                          <td><%= stox.getName() %></td>
                                          <td><%= stox.getQty() %></td>
                                          
                                          <% if(stox.getQty() <= stox.getFloorLvl() && stox.getQty() > 0){%>
                                          <td bgcolor="yellow"><strong>Low in Stock</strong></td>
                                          <% }  
                                          else if(stox.getQty() > stox.getFloorLvl() && stox.getQty() < stox.getCeilLvl()){%>
                                          <td bgcolor="lightgreen"><strong>In Stock</strong></td>
                                          <% }
                                          else if(stox.getQty() == 0){%>
                                          <td bgcolor="red"><strong>Out of stock</strong></td>
                                          <% }
                                          else if(stox.getQty() >= stox.getCeilLvl()){%>
                                          <td bgcolor="info"><strong>Overstock</strong></td>
                                          <% } %>
                                          
                                        </tr>

                                       <%} %>
                                      
                                      
                                  </tbody>
                              </table>
                                <!-- /.list-group -->
                                <a href="#" class="btn btn-default btn-block">View Stock Availability</a>
                            </div>
                            <!-- /.panel-body -->
                        </div>
    
</div>

</div><!-- /#page-wrapper -->
</div><!-- /#wrapper -->
</body>
</html>