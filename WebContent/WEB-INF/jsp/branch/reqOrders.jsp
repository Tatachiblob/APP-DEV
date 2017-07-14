<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="model.User, model.Branch, model.Stock, model.Inventory" %>
<%@ page import="dao.DepartmentDAO, dao.StockDAO" %>
<%@ page import="java.text.SimpleDateFormat, java.util.Date,  java.util.ArrayList" %>
<%
User loginUser = (User)session.getAttribute("loginUser");
Date date = new Date();
SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
String today = sdf.format(date);
Branch br = DepartmentDAO.getBranchByUserId(loginUser.getEmpId());
ArrayList<Inventory> inventory = StockDAO.getBranchInventory(br.getBranchId());
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Branch - Requisition Order</title>
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
		<h1 class="page-header">Requisition Order (<%=today%>)</h1>
	</div><!-- /.col-lg-12 -->
</div><!-- /.row -->
<div class="row">
	<div class="panel panel-default">
		<div class="panel-heading"><%=br.getBranchName()%>'s Ending Inventory</div>
		<div class="panel-body">
			<div class="col-lg-6">
				<table width="100%" class="table table-striped table-bordered table-hover" id="reqOrderTable">
					<thead>
						<th>Stock Name</th>
						<th>System Quantity</th>
						<th>Stock Unit</th>
						<th>Ending Inventory</th>
					</thead>
					<tbody>
					<%for(Inventory i : inventory){ %>
					<tr>
						<td><%=i.getStock().getName() %></td>
						<td><%=i.getQuantity() %></td>
						<td><%=i.getStock().getUnit() %></td>
						<td>ASD</td>
					</tr>
					<%} %>
					</tbody>
				</table>
			</div><!-- /.col-lg-6 -->
		</div><!-- /.panel-body -->
	</div><!-- /.panel panel-default -->
</div><!-- /.row -->
</div><!-- /#page-wrapper -->
</div><!-- /#wrapper -->
</body>
<script type="text/javascript">
$(document).ready(function(){
	$('#reqOrderTable').DataTable({
		responsive: true
	});
});
</script>
</html>