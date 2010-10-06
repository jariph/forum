<%-- 
    Document   : index
    Created on : Sep 23, 2010, 2:12:16 PM
    Author     : antti
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <LINK REL=StyleSheet HREF='style.css' TYPE='text/css'>
        <title>JSP Page</title>
    </head>
    <body>
        <%  //tarkistetaan onko käyttäjä kirjautunut
            if(session.getAttribute("userID") == null)
                pageContext.forward("login.jsp"); //ohjataan sisäänkirjautumiseen
        %>
        <%@ include file='navigation.jsp' %>
    </body>
</html>
