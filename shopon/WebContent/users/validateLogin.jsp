<%@ page import ="java.sql.*" %>

<%

/* get username and password from login form  */
String username=request.getParameter("username");
String password=request.getParameter("password");

try{
	/* connect database */
	
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn=DriverManager.getConnection(
			"jdbc:mysql://localhost:3306/shopon",
			"root","");

	/* execute query */
	
	PreparedStatement ps=conn.prepareStatement(""+
			"select * from users where userName=? AND userPassword=?");
	ps.setString(1,username);
	ps.setString(2,password);
	
	ResultSet rs=ps.executeQuery();
	boolean status=rs.next();
	
	if(status) {
		out.println("Successfully logged in " + username);
		
		/* Set session details */
		session.setAttribute("username", username);
		
		response.sendRedirect("../index.jsp");
	}
	else {
		out.println("login failed");
		//request.sendRedirect("login.jsp");
	}
}
catch(Exception e) {
	out.println("Connection problem >> " + e);
}
%>