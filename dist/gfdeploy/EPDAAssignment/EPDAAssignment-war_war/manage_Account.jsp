
<%@page import="model.Users"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" type="text/css" href="css/main.css"/>
        <style>
            ul li{
                background-color:yellow;
                border: 3px black;
                padding:10px;
                list-style: none;
                float:left;
            }

            ul li a{
                color:black;
                text-decoration:none;
            }
        </style>
    </head>
    <body>
        <jsp:include page="nav.jsp"/>
        <br>
        <form action="ManageAccount">
            <h1>Account Management</h1>
            <input type="text" name="search" size="20">
            <input type="hidden" name="deactivate" class="button" >
            <input type="submit" class="btn btn-outline-secondary" value="search">
        </form>
        <table id="data">
            <tr>
                <th>
                    Account ID
                </th>
                <th>
                    Account Name
                </th>
                <th>
                    Account Gender
                </th>
                <th>
                    Account Contact
                </th>
                <th>
                    Account Email
                </th>
                <th>
                    Status
                </th>
                <th>
                    Action
                </th>
            </tr>
            <%
                List<Users> users = (List<Users>)request.getAttribute("userSearch");
                if(users!=null){
                for(Users user: users){
            %>
            <tr>
                    <td>
                        <%
                           out.println(user.getId());
                        %>
                    </td>
                    <td>
                        <%
                           out.println(user.getName());
                        %>
                    </td>
                    <td>
                        <%
                           out.println(user.getGender());
                        %>
                    </td>
                    <td>
                        <%
                           out.println(user.getContactNumber());
                        %>
                    </td>
                    <td>
                        <%
                           out.println(user.getEmail());
                        %>
                    </td>
                    <td>
                        <%
                           out.println(user.getAccessRight()!=0&&user.getAccessRight()!=1&&user.getAccessRight()!=2?"Deactivated":"Active");
                        %>
                    </td>
                    <td>
                        <form action="ManageAccount" method="POST">
                            <input type="submit" class="btn btn-outline-danger" value="Deactivate" <%out.println(user.getAccessRight()!=0&&user.getAccessRight()!=1&&user.getAccessRight()!=2?"Disabled":"");%>>
                            <input type="hidden" name="deactivate" class="button" value="<% out.print(user.getId().toString());%>" >
                            <input type="hidden" name="search" class="button" >
                        </form>
                    </td>
            </tr>
            <%  }
            }
            %>
        </table>
    </body>
</html>
