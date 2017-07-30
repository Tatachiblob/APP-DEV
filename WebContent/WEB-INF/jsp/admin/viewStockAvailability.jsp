<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="model.User, model.Commissary, model.Inventory, model.Branch" %>
<%@page import="dao.DepartmentDAO, dao.CustomDAO" %>
<%@page import="java.util.ArrayList" %>
<%
User loginUser = (User) session.getAttribute("loginUser");
Commissary com = DepartmentDAO.getComByUserId(loginUser.getEmpId());
ArrayList<Inventory> comInventory = CustomDAO.getCurrentComInventory(com.getComId());
ArrayList<Branch> allBranch = DepartmentDAO.getAllBranchOfCom(com.getComId());
Branch br = (Branch) request.getAttribute("curBranch");
ArrayList<Inventory> brInventory = (ArrayList<Inventory>) request.getAttribute("brInventory");
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Admin - View Stock Availability</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<%@ include file="../../../styleinclude.jsp" %>
</head>
<body>
<div id="wrapper">
<%@include file="adminInclude.jsp" %>
<div id="page-wrapper">
<div class="row">
	<div class="col-lg-12">
		<h1>Stock Availability</h1>
	</div><!-- /.col-lg-12 -->
</div><!-- /.row -->
<div class="row">
	<div class="col-lg-12">
		<div class="alert alert-info">Click Button to See the Stock Flow</div>
	</div><!-- /.col-lg-12 -->
</div><!-- /.row -->
<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading"><%=com.getComName()%> Inventory</div>
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
							<th>View Stock Audit</th>
						</tr>
					</thead>
					<tbody>
					<%for(Inventory i : comInventory){ %>
						<tr>
							<td><%=i.getStock().getName()%></td>
							<td><%=i.getStock().getFloorLvl()%></td>
							<td><%=i.getStock().getCeilLvl()%></td>
							<td><%=i.getStock().getUnit()%></td>
							<td><strong><%=i.getQuantity() + "" + i.getStock().getUnit()%></strong></td>
							<%if(i.getStatus().equals("Out of Stock")){ %>
							<td bgcolor="red"><strong>Out of Stock</strong></td>
							<%}else if(i.getStatus().equals("Low In Stock")){ %>
							<td bgcolor="yellow"><strong>Low In Stock</strong></td>
							<%}else if(i.getStatus().equals("In Stock")) {%>
							<td bgcolor="lightgreen"><strong>In Stock</strong></td>
							<%}else if(i.getStatus().equals("Over Stock")){ %>
							<td bgcolor="info"><strong>Over Stock</strong></td>
							<%} %>
							<td align="center"><a href="ViewAudit?comID=<%=com.getComId()%>&stockID=<%=i.getStock().getStockId() %>" class="btn btn-info"><i class="fa fa-fw fa-level-up"></i></a></td>
						</tr>
					<%} %>
					</tbody>
				</table>
			</div><!-- /.panel-body -->
			<div class="panel-footer">
				---End of Commissary Report---
			</div><!-- /.panel-footer -->
		</div><!-- /.panel panel-default -->
	</div><!-- /.col-lg-12 -->
</div><!-- /.row -->
<div class="row">
	<div class="col-lg-4">
		<h4>Set Branch: </h4>
		<form action="ViewStockAvailability" method="post">
			<select id="chosenBranch" name="chosenBranch" onchange="this.form.submit()" class="form-control">
				<option selected disabled>Choose Branch</option>
				<%for(Branch b : allBranch){ %>
				<option value="<%=b.getBranchId()%>"><%=b.getBranchName() %>
				<%} %>
			</select>
		</form>
	</div><!-- /.col-lg-4 -->
</div><!-- /.row -->
<%if(br != null){ %>
<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading"><%=br.getBranchName() %></div>
			<div class="panel-body">
				<table width="100%" class="table table-striped table-bordered table-hover" id="brInventory">
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
						<%for(Inventory i : brInventory){ %>
						<tr>
							<td><%=i.getStock().getName() %></td>
							<td align="right"><%=i.getStock().getFloorLvl() %></td>
							<td align="right"><%=i.getStock().getCeilLvl() %></td>
							<td><%=i.getStock().getUnit() %></td>
							<td align="right"><strong><%=i.getQuantity() + i.getStock().getUnit() %></strong></td>
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
				---End of Branch Report---
			</div><!-- /.panel-footer -->
		</div><!-- /.panel panel-default -->
	</div><!-- /.col-lg-12 -->
</div><!-- /.row -->
<%} %>
</div><!-- /#page-wrapper -->
</div><!-- /#wrapper -->
</body>
<script type="text/javascript">
$(document).ready(function(){
	$('#comInventory').DataTable({
		responsive: true
	});
});
</script>
</html>