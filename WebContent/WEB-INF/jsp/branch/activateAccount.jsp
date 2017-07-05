<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="model.User" %>
<%
User loginUser = (User) session.getAttribute("loginUser");
%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Activation of Account</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 <meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<%@ include file="../../../styleinclude.jsp" %>
</head>
<body>
<p>Hello <%=loginUser.getFirstName() + ", " + loginUser.getLastName()%>. Please change your password to activate your account.</p>
<form action="#" mehod="post">
	<table>
		<tr><th align="right">New Password: </th><td><input id="nPass" type="password" name="newPassword" required autofocus></td></tr>
		<tr><th align="right">Confirm Password: </th><td><input id="cPass" type="password" required></td></tr>
		<tr><td><input id="hit" type="submit" value="Activate Account"></td></tr>
		<tr><td><input type="reset" value="Reset"></td></tr>
	</table>
</form>
</body>
<script type="text/javascript">
$(document).ready(function(){
	$('#hit').click(function(){
		var nPass = $('nPass').val();
		var cPass = $('cPass').val();

		console.log(nPass + " " + cPass);
	});
});
</script>
</html>