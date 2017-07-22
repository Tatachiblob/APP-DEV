<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="model.Commissary, model.User, model.Stock, model.Supplier" %>
<%@ page import="java.util.ArrayList" %>
<%@page import="dao.StockDAO,dao.SupplierDAO"%>
<%
User loginUser = (User) session.getAttribute("loginUser");
String msg = (String) request.getAttribute("msg");
ArrayList<Stock> allStock = new ArrayList<Stock>();
ArrayList<Stock> addedStocks = (ArrayList<Stock>)session.getAttribute("ALaddedStocks");
Supplier selectedsupp = null;
Stock selectedstock = null;
try{
	if(!session.getAttribute("receivesupplier").equals(null)){
		selectedsupp = (Supplier) session.getAttribute("receivesupplier");
	}
	if(((String)session.getAttribute("addItemTrigger")).equals("0")){
		allStock = StockDAO.getStocksfromSupp(loginUser.getEmpId(),selectedsupp.getSupplierId());
		session.setAttribute("ALsuppStocks", allStock);
	}
	else{
		allStock = (ArrayList<Stock>)session.getAttribute("ALsuppStocks");
	}
	selectedstock = allStock.get(0);
	}catch(Exception e){
    	e.printStackTrace();
    }
ArrayList<Supplier> allSupps = SupplierDAO.getAllSupplier();
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><%=loginUser.getEmpId() %> - Receive Stocks</title>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<%@ include file="../../../styleinclude.jsp" %>
</head>
<body>
<div id="wrapper">
<%@ include file="adminInclude.jsp"%>
<div id="page-wrapper">
<div class="row">
	<div class="col-lg-12">
		<div class="page-header"><h1>Receive Stocks</h1></div>
	</div><!-- /.col-lg-12 -->
</div><!-- /.row -->
<% if (msg != null) {%>
<div class="row">
	<div class="col-lg-12">
		<div class="alert alert-info alert-dismissable">
			<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button><i class="fa fa-info-circle"></i>  <strong><%= msg%></strong>
		</div>
	</div>
</div><!-- /.row -->
<% }%>
<div class="row">
	<div class="col-lg-2">
	<h4>Choose Supplier: </h4>
	<form action="ChangeSupplier" method="post">

		<select id="choosesupp" name="choosesupp" onchange="this.form.submit()" class="form-control" >
			<option selected disabled> Choose a supplier </option>
			<%for(Supplier thissup : allSupps){
			try{
				if(thissup.getSupplierId() == selectedsupp.getSupplierId()){%>
				<option value=<%= thissup.getSupplierId() %> selected> <%= thissup.getSupplierName() %>  </option>
				<%} else{ %>
				<option value=<%= thissup.getSupplierId() %> > <%= thissup.getSupplierName() %>  </option>
				<% } }catch(Exception e){System.out.println("choose supps error " + e); %>
				<option value=<%= thissup.getSupplierId() %> > <%= thissup.getSupplierName() %>
				<% }} %>
		</select>
	</form>
	</div><!-- /.col-lg-12 -->
	<div class="col-lg-12" style="margin-top:10px;">
		<%if (!allStock.isEmpty()){ %>
		<button type="button" class="btn btn-success btn-lg" data-toggle="modal" data-target="#myModal"><span class="glyphicon glyphicon-plus"></span> Add Item</button>
		<%} else{ %>
		<button type="button" class="btn btn-success btn-lg" data-toggle="modal" data-target="#myModal" disabled><span class="glyphicon glyphicon-plus"></span> Add Item</button>
		<% } %>
		<h3>&nbsp;</h3>
			<div class="panel panel-default">
				<div class="panel-heading">Adjustment</div>
				<div class="panel-body">
					<form action="ReceiveStock" method="post">
					<div class="form-group"><input type="hidden" class="form-control" name="hiddenTextBox" id="numofrows"></div>
						<table width="100%" class="table table-striped table-bordered table-hover" id="myTable">
							<thead>
								<tr>
									<th>Stock Name</th>
									<th>Receiving Stock</th>
									<th>Stock Keeping Unit</th>
									<th></th>
								</tr>
							</thead>
							<tbody>
							<% if (!addedStocks.isEmpty()){
								int i = 0;
								System.out.println("ADDED STOCKS SIZE: " + addedStocks.size());
								for(Stock thisStock : addedStocks){ %>
								<tr id ="<%="stockField_" + Integer.toString(i)%>">
									<td><div class="form-group"><input type="text" id="<%="choosestock_" + Integer.toString(i)%>" name="<%="choosestock_" + Integer.toString(i)%>" value="<%=thisStock.getName()%>" readonly></div></td>
									<td><div class="form-group"><input id="<%="quantity_" + Integer.toString(i)%>" name="<%="quantity_" + Integer.toString(i)%>" type="number" class="form-control" value="<%=thisStock.getQty()%>" ></div></td>
									<td><%=thisStock.getUnit() %></td>
									<td><a href="#" class="btn btn-danger btn-lg" id="deleteThis"><span class="glyphicon glyphicon-trash"></span> Delete</a></td>
								</tr>
								<%i++;}} else{ %>
								<tr><td>Please add some stocks that have been received.</td><td></td><td></td><td></td></tr>
								<% }%>
							</tbody>
						</table>
						<input type="submit" class="btn btn-primary" value="Submit" onclick = "submitfunction()">
						<input type="reset" class="btn btn-warning" value="Reset">
					</form>
				</div><!-- /.panel-body -->
			</div><!-- /.panel panel-default -->
		</div><!-- /.col-lg-12 -->
