<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="model.User, model.Commissary, model.Inventory, model.Stock"%>
<%@page import="dao.DepartmentDAO, dao.CustomDAO" %>
<%@page import="java.util.ArrayList" %>
<%
User loginUser = (User) session.getAttribute("loginUser");
Commissary myCom = DepartmentDAO.getComByUserId(loginUser.getEmpId());
ArrayList<Inventory> comInventory = CustomDAO.getCurrentComInventory(myCom.getComId());
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Admin - Ending Inventory</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<%@ include file="../../../styleinclude.jsp" %>
</head>
<body>
<div id="wrapper">
<%@ include file="adminInclude.jsp" %>
<div id="page-wrapper">
<div class="row">
	<div class="col-lg-12">
		<h1>Ending Inventory Count</h1>
	</div><!-- /.col-lg-12 -->
</div><!-- /.row -->
<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<form action="EndingInventoryProcess" method="post" id="mainForm">
			<input type="hidden" name="comId" value="<%=myCom.getComId()%>">
			<div class="panel-heading"><%=myCom.getComName()%> Inventory</div>
			<div class="panel-body">
				<table width="100%" class="table table-striped table-bordered table-hover" id="myTable">
					<thead>
						<tr>
							<th>Stock Name</th>
							<th>Current Quantity</th>
							<th>Stock Keeping Unit</th>
							<th><strong>Adjustments</strong></th>
						</tr>
					</thead>
					<tbody>
						<%for(Inventory i : comInventory){ %>
						<tr>
							<td><%=i.getStock().getName() %></td>
							<td><%=i.getQuantity() + i.getStock().getUnit() %></td>
							<td><%=i.getStock().getUnit() %></td>
							<td><input type="number" name="stock<%=i.getStock().getStockId()%>" step="0.01" min="0" class="form-control" required></td>
						</tr>
						<%} %>
					</tbody>
				</table>
			</div><!-- /.panel-body -->
			<div class="panel-footer">
				<button type="button" class="btn btn-block btn-success" onclick="openModal()">Submit</button>
				<input type="reset" value="Reset" class="btn btn-warning btn-block">
			</div><!-- /.panel-footer -->
			</form>
		</div><!-- /.panel panel-default -->
	</div><!-- /.col-lg-12 -->
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
<!-- End of Modal Content -->
</body>
<script type="text/javascript">
$(document).ready(function(){
	$('#myTable').DataTable({
		responsive: true
	});
});

function openModal(){
	$('#myModal').modal();
}
</script>
</html>