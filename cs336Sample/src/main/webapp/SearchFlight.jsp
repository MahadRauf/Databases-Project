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
		<form method="get" action="SearchResult.jsp">
				<div>
		  <input type="radio" id="isoneway" name=isOneWay value="1"
		         checked>
		  <label for="oneway">One Way</label>
		</div>
		
		<div>
		  <input type="radio" id="roundtrip" name="isOneWay" value="0">
		  <label for="roundtrip">Round Trip</label>
		</div>
		
		<div>
		  <input type="radio" id="both" name="isOneWay" value="2">
		  <label for="both">One Way or Round Trip</label>
		</div>
				
				
		<div>
		  <input type="radio" id="domestic" name="isDomestic" value="1"
		  	checked>
		  <label for="domestic">Domestic</label>
		</div>
		
		<div>
		  <input type="radio" id="international" name="isDomestic" value="0">
		  <label for="international">One Way or Round Trip</label>
		</div>		
		
<div>
<label for="start">Start date:</label>
<input type="date" id="start" name="tripStart"
       value="2022-01-01"
       placeholder="dd-mm-yyyy"
       min="2022-01-01" max="2022-12-31">
      
      </div>
      
      <div>
      <label for="end">End date:</label>
<input type="date" id="end" name="tripEnd"
       value="2022-01-01"
       placeholder="dd-mm-yyyy"
       min="2022-01-01" max="2022-12-31">
      
      </div>
      
<table>
				<tr>    
					<td>start</td><td><input type="date" name="username"></td>
				</tr>
				<tr>
					<td>end</td><td><input type="date" name="password"></td>
				</tr>
			</table>
			<input type="submit" value="Search!">
		</form>
	<br>
</body>
</html>