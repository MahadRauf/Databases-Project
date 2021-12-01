<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Generate Summary Lists</title>
</head>
<body>

Generate Revenue Summary by Flight
<br> <!-- give revenue summary for flight   --> 
	<form method="get" action="sumListFlight.jsp">
	<table>	
		<tr>    
		<td>Flight Number</td><td><input type="text" name="flightNum"></td>
		</tr>
		</table>
		<input type="submit" value="Enter Flight Number">
	</form>
<br>

Generate Revenue Summary by Airline
<br> <!-- give revenue summary for Airline  --> 
	<form method="get" action="sumListAir.jsp">
	<table>	
		<tr>    
		<td>Flight Number</td><td><input type="text" name="air"></td>
		</tr>
		</table>
		<input type="submit" value="Enter two letter Airline ID">
	</form>
<br>


Generate Revenue Summary by Costumer
<br> <!-- give revenue summary for user   --> 
	<form method="get" action="sumListUser.jsp">
	<table>	
		<tr>    
		<td>User</td><td><input type="text" name="user"></td>
		</tr>
		</table>
		<input type="submit" value="Enter Username">
	</form>
<br>





<br> <!-- return to admin homepage(DONE)  --> 
	<form method="get" action="AdminHomePage.jsp">
		<input type="submit" value="Return">
	</form>
<br>

</body>
</html>