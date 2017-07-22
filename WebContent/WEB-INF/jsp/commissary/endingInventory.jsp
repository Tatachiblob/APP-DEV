<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList, model.User" %>
<%@page import="dao.CommissaryDAO"%>
<%@page import="dao.BranchDAO"%>
<%@page import="model.Branch"%>
<%@page import="model.Stock"%>
<%@page import="model.Commissary"%>
<%
User loginUser = (User) session.getAttribute("loginUser");
String msg = (String) request.getAttribute("msg");
ArrayList<Stock> comAllStock = new ArrayList<Stock>();
Commissary selectedCom = new Commissary();
    try{
    selectedCom = CommissaryDAO.getCommissaryofEmployee(loginUser.getEmpId());
    session.setAttribute("selectedCom", selectedCom);
    comAllStock = CommissaryDAO.getStocksbyComID(selectedCom.getComId());
    }
    catch(Exception e){
    System.out.println(e);
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Commissary - Ending Inventory</title>
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
<%@ include file="comInclude.jsp" %>
<div id="page-wrapper">
<div class="row">
	<div class="col-lg-12">
		<h1>Ending Inventory Count</h1>
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
            <div class="panel-heading"><%= selectedCom.getComName() %> Inventory</div>
                <!-- /.panel-heading -->
                <div class="panel-body">
                    <form action="endingInventory?action=countItems" method="post" id="mainForm">
                    <div class="form-group"><input type="hidden" class="form-control" name="numofrows" id="numofrows"></div>
                    <table width="100%" class="table table-striped table-bordered table-hover" id="countTable">
                        <thead>
                            <tr>
                                <th>Stock Name</th>
                                <th>Current Quantity</th>
                                <th>Stock Keeping Unit</th>
                                <th><strong>Adjustments</strong></th>
                            </tr>
                        </thead>
                        <tbody>
                            <% if (!comAllStock.isEmpty()){
                            int i = 0;

                            for(Stock thisStock : comAllStock){ %>
                                <tr id ="<%="stockField_" + Integer.toString(i)%>">
                                            
                                <td>
                                    <input type="text" id="<%="countstock_" + Integer.toString(i)%>" name="<%="countstock_" + Integer.toString(i)%>" value="<%=thisStock.getName()%>" style="background-color: transparent;border: 0px solid;height: 20px;width: 160px;" readonly >
                                </td>
                                <td>
                                    <input type="number" id="<%="countstockqty_" + Integer.toString(i)%>" name="<%="countstockqty_" + Integer.toString(i)%>" value="<%=thisStock.getQty()%>" style="background-color: transparent;border: 0px solid;height: 20px;width: 160px;" readonly >
                                </td>
                                <td>
                                    <%=thisStock.getUnit() %>
                                </td>
                                <td>
                                    <div class="form-group">
                                    <input type="number" class="form-control" name="<%="ending_" + Integer.toString(i) %>" id="<%="ending_" + Integer.toString(i) %>" value="0">
                                    </div>
                                </td>
				
                                            
                                </tr>
                                            
                                <%i++;}} else{ %>
                                    <tr><td>Your inventory is empty of items.</td><td></td><td></td></tr>
                                    <% }%>
			</tbody>
                    </table>
                    <button type="button" class="btn btn-info btn-md" data-toggle="modal" data-target="#myModal">Submit</button>
                    <input type="reset" class="btn btn-warning" value="Reset">
                    </form>
		</div>
	</div>
    </div>
</div><!-- /#row -->

<!-- Confirmation Modal -->
  <div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog modal-dialog-center">
    
      <!-- Modal content-->
      <div class="modal-content">
          
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">Confirm changes</h4>
        </div>
          
        <div class="modal-body">

                <center>
                <h3>Are you sure you want to proceed?</h3>
                
                <button type="button" class="btn btn-info" data-toggle="modal" data-target="#myModal" onclick="finalSubmitFunction()">Yes</button>
                <button type="button" class="btn btn-danger" data-dismiss="modal">No</button>
                </center>
            
        </div>
        <div class="modal-footer">
            <small>(c) 2017 Komoro Food Corp.</small>
        </div>

      </div>
      
    </div>
  </div><!-- MODAL END -->

</div><!-- /#page-wrapper -->
</div><!-- /#wrapper -->
</body>
<script type="text/javascript">
$(document).ready(function(){
	$('#empTable').DataTable({
		responsive : true
	});
});

function finalSubmitFunction(){
    var rows = document.getElementById("countTable").getElementsByTagName("tr").length;
    document.getElementById("numofrows").value = rows - 1;
    document.getElementById("mainForm").submit();
}
</script>
</html>