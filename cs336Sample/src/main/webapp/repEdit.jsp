<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Edit Customer Representative Account</title>
</head>
<body>



Edit Customer Representative info
<br> <!-- edit rep info(DONE)  --> 
	<form method="get" action="repAccountEdit.jsp">
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

<br> <!-- view all customer rep accounts(DONE)  --> 
	<form method="get" action="repView.jsp">
		<input type="submit" value="View Customer Representative Accounts">
	</form>
<br>

<br> <!-- revoke rep privileges(DONE)  --> 
	<form method="get" action="repDemote.jsp">
		<input type="submit" value="Remove Privileges">
	</form>
<br>

<br> <!-- delete rep  --> 
	<form method="get" action="repDelete.jsp">
		<input type="submit" value="Delete a Customer Representative Account">
	</form>
<br>


<br> <!-- return to admin homepage(DONE)  --> 
	<form method="get" action="AdminHomePage.jsp">
		<input type="submit" value="Return">
	</form>
<br>

</body>
</html>
