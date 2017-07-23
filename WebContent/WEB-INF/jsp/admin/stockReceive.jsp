<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="model.User, model.Supplier, model.Stock" %>
<%@page import="dao.SupplierDAO" %>
<%@page import="java.util.ArrayList" %>
<%
User loginUser = (User) session.getAttribute("loginUser");
ArrayList<Supplier> availableSuppler = SupplierDAO.getAllSupplier();
Supplier chosenSupplier = (Supplier) request.getAttribute("chosenSupplier");
ArrayList<Stock> supplierStocks = (ArrayList<Stock>) request.getAttribute("supplierStock");
String msg = (String) request.getAttribute("msg");
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Admin - Receive Stock</title>
<meta charset="utf-8">
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
		<h1 class="page-header">Receive Stock</h1>
	</div><!-- /.col-lg-12 -->
</div><!-- /.row -->
<% if (msg != null) {%>
<div class="row">
	<div class="col-lg-12">
		<div class="alert alert-info alert-dismissable">
			<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button><i class="fa fa-info-circle"></i>  <strong><%= msg%></strong>
		</div>
	</div>
</div><!-- /.row -->
<% }%>
<div class="row">
	<div class="col-lg-2">
		<h4>Choose Supplier:</h4>
		<form action="ReceiveStockProcess"  method="post">
		<input type="hidden" name="type" value="changeSupplier">
		<select name="supplier" class="form-control" onchange="this.form.submit()">
			<option selected disabled>Choose a supplier</option>
			<%for(Supplier s : availableSuppler){ %>
			<option value="<%=s.getSupplierId()%>"><%=s.getSupplierName() %></option>
			<%} %>
		</select>
		</form>
	</div><!-- /.col-lg-2 -->
</div><!-- /.row -->
<%if(chosenSupplier != null){ %>
<div class="row">
	<div class="col-lg-12">
		<form action="ReceiveStockProcess" method="post" id="mainForm">
		<div class="panel panel-default">
			<div class="panel-heading"><%=chosenSupplier.getSupplierName() %> : Receive Stock</div>
			<div class="panel-body">
				<input type="hidden" name="type" value="receive">
				<input type="hidden" name="supplierID" value="<%=chosenSupplier.getSupplierId()%>">
				<table width="100%" class="table table-striped table-bordered table-hover" id="supply">
					<thead>
						<tr>
							<th>Stock Name</th>
							<th>Receiving Stock</th>
							<th>Stock Keeping Unit</th>
						</tr>
					</thead>
					<tbody>
						<%for(Stock s : supplierStocks){ %>
						<tr>
							<td><%=s.getName() %></td>
							<td><input type="number" class="form-control" name="stock<%=s.getStockId()%>" id="stock<%=s.getStockId()%>" min="0" step="0.01" placeholder="0" value="0"></td>
							<td><%=s.getUnit() %></td>
						</tr>
						<%} %>
					</tbody>
				</table>
			</div><!-- /.panel-body -->
			<div class="panel-footer">
				<button type="button" class="btn btn-block btn-success" onclick="openModal()" >Receive Stocks</button>
				<input type="reset" class="btn btn-warning btn-block" value="Reset Numbers">
			</div><!-- /.panel-footer -->
		</div><!-- /.panel panel-default -->
		</form>
	</div><!-- /.col-lg-12 -->
</div><!-- /.row -->
	<%}//If chosen not null %>
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
	$('#supply').DataTable({
		responsive : true
	});
});

function openModal(){
	$('#myModal').modal();
}
</script>
</html>