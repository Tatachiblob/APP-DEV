<%@page import="dao.CommissaryDAO"%>
<%@page import="model.Branch"%>
<%@page import="dao.StockDAO,dao.SupplierDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList, model.Stock, model.Commissary, model.Supplier" %>
<%
    User loginUser = (User) session.getAttribute("loginUser");
    String msg = (String) request.getAttribute("msg");
    ArrayList<Stock> allStock = new ArrayList<Stock>();
    Branch selectedBranch = null;
    try{
    if(!session.getAttribute("selectedBranch").equals(null)){
        selectedBranch = (Branch) session.getAttribute("selectedBranch");
        allStock = CommissaryDAO.getStocks(loginUser.getEmpId());
        }
    }
    catch(Exception e){
    System.out.println(e);
    }
    ArrayList<Branch> allBranches = CommissaryDAO.getAssignedBranches(loginUser.getEmpId());

%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%=loginUser.getEmpId() %> - Send Stocks</title>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="">
        <meta name="author" content="">
        <%@ include file="../../../styleinclude.jsp" %>
        
        <style>
        .modal-dialog-center {
        margin-top: 30vh;
        }    
            
        </style>
    </head>
    <body>
        <div id="wrapper">
            <%@ include file="comInclude.jsp"%>
            <div id="page-wrapper">
                <div class="row">
	<div class="col-lg-12">
            <div class="page-header"><h1>Send Stocks</h1></div>
            
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
            <h4>Choose Branch: </h4>
            <form action="sendStock?action=changeBranch" method="post">
                
                <select id="choosebranch" name="choosebranch" onchange="this.form.submit()" class="form-control" >
                    <option selected disabled> Choose branch </option>
                        <%for(Branch thisbranch : allBranches){ 
                        try{
                        if(thisbranch.getBranchId() == selectedBranch.getBranchId()){%>
                        
                        <option value=<%= thisbranch.getBranchId() %> selected> <%= thisbranch.getBranchName() %>  </option>
                        <%} else{ %>
                        <option value=<%= thisbranch.getBranchId() %> > <%= thisbranch.getBranchName() %>  </option>
                        <% } }catch(Exception e){System.out.println("choose supps error " + e); %>
                        <option value=<%= thisbranch.getBranchId()%> > <%= thisbranch.getBranchName() %>
                        <% }} %>
                </select>
            </form>
        </div>
        
	<div class="col-lg-12" style="margin-top:10px;">
                        <div class="panel panel-default">
                            <div class="panel-heading">Adjustment</div>
                            <div class="panel-body">
                                <form action="sendStock?action=sendStocks" method="post" id="mainForm"> 
                                    <div class="form-group"><input type="hidden" class="form-control" name="numofitems" id="numofrows"></div>
                                    
                                <table width="100%" class="table table-striped table-bordered table-hover" id="myTable">
                                    <thead>
                                        <tr>
                                            <th>Stock Name</th>
                                            <th>Quantity to Send</th>
                                            <th>Stock Keeping Unit</th>
                                            
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <% if (!allStock.isEmpty()){
                                            int i = 0;

                                            for(Stock thisStock : allStock){ %>
                                            <tr id ="<%="stockField_" + Integer.toString(i)%>">
                                            
                                            <td>
                                                
                                            <div class="form-group">
                                                <input type="text" id="<%="choosestock_" + Integer.toString(i)%>" name="<%="choosestock_" + Integer.toString(i)%>" value="<%=thisStock.getName()%>" style="background-color: transparent;border: 0px solid;height: 20px;width: 160px;" readonly >
                                            </div>
                                            </td>
                                            <td>
                                                <div class="form-group">
                                                    <input id="<%="quantity_" + Integer.toString(i)%>" name="<%="quantity_" + Integer.toString(i)%>" type="number" class="form-control" value="<%=thisStock.getQty() %>" min ="0" max="<%= thisStock.getQty() %>" oninput="quantityFunction(this)" data-toggle="tooltip" title="This stock has <%= thisStock.getQty() %> left in the inventory." >
                                                </div>
                                            </td>
                                            <td>
                                                <%=thisStock.getUnit() %>
                                            </td>
                                            
                                            </tr>
                                            
                                            <%i++;}} else{ %>
                                            <tr><td>Please choose a branch first.</td><td></td><td></td></tr>
                                        <% }%>
                                        
                                    </tbody>
                                    
                                </table>
                                    <button type="button" class="btn btn-info btn-md" data-toggle="modal" data-target="#myModal" onclick="submitFunction()">Submit</button>
                                    <input type="reset" class="btn btn-warning" value="Reset">
                                </form>
                            </div>
                    </div>
                </div><!-- /.col-lg-12 -->
</div><!-- /.row -->

<!-- Modal -->
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

<script>
$(document).ready(function(){
    $('[data-toggle="tooltip"]').tooltip();   
});
//Additional function for the submit to send the number of rows
function submitFunction(){
    var rows = document.getElementById("myTable").getElementsByTagName("tr").length;
    document.getElementById("numofrows").value = rows - 1;
}

function finalSubmitFunction(){
    document.getElementById("mainForm").submit();
}

function quantityFunction(object) {
    if(object.value > parseInt(object.max)){
        object.value = object.max;
    }
}


 </script>
</body>

</html>
