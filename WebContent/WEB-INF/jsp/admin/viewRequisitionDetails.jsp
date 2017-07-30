<%@page import="model.Inventory"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="model.User, model.RequisitionOrder, model.Branch" %>
<%
User loginUser = (User) session.getAttribute("loginUser");
RequisitionOrder ro = (RequisitionOrder) request.getAttribute("requisitionOrder");
Branch br = (Branch) request.getAttribute("br");
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Admin - Requisition Details</title>
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
		<h1>View Requisition Order Details</h1>
	</div><!-- /.col-lg-12 -->
</div><!-- /.row -->
<div class="row">
	<div class="col-lg-7">
		<div class="panel panel-default">
			<div class="panel-heading">Order Details (<%=br.getBranchName()%>)</div>
			<div class="panel-body">
				<table width="100%" class="table table-striped table-bordered table-hover" id="requisition">
					<thead>
						<tr>
							<th>Stock</th>
							<th>Ending Quantity</th>
							<th>Unit</th>
						</tr>
					</thead>
					<tbody>
						<%for(Inventory i : ro.getReqDetails()){ %>
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
				---End of Requisition Details---
			</div><!-- /.panel-footer -->
		</div><!-- /.panel panel-default -->
	</div><!-- /.col-lg-12 -->
</div><!-- /.row -->
</div><!-- /#page-wrapper -->
</div><!-- /#wrapper -->
</body>
<script type="text/javascript">
$(document).ready(function(){
	$('#requisition').DataTable({
		responsive: true
	});
});
</script>
</html>