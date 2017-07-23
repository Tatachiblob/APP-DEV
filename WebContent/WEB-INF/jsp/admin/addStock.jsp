<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.User, model.Supplier, java.util.ArrayList, dao.SupplierDAO"%>
<%
User loginUser = (User) session.getAttribute("loginUser");
String msg = (String) request.getAttribute("msg");
ArrayList<Supplier> availableSupplier = SupplierDAO.getAllSupplier();
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Admin - Add Stock</title>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<%@ include file="../../../styleinclude.jsp" %>
</head>
<body>
<div id="wrapper">
<%@ include file="adminInclude.jsp"%>
<div id="page-wrapper">
<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">Add New Inventory</h1>
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
	<div class="col-lg-9">
		<div class="panel panel-default">
			<div class="panel-heading"><h4>New Stock Entry</h4></div>
			<div class="panel-body">
				<div class="col-lg-6">
					<form action="AddStock" method="post">
						<div class="form-group">
							<label for="prodname">Stock Name</label>
							<input class="form-control" placeholder="Product Name" required name="stockName" type="text">
						</div>
						<div class="form-group">
							<label for="sku">Stock Keeping Unit</label>
							<input class="form-control" placeholder="Stock Keeping Unit" required name="sku" type="text">
						</div>
						<div class="form-group">
							<label for="flrlvl">Floor Level</label>
							<input class="form-control" placeholder="Stock Keeping Unit" required name="floorLvl" type="number" step="0.01">
						</div>
						<div class="form-group">
							<label for="flrlvl">Ceil Level</label>
							<input class="form-control" placeholder="Stock Keeping Unit" required name="ceilLvl" type="number" step="0.01">
						</div>
						<div class="form-group">
							<fieldset id="supplier">
								<label>Supplier</label>
								<select name="assignSupplier"  class="form-control"required>
									<option value="">Please Select One</option>
									<%for(Supplier sup : availableSupplier){ %>
									<option value="<%=sup.getSupplierId()%>"><%=sup.getSupplierName()%></option>
									<%} %>
								</select>
							</fieldset>
						</div>
						<input type="submit" class="btn btn-primary" value="Submit">
						<input type="reset" class="btn btn-warning" value="Reset">
					</form>
				</div><!-- /.col-lg-6 -->
			</div><!-- /.panel-body -->
		</div><!-- /.panel panel-default -->
	</div><!-- /.col-lg-9 -->
</div><!-- /.row -->
</div><!-- /#page-wrapper -->
</div><!-- /#wrapper -->
</body>
</html>