</div><!-- /.row -->
<form action="deleteAddItem" method="post" id="deleteEntry">
	<div class="form-group">
		<input type="hidden" class="form-control" name="deleteStock" id="deleteStock">
	</div>
</form>
<!-- Modal -->
<div class="modal fade" id="myModal" role="dialog">
	<div class="modal-dialog">
	<!-- Modal content-->
	<div class="modal-content">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal">&times;</button>
			<h4 class="modal-title">Add Item</h4>
		</div>
		<div class="modal-body">
			<form action="receiveAddItem" method="post">
				<div class="form-group">
				<label>Choose stock item: </label>
				<select id="stocktoadd" name="stocktoadd" class="form-control" onchange="stockChange()">
					<% if (!allStock.isEmpty()){
					for(Stock currStock : allStock){ %>
					<option value="<%=currStock.getStockId()%>"><%=currStock.getName() %> </option>
					<%}} else{ %>
					<option selected disabled>Please choose a supplier first </option>
					<% }%>
				</select>
				</div>
				<div class="form-group">
					<label>Quantity: </label>
					<input id="quantitytoadd" name="quantitytoadd" type="number" class="form-control" value="0" >
				</div>
				<input type="submit" class="btn btn-primary" value="Submit">
			</form>
		</div>
	<div class="modal-footer"><button type="button" class="btn btn-default" data-dismiss="modal">Close</button></div>
	</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div>
</div><!-- /#page-wrapper -->
</div><!-- /#wrapper -->
<script>
$( document ).ready(function() {});
//Delete Entry Function
$("#myTable").on('click', "#deleteThis", function(e) {
    var whichtr = $(this).closest("tr");
    var stringtest = whichtr.find("input[type=text]").attr('value');
    alert("Removed stock: " + stringtest);
    document.getElementById("deleteStock").value = stringtest
    //whichtr.remove();
    document.getElementById("deleteEntry").submit()
});

//Placebo function, not used
function addAnotherRow() {

    var row = $("#myTable tr").last().clone();
    //row.id = row.id.slice(-1);
    var oldId = Number(row.attr('id').slice(-1));
    var id = 1 + oldId;

    row.attr('id', 'stockField_' + id );
    row.find('#choosestock_' + oldId).attr('name', 'choosestock_' + id);
    row.find('#choosestock_' + oldId).attr('id', 'choosestock_' + id);
    row.find('#quantity_' + oldId).attr('name', 'quantity_' + id);
    row.find('#quantity_' + oldId).attr('id', 'quantity_' + id);
    $('#myTable').append(row);
}
//Additional function for the submit to send the number of rows
function submitfunction(){
    var rows = document.getElementById("myTable").getElementsByTagName("tr").length;
    document.getElementById("numofrows").value = rows - 1;
    alert(document.getElementById("numofrows").value);
}
 </script>
</body>
</html>