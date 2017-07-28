<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="model.User, model.Branch, model.Stock, model.Inventory" %>
<%@page import="dao.DepartmentDAO, dao.CustomDAO" %>
<%@page import="java.util.ArrayList" %>
<%
User loginUser = (User) session.getAttribute("loginUser");
Branch myBr = DepartmentDAO.getBranchByUserId(loginUser.getEmpId());
ArrayList<Inventory> myInventory = CustomDAO.getCurrentBrInventory(myBr.getBranchId());
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Branch - View Stock Availability</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<%@ include file="../../../styleinclude.jsp" %>
</head>
<body>
<div id="wrapper">
<%@include file="branchInclude.jsp" %>
<div id="page-wrapper">
<div class="row">
	<div class="col-lg-12">
		<h1>Stock Availability</h1>
	</div><!-- /.col-lg-12 -->
</div><!-- /.row -->
<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading"><%=myBr.getBranchName() %> Inventory</div>
			<div class="panel-body">
				<table width="100%" class="table table-striped table-bordered table-hover" id="comInventory">
					<thead>
						<tr>
							<th>Stock Name</th>
							<th>Floor Level</th>
							<th>Ceiling Level</th>
							<th>Stock Keeping Unit</th>
							<th>Current Quantity</th>
							<th><strong>Product Status</strong></th>
						</tr>
					</thead>
					<tbody>
						<%for(Inventory i : myInventory){ %>
						<tr>
							<td><%=i.getStock().getName() %></td>
							<td><%=i.getStock().getFloorLvl() %></td>
							<td><%=i.getStock().getCeilLvl() %></td>
							<td><%=i.getStock().getUnit() %></td>
							<td><strong><%=i.getQuantity() %></strong></td>
							<%if(i.getStatus().equals("Out of Stock")){ %>
							<td bgcolor="red"><strong>Out of Stock</strong></td>
							<%}else if(i.getStatus().equals("Low In Stock")){ %>
							<td bgcolor="yellow"><strong>Low In Stock</strong></td>
							<%}else if(i.getStatus().equals("In Stock")) {%>
							<td bgcolor="lightgreen"><strong>In Stock</strong></td>
							<%}else if(i.getStatus().equals("Over Stock")){ %>
							<td bgcolor="info"><strong>Over Stock</strong></td>
							<%} %>
						</tr>
						<%} %>
					</tbody>
				</table>
			</div><!-- /.panel-body -->
			<div class="panel-footer">
				--- End of Branch Inventory Report ---
			</div><!-- /.panel-footer -->
		</div><!-- /.panel panel-default -->
	</div><!-- /.col-lg-12 -->
</div><!-- /.row -->
</div><!-- /#page-wrapper -->
</div><!-- /#wrapper -->
</body>
</html>