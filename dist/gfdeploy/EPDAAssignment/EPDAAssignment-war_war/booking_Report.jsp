
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
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
        <form action="AdminBooking" method="POST">
            <h1>Booking Management & Report</h1>
            <input type="text" name="search" size="20">
            <input type="hidden" name="cancel" class="button" >
            <input type="submit" class="btn btn-outline-secondary" value="search">
        </form>
        <table id="data">
            <tr>
                <th>
                    Booking ID
                </th>
                <th>
                    Booked By
                </th>
                <th>
                    Booking Date
                </th>
                <th>
                    Hall Name
                </th>
                <th>
                    Booking Price (RM)
                </th>
                <th>
                    Status
                </th>
                <th>
                    Action
                </th>
            </tr>
            <%
                ArrayList<ArrayList<String>> bookingList= (ArrayList<ArrayList<String>>)request.getAttribute("bookingList");
                DateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                Calendar cal = Calendar.getInstance();
                Date today = cal.getTime();

                    for(ArrayList<String> row: bookingList){
            %>
            <tr>
                <%
                    for(int i =0; i<row.size();i++){
                    %>
                    <td>
                        <%
                            out.print(row.get(i));
                        %>
                    </td>
                    <% 
                     if(i==row.size()-1){%>
                        <td>
                            <form action="AdminBooking" method="POST">
                                <input type="submit" class="btn btn-outline-danger" value="Cancel" <%out.println(row.get(row.size()-1).equals("Cancelled")||today.compareTo(sdf.parse(row.get(2)))>0?"Disabled":"");%>>
                                <input type="hidden" name="cancel" class="button"  value="<%out.print(row.get(0));%>">
                                <input type="hidden" name="search" class="button" >
                            </form>
                        </td>
                     <%}
                     
                    }
                %>    
            </tr>
            <%  }
            
            %>
        </table>
    </body>
</html>
