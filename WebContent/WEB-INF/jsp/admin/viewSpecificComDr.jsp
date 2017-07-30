<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="model.User, model.Commissary, model.Inventory, model.Branch" %>
<%@page import="java.util.ArrayList" %>
<%
User loginUser = (User) session.getAttribute("loginUser");
Commissary com = (Commissary) request.getAttribute("com");
Branch br = (Branch) request.getAttribute("br");
ArrayList<Inventory> comDrDetails = (ArrayList<Inventory>) request.getAttribute("comDrDetails");
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Admin - Commissary Delivery Details</title>
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
		<h1>Commissary Delivery Details</h1>
	</div><!-- /.col-lg-12 -->
</div><!-- /.row -->
<div class="row">
	<div class="col-lg-5">
		<div class="panel panel-info">
			<div class="panel-heading"><%=com.getComName() %> Delivery Receipt To <%=br.getBranchName() %></div>
			<div class="panel-body">
				<table width="100%" class="table table-striped table-bordered table-hover" id="comDr">
					<thead>
						<tr>
							<th>Stock</th>
							<th>Delivery Quantity</th>
							<th>Unit</th>
						</tr>
					</thead>
					<tbody>
						<%for(Inventory i : comDrDetails){ %>
						<tr>
							<td><%=i.getStock().getName() %></td>
							<td><%=i.getQuantity() %></td>
							<td><%=i.getStock().getUnit() %></td>
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
</script>
</html>