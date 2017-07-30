<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="model.User, model.SupplierDRDetails" %>
<%@page import="dao.ReceiptDAO, dao.DepartmentDAO" %>
<%@page import="java.util.ArrayList" %>
<%
User loginUser = (User) session.getAttribute("loginUser");
int comId = DepartmentDAO.getComByUserId(loginUser.getEmpId()).getComId();
ArrayList<SupplierDRDetails> allDr = ReceiptDAO.getAllSupplierDRByComId(comId);
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Admin - View All Supplier Delivery Receipt</title>
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
		<h1>All Supplier Delivery Receipt</h1>
	</div><!-- /.col-lg-12 -->
</div><!-- /.row -->
<div class="row">
	<div class="col-lg-7">
		<div class="panel panel-default">
			<div class="panel-heading">Supplier Delivery Receipts</div>
			<div class="panel-body">
				<table width="100%" class="table table-striped table-bordered table-hover" id="dr">
					<thead>
						<tr>
							<th>Supplier</th>
							<th>Received Date</th>
							<th>Received Time</th>
							<th>View Details</th>
						</tr>
					</thead>
					<tbody>
						<%for(SupplierDRDetails s : allDr){ %>
						<tr>
							<td><%=s.getSupplier().getSupplierName() %></td>
							<td><%=s.getReceivedDate() %></td>
							<td><%=s.getReceivedTime() %></td>
							<td><a href="ViewAllDeliverReceipt?i=<%=s.getDrId() %>&s=<%=s.getSupplier().getSupplierId()%>&action=supplier" class="btn btn-info"><i class="fa fa-fw fa-level-up"></i></a></td>
						</tr>
						<%} %>
					</tbody>
				</table>
			</div><!-- /.panel-body -->
			<div class="panel-footer">
				---End of Delivery Receipts Report---
			</div><!-- /.panel-footer -->
		</div><!-- /.panel panel-default -->
	</div><!-- /.col-lg-12 -->
</div><!-- /.row -->
</div><!-- /#page-wrapper -->
</div><!-- /#wrapper -->
</body>
<script type="text/javascript">
$(document).ready(function{
	$('#dr').DataTable({
		responsive: true
	});
});
</script>
</html>