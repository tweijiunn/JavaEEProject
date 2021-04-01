<%-- 
    Document   : deposit
    Created on : Dec 17, 2020, 6:04:46 PM
    Author     : guan.kiat
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
         <jsp:include page="nav.jsp"/>
        <br><br>
        <form action="Deposit" method="POST">
            Deposit amount: <input type="text" name="a" size="20">
            <p><input type="submit" value="Deposit"></p>
        </form>
    </body>
</html>
