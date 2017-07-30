<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="model.User, model.RequisitionOrder, model.Commissary" %>
<%@page import="dao.RequisitionDAO, dao.DepartmentDAO" %>
<%@page import="java.util.ArrayList" %>
<%
User loginUser = (User) session.getAttribute("loginUser");
Commissary com = DepartmentDAO.getComByUserId(loginUser.getEmpId());
ArrayList<RequisitionOrder> allReq = RequisitionDAO.getAllRequisitionByComID(com.getComId());
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Admin - All Requisition Order</title>
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
		<h1>View All Requisition Order</h1>
	</div><!-- /.col-lg-12 -->
</div><!-- /.row -->
<div class="row">
	<div class="col-lg-12">
		<div class="alert alert-info alert-dismissable">
			<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button><i class="fa fa-info-circle"></i>  <strong>Click Button to View Requition Order Details</strong>
		</div>
	</div>
</div><!-- /.row -->
<div class="row">
	<div class="col-lg-7">
		<div class="panel panel-default">
			<div class="panel-heading">All Requisition Order</div>
			<div class="panel-body">
				<table width="100%" class="table table-striped table-bordered table-hover" id="requisition">
					<thead>
						<tr>
							<th>Branch</th>
							<th>Record Date</th>
							<th>Record Time</th>
							<th>Details</th>
						</tr>
					</thead>
					<tbody>
						<%for(RequisitionOrder r : allReq){ %>
						<tr>
							<td><%=r.getBranch().getBranchName() %></td>
							<td><%=r.getRecordDate() %></td>
							<td><%=r.getRecordTime() %></td>
							<td align="center"><a href="ViewAllRequisition?i=<%=r.getReqId()%>&b=<%=r.getBranch().getBranchId()%>" class="btn btn-info"><i class="fa fa-fw fa-level-up"></i></a></td>
						</tr>
						<%} %>
					</tbody>
				</table>
			</div><!-- /.panel-body -->
			<div class="panel-footer">
				---End of Requisition Order---
			</div><!-- /.panel-footer -->
		</div><!-- /.panel panel-default -->
	</div><!-- /.col-lg-12 -->
</div><!-- /.row -->
</div><!-- /#page-wrapper -->
</div><!-- /#wrapper -->
</body>
</html>