<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Demote Customer Representative Account</title>
</head>
<body>

Enter the Account you wish to demote!
	<br>
		<form method="get" action="demote.jsp">
			<table>
				<tr>    
					<td>Username</td><td><input type="text" name="username"></td>
				</tr>
			</table>
			<input type="submit" value="Demote!">
		</form>
	<br>





<br> <!-- return to admin homepage  --> 
	<form method="get" action="AdminHomePage.jsp">
		<input type="submit" value="Return">
	</form>
<br>

</body>
</html>