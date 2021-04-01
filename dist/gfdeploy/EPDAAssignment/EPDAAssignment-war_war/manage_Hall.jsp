
<%@page import="model.Hall"%>
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
            p#addHallButton{
                text-align:right; 
            }
            
            p#addHallButton a{
                margin-right:30px;
            }
        </style>
    </head>
    <body>
        <jsp:include page="nav.jsp"/>
        <br>
        <form action="ManageHall">
            <h1>Event Hall Management</h1>
            <input type="text" name="search" size="20">
            <input type="hidden" name="deactivate" class="button" >
            <input type="submit" class="btn btn-outline-secondary" value="search">
        </form>
        <p id="addHallButton"><a href="registerHall.jsp" class="btn btn-outline-secondary"> Add Hall</a></p>
        <table id="data">
            <tr>
                <th>
                    Hall ID
                </th>
                <th>
                    Hall Name
                </th>
                <th>
                    Description
                </th>
                <th>
                    Number of Pax(Estimated)
                </th>
                <th>
                    Daily Booking Price (RM)
                </th>
                <th>
                    Status
                </th>
                <th>
                    Action
                </th>
            </tr>
            <%
                List<Hall> halls = (List<Hall>)request.getAttribute("hallList");
                if(halls!=null){
                for(Hall hall: halls){
            %>
            <tr>
                    <td>
                        <%
                           out.print(hall.getId());
                        %>
                    </td>
                    <td>
                        <%
                           out.print(hall.getHallName());
                        %>
                    </td>
                    <td>
                        <%
                           out.print(hall.getHallDescription());
                        %>
                    </td>
                    <td>
                        <%
                           out.print(hall.getHallSize());
                        %>
                    </td>
                    <td>
                        <%
                           out.print(String.format( "%.2f",hall.getHallDailyPrice()));
                        %>
                    </td>
                    <td>
                        <%
                           out.print(hall.getStatus()==0?"Deactivated":"Active");
                        %>
                    </td>
                    <td>
                        <form action="ManageHall" method="POST">
                            <input type="submit" class="btn btn-outline-danger" value="Deactivate" <%out.println(hall.getStatus()==0?"Disabled":"");%>>
                            <input type="hidden" name="deactivate" class="button" value="<% out.print(hall.getId().toString());%>" >
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
