<%--
    Document   : register
    Created on : 5.10.2010, 17:00:34
    Author     : JariPH
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="luokat.DatabaseMachine"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <LINK REL=StyleSheet HREF='style.css' TYPE='text/css'>
        <title>Rekisteröityminen</title>
    </head>

    <script>
        //Rekisteröinti-lomakkeen validointi (ei tyhjiä kenttiä)
        function validateForm()
        {
            if(document.registerForm.username.value=="")
                return false;
            else if(document.registerForm.password.value=="")
                return false;
        }
    </script>

    <body>
        <center><h1>REKISTERÖITYMINEN</h1></center>
        <form name="registerForm" method="post" action="register.jsp" onsubmit="return validateForm();">
		<center><table>
			<tr>
				<td>Tunnus:</td>
				<td><input name="username" type="text"/></td>
			</tr>
			<tr>
  				<td>Salasana:</td>
                                <td><input type="password" name="password" type="text"/></td>
			</tr>
			<tr>
				<td/>
  				<td><input type="submit" name="submit" value="Rekisteröidy"/></td>
			</tr>
		</table></center>
	</form>
        <br/>
        <center>
        <%
            if(request.getParameter("submit") != null){
                DatabaseMachine dbm = DatabaseMachine.createDatabaseMachine();
                dbm.addUser(request.getParameter("username").toString(), request.getParameter("password").toString());
                out.println("Kiitos rekisteröinnistä!");
                out.println("<a href='login.jsp'>Kirjaudu sisään</a>");
            }

        %>
        </center>
    </body>
</html>
