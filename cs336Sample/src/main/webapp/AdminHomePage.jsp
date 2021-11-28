<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Taka Travels - Welcome</title>
</head>
<body>

<br> <!-- add, edit info, delete rep & user info  --> 
	<form method="get" action="rep&user.jsp">
		<input type="submit" value="Manage info">
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

<br> <!-- produce a summary list of revenue raised by particular flight, airline, or customer  --> 
	<form method="get" action="sumList.jsp">
		<input type="submit" value="Make a Revenue Summary List">
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