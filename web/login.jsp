<%--
    Document   : login
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
        <title>SISÄÄN KIRJAUTUMINEN</title>
    </head>

    <script>
        //Rekisteröinti-lomakkeen validointi (ei tyhjiä kenttiä)
        function validateForm()
        {
            if(document.loginForm.username.value=="")
                return false;
            else if(document.loginForm.password.value=="")
                return false;
        }
    </script>

    <body>
        <center><h1>SISÄÄN KIRJAUTUMINEN</h1></center>
        <form name="loginForm" method="post" action="login.jsp" onsubmit="return validateForm();">
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
  				<td><input type="submit" name="submit" value="Kirjaudu"/></td>
			</tr>
		</table></center>
	</form>
        <br/>
        <center>
            <a href='register.jsp'>Rekisteröidy</a><br/>
        
        <%
            if(request.getParameter("submit") != null){
                DatabaseMachine dbm = DatabaseMachine.createDatabaseMachine();
                if(dbm.checkPassword(request.getParameter("username").toString(), request.getParameter("password").toString())){
                    session.setAttribute("userID", new String("0"));
                    pageContext.forward("index.jsp"); //ohjataan sisään
                }
                else{
                    session.setAttribute("userID", null);
                    out.println("Tarkista käyttäjätunnus ja salasana!"); //vituiks meni
                }
            }

        %>
        </center>
    </body>
</html>

