<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String message = (String) request.getAttribute("message");
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Login Page</title>
<%@ include file="styleinclude.jsp" %>
<style>
	body{
		margin:0px;
	}
	#hero {
		background-image: url("images/ss.png");
		background-size: cover;
		background-position: center center;
		position: relative;
		top:0;
		bottom:0;
		height: 100vh;
		z-index:-10;
	}
	#hero-overlay{
		position: absolute;
		background-color: rgba(0,0,0,0.5);
		top:0;
		bottom:0;
		height: 100%;
		width: 100%;
		z-index:-5;
	}
</style>
</head>
<body id="hero">
<div class="container">
<div class="row">
	<div class="col-md-4 col-md-offset-4">
		<div class="login-panel panel panel-default">
			<div class="panel-heading">
				<h3 class="panel-title" style="float:center;"><b>KOMORO INVENTORY SYSTEM</b></h3>
			</div>
			<div class="panel-body">
			<% if(message != null){ %>
			<div class="row">
				<div class="alert alert-danger"><%= message %></div>
			</div>
			<% } %>
				<form action="Login" method="post">
					<fieldset>
					<div class="form-group">
						<input name="username" class="form-control" placeholder="Username" name="username" type="text" autofocus>
					</div>
					<div class="form-group">
						<input name="password" class="form-control" placeholder="Password" name="password" type="password" value="">
					</div>
					<div class="checkbox">
						<label>
							<input name="fogot" type="checkbox" value="forgot">Remember Password
						</label>
					</div>
					<!-- Change this to a button or input when using this as a form -->
					<input type="submit" class="btn btn-lg btn-success btn-block" value="Login">
					</fieldset>
				</form>
			</div>
		</div>
	</div>
</div>
</div>
</body>
</html>