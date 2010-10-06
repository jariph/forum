<%-- 
    Document   : newTopic
    Created on : 5.10.2010, 23:35:28
    Author     : JariPH
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="luokat.DatabaseMachine"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Uusi topic</title>
    </head>

    <script>
        //Rekisteröinti-lomakkeen validointi (ei tyhjiä kenttiä)
        function validateForm()
        {
            if(document.newTopicForm.topic.value=="")
                return false;
            else if(document.newTopicForm.message.value=="")
                return false;
        }
    </script>

    <body>
        <%  //tarkistetaan onko käyttäjä kirjautunut
            if(session.getAttribute("userID") == null)
                pageContext.forward("login.jsp"); //ohjataan sisäänkirjautumiseen
        %>
        <%@ include file='navigation.jsp' %>

        <br/><br/><br/>
        <center><h2>Luo uusi topic</h2></center>
        <form name="newTopicForm" method="post" action="newTopic.jsp" onsubmit="return validateForm();">
		<center><table>
			<tr>
				<td>Topic:</td>
                                <td><input name="topic" style="width: 100%"></td>
			</tr>
			<tr>
  				<td>Viesti:</td>
                                <td><textarea name="message" rows=15 cols=60></textarea></td>
			</tr>
			<tr>
				<td/>
  				<td><input type="submit" name="submit" value="Luo aihe"/></td>
			</tr>
		</table></center>
	</form>
        <br/>

        <%
            if(request.getParameter("submit") != null){
                DatabaseMachine dbm = DatabaseMachine.createDatabaseMachine();
                dbm.addTopic((String)session.getAttribute("userID"), request.getParameter("topic"), request.getParameter("message"));
                out.println("Uusi topic luotu.");
            }
        %>

    </body>
</html>
