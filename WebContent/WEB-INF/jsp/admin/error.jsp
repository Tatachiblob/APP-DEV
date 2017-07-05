<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Admin - Error</title>
</head>
<body>
<h1><%= request.getAttribute("msg") %></h1>
<p><a href="Logout">Back to Login</a></p>
</body>
</html>