

<%@page import="model.Users"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Registration</title>
    </head>
    <body>
        <jsp:include page="nav.jsp"/>
        <div class="box-container">
            
            <%
                Users user=(Users)session.getAttribute("login");
                String action = request.getParameter("action");
                if(user.getAccessRight()==0 && action.equals("0")){%>
                <form action="RegisterStaff" method="POST">
                    <h1>Staff Registration</h1>
                <%}else if(user.getAccessRight()==0 && action.equals("1")){%>
                <form action="RegisterSales" method="POST">   
                    <h1>Sales Registration</h1>
                <%}else if(user.getAccessRight()==1){%>
                <form action="RegisterCustomer" method="POST">
                    <h1>Customer Registration</h1>
                <%}
            %>
            
                <table>
                     <tr>
                        <td>
                            Full Name:
                        </td>
                        <td>
                            <input type="text" name="name" size="20" required></td>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Username:
                        </td>
                        <td>
                            <input type="text" name="username" size="20" required></td>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Password:
                        </td>
                        <td>
                            <input type="password" name="password" size="20" pattern=".{8,}" title="Eight or more characters" required></td>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Gender:
                        </td>
                        <td>
                            <input type="text" name="gender" size="20" pattern="M|F" title="only letter M or F is allowed" required></td>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Contact Number:
                        </td>
                        <td>
                            <input type="text" pattern="[0-9]{10,11}" title="Invalid Phone Number. (example: 012345678)" name="contact" size="20" required></td>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Email:
                        </td>
                        <td>
                            <input type="email" name="email" size="20" pattern="[^@\s]+@[^@\s]+" title="Invalid email address" required></td>
                        </td>
                    </tr>
                </table>
            <p><input type="submit" value="Register" class="btn btn-outline-primary"></p>
        </form>
        </div>
        
    </body>
</html>
