
<%@page import="dao.CommissaryDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList, model.User" %>
<%@page import="model.Commissary"%>
<%@page import="dao.BranchDAO"%>
<%@page import="model.Branch"%>
<%@page import="model.Stock"%>
<%
User loginUser = (User) session.getAttribute("loginUser");
String msg = (String) request.getAttribute("msg");
ArrayList<Stock> branchAllStock = new ArrayList<Stock>();
ArrayList<Stock> comAllStock = CommissaryDAO.getStocks(loginUser.getEmpId());
ArrayList<Branch> allBranches = new ArrayList<Branch>();
Commissary comofUser = null;
Branch selectedBranch = null;

    try{
    comofUser = CommissaryDAO.getCommissaryofEmployee(loginUser.getEmpId());
    allBranches = BranchDAO.getAllBranchofCom(comofUser.getComId());
    selectedBranch = allBranches.get(0);
    branchAllStock = BranchDAO.getStocksbyBranchID(selectedBranch.getBranchId());
    if(!session.getAttribute("selectedBranch").equals(null)){
        selectedBranch = (Branch) session.getAttribute("selectedBranch");
        branchAllStock = BranchDAO.getStocksbyBranchID(selectedBranch.getBranchId());
        }
    }
    catch(Exception e){
    System.out.println(e);
    }
    
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Admin - View Stock Availability</title>
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
		<h1>Stock Availability</h1>
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
<% } %>

<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-default">
            <div class="panel-heading"><%= comofUser.getComName() %> Inventory</div>
                <!-- /.panel-heading -->
                <div class="panel-body">
                    <table width="100%" class="table table-striped table-bordered table-hover" id="dataTables-example">
                        <thead>
                            <tr>
                                <th>Stock Name</th>
                                <th>Floor Level</th>
                                <th>Ceiling Level</th>
                                <th>Stock Keeping Unit</th>
                                <th>Current Quantity</th>
                                <th><strong>Product Status</strong></th>
                            </tr>
                        </thead>
                        <tbody>
                            <% if (!comAllStock.isEmpty()){
                            int i = 0;

                            for(Stock thisStock : comAllStock){ %>
                                <tr id ="<%="stockField_" + Integer.toString(i)%>">
                                            
                                <td>
                                    <%= thisStock.getName() %>
                                </td>
                                <td>
                                <%= thisStock.getFloorLvl() %>
                                </td>
                                <td>
                                <%= thisStock.getCeilLvl()%>
                                </td>
                                <td>
                                    <%=thisStock.getUnit() %>
                                </td>
				<td>
                                    <%=thisStock.getQty()%>
                                </td>
                                <% if(thisStock.getQty() <= thisStock.getFloorLvl() && thisStock.getQty() > 0){%>
                                    <td bgcolor="yellow"><strong>Low in Stock</strong></td>
                                    <% }  
                                    else if(thisStock.getQty() > thisStock.getFloorLvl() && thisStock.getQty() < thisStock.getCeilLvl()){%>
                                    <td bgcolor="lightgreen"><strong>In Stock</strong></td>
                                    <% }
                                    else if(thisStock.getQty() == 0){%>
                                    <td bgcolor="red"><strong>Out of stock</strong></td>
                                    <% }
                                    else if(thisStock.getQty() >= thisStock.getCeilLvl()){%>
                                    <td bgcolor="info"><strong>Overstock</strong></td>
                                    <% } %>
                                            
                                            </tr>
                                            
                                <%i++;}} else{ %>
                                    <tr><td>Your inventory is empty of items.</td><td></td><td></td></tr>
                                    <% }%>
			</tbody>
                    </table>
		</div>
	</div>
    </div>
</div><!-- /#row -->

<div class="row">
    <div class="col-lg-4">
            <h4>Set Branch: </h4>
            <form action="ViewStockAvailability?action=changeBranch" method="post">
                
                <select id="choosebranch" name="choosebranch" onchange="this.form.submit()" class="form-control" >
                    <option selected disabled> Choose branch </option>
                        <%for(Branch thisbranch : allBranches){ 
                        try{
                        if(thisbranch.getBranchId() == selectedBranch.getBranchId()){%>
                        
                        <option value=<%= thisbranch.getBranchId() %> selected> <%= thisbranch.getBranchName() %>  </option>
                        <%} else{ %>
                        <option value=<%= thisbranch.getBranchId() %> > <%= thisbranch.getBranchName() %>  </option>
                        <% } }catch(Exception e){System.out.println("ERROR: Choose Branch (Admin) " + e); %>
                        <option value=<%= thisbranch.getBranchId()%> > <%= thisbranch.getBranchName() %>
                        <% }} %>
                </select>
            </form>
        </div>
   
</div> <!-- row of choose branch dropdown -->
<br>
<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-default">
            <% if(selectedBranch == null){ %>
                <div class="panel-heading">Branch Stocks</div>
            <% } else{ %>
                <div class="panel-heading"><%= selectedBranch.getBranchName() %> Inventory</div>
                <% }%>
                <div class="panel-body">
                    <table width="100%" class="table table-striped table-bordered table-hover" id="dataTables-example">
                        <thead>
                            <tr>
                                <th>Stock Name</th>
                                <th>Floor Level</th>
                                <th>Ceiling Level</th>
                                <th>Stock Keeping Unit</th>
                                <th>Current Quantity</th>
                                <th><strong>Product Status</strong></th>
                            </tr>
                        </thead>
                        <tbody>
                            <% if (!comAllStock.isEmpty()){
                            int i = 0;

                            for(Stock thisStock : branchAllStock){ %>
                                <tr id ="<%="stockField_" + Integer.toString(i)%>">
                                            
                                <td>
                                    <%= thisStock.getName() %>
                                </td>
                                <td>
                                <%= thisStock.getFloorLvl() %>
                                </td>
                                <td>
                                <%= thisStock.getCeilLvl()%>
                                </td>
                                <td>
                                    <%=thisStock.getUnit() %>
                                </td>
				<td>
                                    <%=thisStock.getQty()%>
                                </td>
                                <% if(thisStock.getQty() <= thisStock.getFloorLvl() && thisStock.getQty() > 0){%>
                                    <td bgcolor="yellow"><strong>Low in Stock</strong></td>
                                    <% }  
                                    else if(thisStock.getQty() > thisStock.getFloorLvl() && thisStock.getQty() < thisStock.getCeilLvl()){%>
                                    <td bgcolor="lightgreen"><strong>In Stock</strong></td>
                                    <% }
                                    else if(thisStock.getQty() == 0){%>
                                    <td bgcolor="red"><strong>Out of stock</strong></td>
                                    <% }
                                    else if(thisStock.getQty() >= thisStock.getCeilLvl()){%>
                                    <td bgcolor="info"><strong>Overstock</strong></td>
                                    <% } %>
                                            
                                            </tr>
                                            
                                <%i++;}} else{ %>
                                    <tr><td>Your inventory is empty of items.</td><td></td><td></td></tr>
                                    <% }%>
			</tbody>
                    </table>
		</div>
	</div>
    </div>
</div><!-- /#row -->


</div><!-- /#page-wrapper -->
</div><!-- /#wrapper -->
</body>
<script type="text/javascript">
$(document).ready(function(){
	$('#empTable').DataTable({
		responsive : true
	});
});
</script>
</html>