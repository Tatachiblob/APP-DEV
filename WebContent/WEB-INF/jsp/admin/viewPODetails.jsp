<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="model.User, model.PurchaseOrder, model.Commissary, model.Inventory" %>
<%@page import="dao.DepartmentDAO" %>
<%
User loginUser = (User) session.getAttribute("loginUser");
Commissary com = DepartmentDAO.getComByUserId(loginUser.getEmpId());
PurchaseOrder poDetails = (PurchaseOrder) request.getAttribute("purchaseOrder");
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Admin - Purchase Order Detail</title>
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
		<h1>Purchase Order Details</h1>
	</div><!-- /.col-lg-12 -->
</div><!-- /.row -->
<div class="row">
	<div class="col-lg-5">
		<div class="panel panel-info">
			<div class="panel-heading"><%=com.getComName()%> Purchase Order(<%=poDetails.getSupplier().getSupplierName()%>)</div>
			<div class="panel-body">
				<table width="100%" class="table table-striped table-bordered table-hover" id="purchaseOrder">
					<thead>
						<tr>
							<th>Stock</th>
							<th>Requested Quantity</th>
							<th>Unit</th>
						</tr>
					</thead>
					<tbody>
						<%for(Inventory i : poDetails.getPoDetails()){ %>
						<tr>
							<td><%=i.getStock().getName() %></td>
							<td><%=i.getQuantity() %></td>
							<td><%=i.getStock().getUnit() %></td>
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
</div><!-- /#page-wrapper -->
</div><!-- /#wrapper -->
</body>
<script type="text/javascript">
$(document).ready(function(){
	$('#purchaseOrder').DataTable({
		responsive: true;
	});
});
</script>
</html>