<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="model.User, model.Inventory, model.Supplier" %>
<%@page import="java.util.ArrayList" %>
<%
User loginUser = (User) session.getAttribute("loginUser");
Supplier sup = (Supplier) request.getAttribute("deliverySupplier");
ArrayList<Inventory> deliveryDetails = (ArrayList<Inventory>) request.getAttribute("deliveryDetails");
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Admin - Specific Delivery Receipt</title>
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
		<h1><%=sup.getSupplierName() %> Delivery Detail</h1>
	</div><!-- /.col-lg-12 -->
</div><!-- /.row -->
<div class="row">
	<div class="col-lg-7">
		<div class="panel panel-info">
			<div class="panel-heading">Delivery Receipt Details(<%=sup.getSupplierName() %>)</div>
			<div class="panel-body">
				<table width="100%" class="table table-striped table-bordered table-hover" id="dr">
					<thead>
						<tr>
							<th>Stock Name</th>
							<th>Receive Quantity</th>
							<th>Unit</th>
						</tr>
					</thead>
					<tbody>
						<%for(Inventory i : deliveryDetails){ %>
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
				---End of Delivery Receipt Report---
			</div><!-- /.panel-footer -->
		</div><!-- /.panel panel-default -->
	</div><!-- /.col-lg-12 -->
</div><!-- /.row -->
</div><!-- /#page-wrapper -->
</div><!-- /#wrapper -->
</body>
<script type="text/javascript">
$(document).ready(function(){
	$('#dr').DataTable({
		responsive: true
	});'
});
</script>
</html>