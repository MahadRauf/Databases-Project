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
	<form method="get" action="repMake.jsp">
		<input type="submit" value="Add a Customer Representative Account">
	</form>
<br>

<br> <!-- add user  --> 
	<form method="get" action="userMake.jsp">
		<input type="submit" value="Add an User Account">
	</form>
<br>

<br> <!-- edit rep info  --> 
	<form method="get" action="repEdit.jsp">
		<input type="submit" value="Edit a Customer Representative Account">
	</form>
<br>

<br> <!-- edit user info  --> 
	<form method="get" action="userEdit.jsp">
		<input type="submit" value="Edit an User Account">
	</form>
<br>

<br> <!-- delete rep  --> 
	<form method="get" action="repDelete.jsp">
		<input type="submit" value="Delete a Customer Representative Account">
	</form>
<br>

<br> <!-- delete user  --> 
	<form method="get" action="userDelete.jsp">
		<input type="submit" value="Delete an User Account">
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

<br> <!-- produce a summary list of revenue raised by particular flight  --> 
	<form method="get" action="sumListFlight.jsp">
		<input type="submit" value="Make a Flight Revenue Summary List">
	</form>
<br>

<br> <!-- produce a summary list of revenue raised by particular airline  --> 
	<form method="get" action="sumListAir.jsp">
		<input type="submit" value="Make an Airline Revenue Summary List">
	</form>
<br>

<br> <!-- produce a summary list of revenue raised by customer  --> 
	<form method="get" action="sumListUser.jsp">
		<input type="submit" value="Make a Customer Revenue Summary List">
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
