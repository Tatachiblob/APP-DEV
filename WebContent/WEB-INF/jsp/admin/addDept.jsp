<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="model.User, model.Commissary, java.util.ArrayList, dao.DepartmentDAO" %>
<%
String msg = (String) request.getAttribute("msg");
User loginUser = (User) session.getAttribute("loginUser");
ArrayList<Commissary> coms = DepartmentDAO.getAllCommissary();
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Admin Page - Add Department</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
		<h1 class="page-header">Create New Department</h1>
	</div><!-- /.col-lg-12 -->
</div><!-- /.row -->
<% if(msg != null){ %>
<div class="row">
	<div class="col-lg-12">
		<div class="alert alert-info alert-dismissable">
			<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button><i class="fa fa-info-circle"></i>  <strong><%= msg %></strong>
		</div>
	</div>
</div><!-- /.row -->
<%} %>
<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">New Department Entry</div>
			<div class="panel-body">
				<div class="row">
					<div class="col-lg-6">
						<form action="AddDept" method="post" id="mainForm">
							<div class="form-group">
								<label>Department Type</label>
								<div class="radio">
									<label><input id="ans1" type="radio" name="deptType" value="com" required="required">Commissary</label>
								</div>
								<div class="radio">
									<label><input id="ans2" type="radio" name="deptType" value="branch" required="required">Branch</label>
								</div>
							</div>
							<div class="form-group">
								<label>Department Name</label>
								<input class="form-control" name="deptName" type="text" placeholder="department name" autofocus required>
							</div>
							<div class="form-group">
								<label>Address</label>
								<input class="form-control" name="deptAddress" type="text" placeholder="department address" required>
							</div>
							<div class="form-group">
								<fieldset id="kom">
									<label>Assign Commissary</label>
									<select class="form-control" name="assignCom" required>
										<option value="">Please Select</option>
										<% for(int i = 0; i < coms.size(); i++){ %>
										<option value="<%= coms.get(i).getComId() %>" ><%= coms.get(i).getComName() %></option>
										<% } %>
									</select>
								</fieldset>
							</div>
							<button type="button" class="btn btn-success" onclick="openModal()" >Submit</button>
							<input type="reset" class="btn btn-warning" value="Reset">
						</form>
					</div><!-- /.col-lg-6 -->
				</div><!-- /.row -->
			</div><!-- /.panel-body -->
		</div><!-- /.panel panel-default -->
	</div><!-- /.col-lg-12 -->
</div><!-- /.row -->
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
	function checkradiobox(){
		var radio = $("input[name='deptType']:checked").val();
		$('#kom').attr('disabled', true);
		if(radio == "com"){
			$('#kom').attr('disabled', true);
		}else if(radio == "branch"){
			$('#kom').attr('disabled', false);
		}
	}

	$("#ans1, #ans2").change(function(){
		checkradiobox();
	});

	checkradiobox();
});

function openModal(){
	$("#myModal").modal();
}
</script>
</html>