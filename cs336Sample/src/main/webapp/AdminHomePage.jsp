<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Taka Travels - Welcome</title>
</head>
<body>

<br> <!-- add rep  --> 
	<form method="get" action="accountMake.jsp">
		<input type="submit" value="Add an Account">
	</form>
<br>


<br> <!-- edit rep info  --> 
	<form method="get" action="repEdit.jsp">
		<input type="submit" value="Manage Customer Representative Accounts">
	</form>
<br>

<br> <!-- edit user info  --> 
	<form method="get" action="userEdit.jsp">
		<input type="submit" value="Manage User Accounts">
	</form>
<br>

<br> <!-- obtain sales report for particular month  --> 
	<form method="get" action="salesByMonth.jsp">
		<input type="submit" value="Obtain Sales Report">
	</form>
<br>

<br> <!-- produce a list of reservations by flight number or customer name --> 
	<form method="get" action="listRes.jsp">
		<input type="submit" value="Produce List of Reservations">
	</form>
<br>

<br> <!-- produce a summary list of revenue raised by airline, flight, and customer  --> 
	<form method="get" action="sumList.jsp">
		<input type="submit" value="View Revenue Summary">
	</form>
<br>

<br> <!-- find what customer raised most revenue  --> 
	<form method="get" action="custRank.jsp">
		<input type="submit" value="View Customer who raised most revenue">
	</form>
<br>


<br> <!-- produce a list of flights with most tickets sold  --> 
	<form method="get" action="flightByTicket.jsp">
		<input type="submit" value="Find the hottest flights">
	</form>
<br>

<!--  <br>  add, edit info, delete rep & user info  -->  
	<!-- <form method="get" action="APFlights.jsp"> --> 
		<!-- <input type="submit" value="flights to/from an airport"> -->
	<!-- </form> -->
<!-- <br> -->


<br> <!-- logout  --> 
	<form method="get" action="HelloWorld.jsp">
		<input type="submit" value="Logout">
	</form>
<br>

</body>
</html>
