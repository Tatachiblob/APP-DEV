<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="model.User, model.Supplier, model.Stock" %>
<%@page import="dao.SupplierDAO" %>
<%@page import="java.util.ArrayList" %>
<%
User loginUser = (User)session.getAttribute("loginUser");
String msg = (String) request.getAttribute("msg");
ArrayList<Supplier> availableSupplier = SupplierDAO.getAllSupplier();
Supplier supplier = (Supplier) request.getAttribute("supplier");
ArrayList<Stock> supplierStock = (ArrayList<Stock>) request.getAttribute("supplierStock");
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Admin - Create Purchase Order</title>
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
		<h1>Purchase Order</h1>
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
		<form action="CreatePurchaseOrder"  method="post">
		<input type="hidden" name="action" value="changeSupplier">
		<select name="supplier" class="form-control" onchange="this.form.submit()">
			<option selected disabled>Choose a supplier</option>
			<%for(Supplier s : availableSupplier){ %>
			<option value="<%=s.getSupplierId()%>"><%=s.getSupplierName() %></option>
			<%} %>
		</select>
		</form>
	</div><!-- /.col-lg-2 -->
</div><!-- /.row -->
</br>
<%if(supplier != null){ %>
<div class="row">
	<div class="col-lg-7">
		<div class="panel panel-default">
			<form action="CreatePurchaseOrder" method="post" id="mainForm">
			<input type="hidden" name="action" value="purchase">
			<input type="hidden" name="supplierID" value="<%=supplier.getSupplierId()%>">
			<div class="panel-heading"><%=supplier.getSupplierName() %> Stocks</div>
			<div class="panel-body">
				<table width="100%" class="table table-striped table-bordered table-hover" id="supplierStock">
					<thead>
						<tr>
							<th>Stock Name</th>
							<th>Quantity</th>
							<th>Stock Keeping Unit</th>
						</tr>
					</thead>
					<tbody>
						<%for(Stock stock : supplierStock){ %>
						<tr>
							<td><%=stock.getName() %></td>
							<td><input type="number" min="0" step="0.01"  name="stock<%=stock.getStockId()%>" class="form-control" value="0" required></td>
							<td><%=stock.getUnit() %></td>
						</tr>
						<%} %>
					</tbody>
				</table>
			</div><!-- /.panel-body -->
			<div class="panel-footer">
				<button type="button" class="btn btn-block btn-success" onclick="openModal()" >Receive Stocks</button>
				<input type="reset" class="btn btn-warning btn-block" value="Reset Numbers">
			</div><!-- /.panel-footer -->
			</form>
		</div><!-- /.panel panel-default -->
	</div><!-- /.col-lg-12 -->
</div><!-- /.row -->
<%} %>
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
</div><!-- /#page-wrapper -->
</div><!-- /#wrapper -->
</body>
<script type="text/javascript">
function openModal(){
	$('#myModal').modal();
}
</script>
</html>