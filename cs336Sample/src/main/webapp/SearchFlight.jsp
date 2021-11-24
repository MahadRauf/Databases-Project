<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Search Flight</title>
</head>
<body>
	<br>
	Trip Type:
	<br>
		<form method="get" action="SearchResult.jsp">
				<div>
		  <input type="radio" id="isoneway" name=isOneWay value=1
		         checked>
		  <label for="oneway">One Way</label>
		</div>
		
		<div>
		  <input type="radio" id="roundtrip" name="isOneWay" value=0>
		  <label for="roundtrip">Round Trip</label>
		</div>
		
		<div>
		  <input type="radio" id="both" name="isOneWay" value=2>
		  <label for="both">One Way or Round Trip (+/- 3 days) </label>
		</div>
				
	Flight Type:
	<br>			
		<div>
		  <input type="radio" id="domestic" name="isDomestic" value=1
		  	checked>
		  <label for="domestic">Domestic</label>
		</div>
		
		<div>
		  <input type="radio" id="international" name="isDomestic" value=0>
		  <label for="international">International</label>
		</div>		
		
<div>
<label for="start">Start date:</label>
<input type="date" id="start" name="departureDate"
       value="2022-01-01"
       placeholder="dd-mm-yyyy"
       min="2022-01-01" max="2022-12-31">
      
      </div>
  
<div>
<label for="end">End date:</label>
<input type="date" id="end" name="arrivalDate"
       value="2022-01-02"
       placeholder="dd-mm-yyyy"
       min="2022-01-01" max="2022-12-31">
      
      </div>  
      
      
	<table>
				<tr>    
					<td>From Airport</td><td><input type="text" name="fromAirport"></td>
				</tr>
				<tr>
					<td>To Airport</td><td><input type="text" name="toAirport"></td>
				</tr>
			</table>
			
			<label for="sort">Sort By</label>
			<select name="sort"  id="sort" size=1>
				<option value=0>Default</option>
				<option value=1>Price</option>
				<option value=2>Take-off Time</option>
				<option value=3>Landing Time</option>
				<option value=4>Duration of Flight</option>
				
			</select>&nbsp;<br> 
			
			Optional:<br> 
			<label for="priceFilter">Prices </label>
			<select name="priceFilter"  id="priceFilter" size=1>
				<option value=0>equal to </option>
				<option value=1>below</option>
				<option value=2>above</option>
			</select>&nbsp;
		<label for="price">$</label>
		  <input type="text" id="price" name="price">
		  <br> 
		  
					<label for="numStopFilter">Number of stops: </label>
			<select name="numStopFilter"  id="numStopFilter" size=1>
				<option value=0>equal to </option>
				<option value=1>below</option>
				<option value=2>above</option>
			</select>&nbsp;
		<label for="numStop"></label>
		  <input type="text" id="numStop" name="numStop">
		  <br> 
			
					<label for="airline">Airline: </label>
		  <input type="text" id="airline" name="airline">
			<br> 
			
			
			<label for="takeoff">Take-off Time:</label>
		  <input type="time" id="takeoff" name="takeoff">
			<br> 
			
			<label for="landing">Landing Time:</label>
		  <input type="time" id="landing" name="landing">
			<br> 
			
			<input type="submit" value="Search!">
		</form>
	<br>
</body>
</html>