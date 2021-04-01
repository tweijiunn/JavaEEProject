

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
                if(user.getAccessRight()==0){%>
                <form action="RegisterHall" method="POST">
                    <h1>Register new Hall</h1>
                <table>
                     <tr>
                        <td>
                            Hall name:
                        </td>
                        <td>
                            <input type="text" name="name" size="20" required></td>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Description:
                        </td>
                        <td>
                            <textarea title="Description is mandatory for customer." rows="2" type="textarea"  name="description" size="20" required></textarea>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Number of pax(Estimated):
                        </td>
                        <td>
                            <input type="text" name="numberOfPax" size="20" required></td>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Daily Booking Price:
                        </td>
                        <td>
                            <input type="text" name="dailyPrice" size="20" required></td>
                        </td>
                    </tr>
                </table>
            <p><input type="submit" value="Register" class="btn btn-outline-primary"></p>
        </form>
                <%
                }
                else{
                    out.print("<script>alert('Access denied! Please login as admin.')</script>;");
                }
                %>
        </div>
        
    </body>
</html>
