<%@page import="dao.DatabaseUtils"%>
<%@page import="servlet.admin.ViewDept"%>
<%@page import="dao.DepartmentDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList, model.Branch, model.Commissary" %>
<%
ArrayList<Branch> allBr = DepartmentDAO.getAllBranch();
ArrayList<Commissary> allCom = DepartmentDAO.getAllCommissary();
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Admin Page - View Department</title>
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
		<div class="page-header"><h1>All Departments</h1></div>
	</div><!-- /.col-lg-12 -->
</div><!-- /.row -->
<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">View Departments</div>
			<div class="panel-body">
				<table width="100%" class="table table-striped table-bordered table-hover" id="allDept">
					<thead>
						<tr>
							<th>Department Name</th>
							<th>Address</th>
							<th>Department Type</th>
							<th>View Details</th>
						</tr>
					</thead>
					<tbody>
						<%for(Commissary com : allCom){ %>
						<tr>
							<td><%=com.getComName()%></td>
							<td><%=com.getComAddress()%></td>
							<td>Commissary</td>
							<td><a href="ViewDept?deptId=<%=DatabaseUtils.getPasswordFunc(Integer.toString(com.getComId()))%>&deptType=com"><i class="fa fa-database"></i></a></td>
						</tr>
						<%} %>
						<%for(Branch br : allBr){ %>
						<tr>
							<td><%=br.getBranchName()%></td>
							<td><%=br.getBranchAddress()%></td>
							<td>Branch</td>
							<td><a href="ViewDept?deptId=<%=DatabaseUtils.getPasswordFunc(Integer.toString(br.getBranchId()))%>&deptType=br"><i class="fa fa-database"></i></a></td>
						</tr>
						<%} %>
					</tbody>
				</table>
			</div><!-- /.panel-body -->
			<div class="panel-footer">
				--- End of Contents ---
			</div><!-- /.panel-footer -->
		</div><!-- /.panel panel-default -->
	</div><!-- /.col-lg-12 -->
</div><!-- /.row -->
</div><!-- /#page-wrapper -->
</div><!-- /#wrapper -->
</body>
<script type="text/javascript">
$(document).ready(function(){
	$('#allDept').DataTable({
		responsive : true
	});
});
</script>
</html>