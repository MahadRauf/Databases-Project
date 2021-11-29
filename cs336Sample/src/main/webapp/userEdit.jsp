<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Edit User Account</title>
</head>
<body>



Edit User info
<br> <!-- edit rep info(DONE)  --> 
	<form method="get" action="userAccountEdit.jsp">
	<table>	
		<tr>    
		<td>Username</td><td><input type="text" name="username"></td>
		</tr>
		<tr>
		<td>New Password</td><td><input type="text" name="password"></td>
		</tr>
		<tr>    
		<td>New First Name</td><td><input type="text" name="first"></td>
		</tr>
		<tr>    
		<td>New Last Name</td><td><input type="text" name="last"></td>
		</tr>
		</table>
		<input type="submit" value="Enter Username and information to update">
	</form>
<br>

<br> <!-- view all user accounts(DONE)  --> 
	<form method="get" action="userView.jsp">
		<input type="submit" value="View User Accounts">
	</form>
<br>

<br> <!-- promote user privileges(DONE)  --> 
	<form method="get" action="userPromote.jsp">
		<input type="submit" value="Add Privileges">
	</form>
<br>

<br> <!-- delete user  --> 
	<form method="get" action="userDelete.jsp">
		<input type="submit" value="Delete an User Account">
	</form>
<br>


<br> <!-- return to admin homepage(DONE)  --> 
	<form method="get" action="AdminHomePage.jsp">
		<input type="submit" value="Return">
	</form>
<br>

</body>
</html>