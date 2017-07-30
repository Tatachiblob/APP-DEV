<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="model.User, model.ComDelivery" %>
<%@page import="dao.ReceiptDAO, dao.DepartmentDAO" %>
<%@page import="java.util.ArrayList" %>
<%
User loginUser = (User) session.getAttribute("loginUser");
int comId = DepartmentDAO.getComByUserId(loginUser.getEmpId()).getComId();
ArrayList<ComDelivery> allComDr = ReceiptDAO.getAllComDelivery(comId);
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Admin - All Commissary Delivery</title>
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
		<h1>All Commissary Delivery Receipt</h1>
	</div><!-- /.col-lg-12 -->
</div><!-- /.row -->
<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-info">
			<div class="panel-heading">Commissary Delivery Receipts</div>
			<div class="panel-body">
				<table width="100%" class="table table-striped table-bordered table-hover" id="comDr">
					<thead>
						<tr>
							<th>Destination Branch</th>
							<th>Creation Date</th>
							<th>Creation Time</th>
							<th>View Details</th>
						</tr>
					</thead>
					<tbody>
						<%for(ComDelivery dr : allComDr){ %>
						<tr>
							<td><%=dr.getBranch().getBranchName() %></td>
							<td><%=dr.getCreationDate() %></td>
							<td><%=dr.getCreationTime() %></td>
							<td align="center"><a href="ViewAllDeliverReceipt?i=<%=dr.getComDrId()%>&com=<%=comId%>&b=<%=dr.getBranch().getBranchId()%>&action=comDr" class="btn btn-info"><i class="fa fa-fw fa-level-up"></i></a></td>
						</tr>
						<%} %>
					</tbody>
				</table>
			</div><!-- /.panel-body -->
			<div class="panel-footer">
				---End of Commissary Delivery Receipt---
			</div><!-- /.panel-footer -->
		</div><!-- /.panel panel-default -->
	</div><!-- /.col-lg-12 -->
</div><!-- /.row -->
</div><!-- /#page-wrapper -->
</div><!-- /#wrapper -->
</body>
<script type="text/javascript">
$(document).ready(function(){
	$('#comDr').DataTable({
		responsive: true
	});
});
</script>
</html>