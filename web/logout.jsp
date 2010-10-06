<%-- 
    Document   : logout
    Created on : 5.10.2010, 23:26:09
    Author     : JariPH
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            session.setAttribute("userID", null); //session-muuttuja tyhjäksi
            pageContext.forward("index.jsp"); //ohjataan sisäänkirjautumiseen
        %>


    </body>
</html>
