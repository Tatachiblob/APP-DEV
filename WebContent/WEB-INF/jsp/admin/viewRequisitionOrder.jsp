<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="model.User, model.RequisitionOrder, model.Inventory" %>
<%@page import="dao.DepartmentDAO, dao.RequisitionDAO" %>
<%@page import="java.util.ArrayList" %>
<%
User loginUser = (User) session.getAttribute("loginUser");
int comId = DepartmentDAO.getComByUserId(loginUser.getEmpId()).getComId();
ArrayList<RequisitionOrder> reqOrders = RequisitionDAO.getYesterDayRequisition(comId);
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Admin - Requisition Order</title>
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
	<div class="col-lg-12"><h1 class="page-header">View Yesterday's Requisition Order From Branch</h1></div><!-- /.col-lg-12 -->
	<%if(reqOrders.isEmpty()){ %>
	<div class="row">
		 <div class="col-lg-6">
		 	<div class="alert alert-warning">There is no Orders from branch at the moment</div>
		 </div><!-- /.col-lg-6 -->
	</div><!-- /.row -->
	<%}else{ %>
	<div class="row">
		 <div class="col-lg-6">
		 	<div class="alert alert-info">Yesterday's Ending Inventory</div>
		 </div><!-- /.col-lg-6 -->
	</div><!-- /.row -->
	<%for(RequisitionOrder ro : reqOrders){ %>
	<div class="row">
		<div class="col-lg-6">
			<div class="panel panel-default">
				<div class="panel-heading"><%=ro.getBranch().getBranchName() %> Order</div>
				<div class="panel-body">
					<table width="100%" class="table table-striped table-bordered table-hover" id="<%=ro.getReqId()%>">
						<thead>
							<tr>
								<th>Stock Name</th>
								<th>Ending Inventory</th>
								<th>Stock Unit</th>
							</tr>
						</thead>
						<tbody>
							<%for(Inventory i : ro.getReqDetails()){ %>
							<tr>
								<td><%=i.getStock().getName() %></td>
								<td align="right"><%=i.getQuantity() %></td>
								<td><%=i.getStock().getUnit() %></td>
							</tr>
							<%} %>
						</tbody>
					</table>
				</div><!-- /.panel-body -->
			</div><!-- /.panel panel-default -->
			<div class="panel-footer"><a href="#" class="btn btn-info btn-block">Create Delivery Receipt</a></div>
		</div><!-- /.col-lg-12 -->
	</div><!-- /.row -->
<%}//for loop(RequisitionOrder ro : reqOrders) %>
<%}//else statement %>
</div><!-- /.row -->
</div><!-- /#page-wrapper -->
</div><!-- /#wrapper -->
</body>
<script type="text/javascript">
$(document).ready(function(){
	<%for(RequisitionOrder ro : reqOrders){%>
	$('#<%=ro.getReqId()%>').DataTable({
		responsive: true
	});
	<%}%>
});
</script>
</html>