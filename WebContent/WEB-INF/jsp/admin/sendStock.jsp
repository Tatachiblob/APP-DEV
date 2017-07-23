<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="model.User, model.Branch, model.Inventory" %>
<%@page import="dao.CustomDAO, dao.DepartmentDAO, dao.StockDAO" %>
<%@page import="java.util.ArrayList" %>
<%
User loginUser = (User) session.getAttribute("loginUser");
int comId = DepartmentDAO.getComByUserId(loginUser.getEmpId()).getComId();
ArrayList<Branch> availableBranches = CustomDAO.getBranchByComID(comId);
String msg = (String) request.getAttribute("msg");
Branch branchChosen = (Branch) request.getAttribute("branchChosen");
ArrayList<Inventory> comInventory = (ArrayList<Inventory>) request.getAttribute("comInventory");
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Admin - Send Stocks</title>
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
		<h1 class="page-header">Send Stock</h1>
	</div><!-- /.col-lg-12 -->
</div><!-- /.row -->
<%if(msg != null){ %>
<div class="row">
	<div class="col-lg-12">
		<div class="alert alert-info alert-dismissable">
			<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button><i class="fa fa-info-circle"></i>  <strong><%= msg%></strong>
		</div>
	</div><!-- /.col-lg-12 -->
</div><!-- /.row -->
<%} %>
<div class="row">
	<div class="col-lg-12">
		<h4>Choose Branch: </h4>
		<form action="SendStockProcess" method="post">
		<input type="hidden" name="action" value="brChoosing">
		<select id="chosenBranch" name="chosenBranch" onchange="this.form.submit()" class="form-control">
			<option selected disabled>Choose Branch</option>
			<%for(Branch b : availableBranches){%>
			<option value="<%=b.getBranchId()%>"><%=b.getBranchName() %></option>
			<%} %>
		</select>
		</form>
	</div><!-- /.col-lg-12 -->
	<%if(branchChosen != null){ %>
	<div class="col-lg-12" style="margin-top:10px;">
		<div class="panel panel-default">
			<div class="panel-heading">Sending Stocks to <%=branchChosen.getBranchName()%></div>
			<form action="SendStockProcess" method="post" id="mainForm">
			<div class="panel-body">
				<input type="hidden" name="action" value="sendDetails">
				<input type="hidden" name="branchId" value="<%=branchChosen.getBranchId()%>">
				<table width="100%" class="table table-striped table-bordered table-hover" id="myTable">
					<thead>
						<tr>
							<th>Stock Name</th>
							<th>Quantity to Send</th>
							<th>Stock Keeping Unit</th>
						</tr>
					</thead>
					<tbody>
						<%for(Inventory i : comInventory){ %>
						<tr>
							<td><%=i.getStock().getName() %></td>
							<td><input type="number" id="stock<%=i.getStock().getStockId()%>" name="stock<%=i.getStock().getStockId()%>" class="form-control" min="0" max="<%=i.getQuantity()%>" step="0.01"  value="0" placeholder="0" data-toggle="tooltip" title="This stock has <%=i.getQuantity()%> left in the inventory"></td>
							<td><%=i.getStock().getUnit() %></td>
						</tr>
						<%} %>
					</tbody>
				</table><!-- /#myTable -->
			</div><!-- /.panel-body -->
			<div class="panel-footer">
				<button type="button" class="btn btn-block btn-success" onclick="openModal()">Send Stocks</button>
				<input type="reset" value="Reset Values" class="btn btn-block btn-warning">
			</div><!-- /.panel-footer -->
			</form>
		</div><!-- /.panel panel-default -->
	</div><!-- /.col-lg-12 -->
	<%} %>
</div><!-- /.row -->
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
$(document).ready(function(){
	$('[data-toggle="tooltip"]').tooltip();

	$('#myTable').DataTable({
		responsive: true
	});
});

function openModal(){
	$('#myModal').modal();
}

function finalSubmitFunction(){
	document.getElementById("mainForm").submit();
}
</script>
</html>