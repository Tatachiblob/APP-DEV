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
	<div class="col-lg-6">
		<form action="RequisitionOrderProcess" method="post" id="mainForm">
		<div class="panel panel-default">
			<div class="panel-heading"><%=br.getBranchName()%>'s Ending Inventory</div>
			<div class="panel-body">
				<div class="col-lg-12">
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
							<td><input type="number" step="0.01" name="endingInventory<%=i.getStock().getStockId()%>" placeholder="<%=i.getStock().getName() + " ending"%>" required></td>
						</tr>
						<%} %>
						</tbody>
					</table>
				</div><!-- /.col-lg-6 -->
			</div><!-- /.panel-body -->
		<div class="panel-footer">
			<button type="button" class="btn btn-block btn-success" onclick="openModal()">Submit</button>
			<input type="reset" value="Reset" class="btn btn-block btn-warning">
		</div><!-- /.panel-footer -->
		</div><!-- /.panel-default -->
		</form>
	</div><!-- /.col-lg-6 -->
</div><!-- /.row -->
</div><!-- /#page-wrapper -->
</div><!-- /#wrapper -->
<!-- Modal Content -->
<div class="modal fade" id="myModal" role="dialog">
	<div class="modal-dialog modal-dialog-center">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title">Confim Changes</h4>
			</div><!-- /.modal-header -->
			<div class="modal-body">
				<center>
					<h4>Are you sure you want to proceed?</h4>
					<input type="submit" name="submit" value="Yes" class="btn btn-info" data-toggle="modal" data-target="#myModal" form="mainForm">
					<button type="button" class="btn btn-danger" data-dismiss="modal">No</button>
				</center>
			</div><!-- /.modal-body -->
		</div><!-- modal-content -->
	</div><!-- /.modal-dialog modal-dialog-center -->
</div><!-- /.modal -->
</body>
<script type="text/javascript">
$(document).ready(function(){
	$('#reqOrderTable').DataTable({
		responsive: true
	});
});

function openModal(){
	$('#myModal').modal();
}
</script>
</html>