<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="model.User, model.SupplierDRDetails, model.Commissary, model.Stock, model.ComDelivery, model.MonthlyInventory" %>
<%@page import="dao.DepartmentDAO" %>
<%@page import="java.util.ArrayList" %>
<%
User loginUser = (User) session.getAttribute("loginUser");
String msg = (String) request.getAttribute("msg");
Commissary com = DepartmentDAO.getComByUserId(loginUser.getEmpId());
Stock selectedStock = (Stock) request.getAttribute("selectedStock");
ArrayList<SupplierDRDetails> supplierDelivery = (ArrayList<SupplierDRDetails>) request.getAttribute("supplierDelivery");
ArrayList<ComDelivery> comDelivery = (ArrayList<ComDelivery>) request.getAttribute("commissaryDelivery");
ArrayList<MonthlyInventory> comMonthly = (ArrayList<MonthlyInventory>) request.getAttribute("comMonthly");
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Admin - View Stock Audit Trail</title>
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
		<h1><%=selectedStock.getName() %> Audit Trail of <%=com.getComName()%></h1>
	</div><!-- /.col-lg-12 -->
</div><!-- /.row -->
<%if(msg != null){ %>
<div class="row">
	<div class="col-lg-12">
		<div class="alert alert-info alert-dismissable">
			<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button><i class="fa fa-info-circle"></i>  <strong><%= msg%></strong>
		</div>
	</div>
</div><!-- /.row -->
<%} %>
<div class="row">
	<div class="col-lg-5">
		<div class="panel panel-info">
			<form action="ViewAudit" method="post">
			<div class="panel-heading">Select Date Range</div>
			<div class="panel-body">
			<input type="hidden" name="comID" value="<%=com.getComId()%>">
			<input type="hidden" name="stockID" value="<%=selectedStock.getStockId()%>">
				<div class="form-group">
					<label>Start Date</label>
					<input type="date" name="startDate" class="form-control" required>
				</div>
				<div class="form-group">
					<label>End Date</label>
					<input type="date" name="endDate" class="form-control" required>
				</div>
			</div><!-- /.panel-body -->
			<div class="panel-footer">
				<input type="submit" value="Set Date" class="btn btn-success">
				<input type="reset" value="Reset" class="btn btn-warning">
			</div><!-- /.panel-footer -->
			</form><!-- ViewAudit Form -->
		</div><!-- /.panel panel-info -->
	</div><!-- /.col-lg-5 -->
</div><!-- /.row -->
</br>
<div class="row">
	<div class="col-lg-7">
		<div class="panel panel-info">
			<div class="panel-heading"><%=selectedStock.getName() %> Delivery From Suppliers</div>
			<div class="panel-body">
				<table width="100%" class="table table-striped table-bordered table-hover" id="supplierDelivery">
					<thead>
						<tr>
							<th>Supplier</th>
							<th>Received Date</th>
							<th>Received Time</th>
							<th>Quantity Received</th>
						</tr>
					</thead>
					<tbody>
						<%for(SupplierDRDetails sdDetails : supplierDelivery){ %>
						<tr>
							<td><%=sdDetails.getSupplier().getSupplierName() %></td>
							<td><%=sdDetails.getReceivedDate() %></td>
							<td><%=sdDetails.getReceivedTime() %></td>
							<td><%=sdDetails.getDeliverQty() + sdDetails.getStock().getUnit() %></td>
						</tr>
						<%} %>
					</tbody>
				</table>
			</div><!-- /.panel-body -->
			<div class="panel-footer">
				--- End of Supplier Delivery Report ---
			</div><!-- /.panel-footer -->
		</div><!-- /.panel panel-default -->
	</div><!-- /.col-lg-7 -->
</div><!-- /.row -->
</br>
<div class="row">
	<div class="col-lg-7">
		<div class="panel panel-info">
			<div class="panel-heading"><%=selectedStock.getName() %> Delivery To Branches</div>
			<div class="panel-body">
				<table width="100%" class="table table-striped table-bordered table-hover" id="comDelivery">
					<thead>
						<tr>
							<th>Destination Branch</th>
							<th>Delivery Date</th>
							<th>Delivery Time</th>
							<th>Quantity Delivered to Branch</th>
						</tr>
					</thead>
					<tbody>
						<%for(ComDelivery cd : comDelivery){ %>
						<tr>
							<td><%=cd.getBranch().getBranchName() %></td>
							<td><%=cd.getCreationDate() %></td>
							<td><%=cd.getCreationTime() %></td>
							<td><%=cd.getDeliverQty() + cd.getStock().getUnit() %></td>
						</tr>
						<%} %>
					</tbody>
				</table>
			</div><!-- /.panel-body -->
			<div class="panel-footer">
				--- End of Commissary Delivery Report ---
			</div><!-- /.panel-footer -->
		</div><!-- /.panel panel-default -->
	</div><!-- /.col-lg-7 -->
</div><!-- /.row -->
</br>
<div class="row">
	<div class="col-lg-7">
		<div class="panel panel-info">
			<div class="panel-heading">All Ending Inventory of <%=selectedStock.getName() %></div>
			<div class="panel-body">
				<table width="100%" class="table table-striped table-bordered table-hover" id="ending">
					<thead>
						<tr>
							<th>Recorded Date</th>
							<th>End of the Month Quantity</th>
							<th>Discrepancy Quantity</th>
							<th>Discrepancy Type</th>
						</tr>
					</thead>
					<tbody>
						<%for(MonthlyInventory mi : comMonthly){ %>
						<tr>
							<td><%=mi.getRecordDate() %></td>
							<td><%=mi.getActualQty() + mi.getStock().getUnit() %></td>
							<%if(mi.getDiscrepancy() < 0){ %>
							<td><%=(mi.getDiscrepancy() * -1 )+ mi.getStock().getUnit() %></td>
							<td>Spoilage</td>
							<%}else{ %>
							<td><%=mi.getDiscrepancy() + mi.getStock().getUnit() %></td>
							<td>Surplus</td>
							<%} %>
						</tr>
						<%} %>
					</tbody>
				</table>
			</div><!-- /.panel-body -->
			<div class="panel-footer">
				--- End of Monthly Inventory Report---
			</div><!-- /.panel-footer -->
		</div><!-- /.panel panel-default -->
	</div><!-- /.col-lg-7 -->
</div><!-- /.row -->
</div><!-- /.page-wrapper -->
</div><!-- /.wrapper -->
</body>
<script type="text/javascript">
$(document).ready(function(){
	$('#ending').DataTable({
		responsive: true
	});
});
</script>
</html>