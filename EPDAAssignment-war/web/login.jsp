<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-ygbV9kiqUc6oa4msXn9868pTtWMgiQaeYH7/t7LECLbyPA2x65Kgf80OJFdroafW" crossorigin="anonymous"></script>
        <script type="text/javascript" src="js/jquery-3.5.1.js"></script> 

    </head>
    <body>
        
        <div class="box-container">
            <jsp:include page="header.jsp"/>
            <form action="Login" method="POST" class="align-center" id="login">
                <table>
                    <tr>
                        <td>Username: </td>
                        <td><input type="text" name="username" size="20>"</td>
                    </tr>
                    <tr>
                        <td>Password: </td>
                        <td><input type="password" name="password" size="20"></td>
                    </tr>
                </table>
                <p><input type="submit" class="btn btn-outline-primary" value="Login"></p>
            </form>
        </div>
    </body>
</html>
