<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="model.User, model.Commissary, model.PurchaseOrder" %>
<%@page import="dao.DepartmentDAO" %>
<%@page import="java.util.ArrayList" %>
<%
User loginUser = (User) session.getAttribute("loginUser");
Commissary com = DepartmentDAO.getComByUserId(loginUser.getEmpId());
ArrayList<PurchaseOrder> allPo = (ArrayList<PurchaseOrder>) request.getAttribute("allPo");
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Admin - Purchase Order Report</title>
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
		<h1>Purchase Order Report</h1>
	</div><!-- /.col-lg-12 -->
</div><!-- /.row -->
</br>
<div class="row">
	<div class="col-lg-5">
		<div class="panel panel-info">
			<form action="ViewPurchaseOrder" method="post">
			<input type="hidden" name="comId" value="<%=com.getComId()%>">
			<div class="panel-heading">Select Date Range</div>
			<div class="panel-body">
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
		<div class="panel panel-default">
			<div class="panel-heading"><%=com.getComName()%> Purchase Order</div>
			<div class="panel-body">
				<table width="100%" class="table table-striped table-bordered table-hover" id="purchaseOrder">
					<thead>
						<tr>
							<th>Supplier</th>
							<th>Creation Date</th>
							<th>Creation Time</th>
							<th>View Details</th>
						</tr>
					</thead>
					<tbody>
						<%for(PurchaseOrder po : allPo){ %>
						<tr>
							<td><%=po.getSupplier().getSupplierName() %></td>
							<td><%=po.getCreationDate() %></td>
							<td><%=po.getCreationTime() %></td>
							<td align="center"><a href="ViewPurchaseOrder?p=<%=po.getPoId()%>" class="btn btn-info"><i class="fa fa-fw fa-level-up"></i></a></td>
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
</html>