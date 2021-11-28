<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*, java.text.SimpleDateFormat"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Search Result</title>
</head>
<body>
	<div>
		<h3>Questions and Answers</h3>
		<form method="get" action="Questions.jsp">
			Search for questions:
			<input type="text" name="keywords">
			<input type="submit" value="Search">
		</form>
		<br>
		<form method="get" action="Questions.jsp">
			Enter new question:
			<input type="text" name="question">
			<input type="submit" value="Post">
		</form>
		<br>
		<form method="get" action="Questions.jsp">
			<input type="submit" value="Show all questions and answers">
		</form>
		<br>
	</div>
	<%
	try {
		//Get the database connection and Create a SQL statement
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		Statement stmt = con.createStatement();
		String select;
		PreparedStatement ps;
		ResultSet rs;
			
		//Posting Question
		String userQuestion = request.getParameter("question");		
		if (userQuestion != null && !userQuestion.trim().isEmpty()) //Post this data before displaying
		{
			String insert = "INSERT INTO `Questions` (`Question`, `Answer`, `username`) VALUES (?, DEFAULT, 'user1')";
			PreparedStatement ps1 = con.prepareStatement(insert);
			ps1.setString(1, userQuestion);
			request.setAttribute("question", null);
			ps1.executeUpdate();
		}
		
		//Specific questions to be selected
		String keywords = request.getParameter("keywords");
		if (keywords != null && !keywords.trim().isEmpty())
		{
			select = "SELECT * FROM questions WHERE ";
			//Tokenize each of the keywords given, append AND Question LIKE '%keyword%' to front of string and end of select,
			String[] keywordsList = keywords.split(" ");
			for (String k : keywordsList)
			{
				select+= "Question LIKE '%" + k + "%' OR Answer LIKE '%" + k + "%' OR ";
			}
			select = select.substring(0, select.length()-4);
			select+=";";
			request.setAttribute("keywords", null);
			ps = con.prepareStatement(select);
			rs = ps.executeQuery();
		}
		else //Select all questions
		{
			select = "SELECT * FROM questions";
			ps = con.prepareStatement(select);
			rs = ps.executeQuery();
		}
		
		//Make an HTML table to show the results in:
		out.print("<table>");
		out.print("<tr>");
		
		out.print("<td><u>");
		out.print("Question");
		out.print("</u></td>");

		out.print("<td><u>");
		out.print("Answer");
		out.print("</u></td>");
		
		out.print("</tr>");

		//parse out the results
		while (rs.next()) {
			out.print("<tr>");
						
			out.print("<td>");
			out.print(rs.getString("Question"));
			out.print("</td>");
			
			out.print("<td>");
			out.print(rs.getString("Answer"));
			out.print("</td>");
			
			out.print("</tr>");
		}
		out.print("</table>");
		//close the connection
		con.close();	
		
	} catch (Exception ex) {
		out.print(ex);
	}
%>
</body>
</html>