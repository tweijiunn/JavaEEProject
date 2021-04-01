
<%@page import="model.HallFacade"%>
<%@page import="model.Users"%>
<%@page import="controller.HallController"%>
<%@page import="model.Hall"%>
<%@page import="java.util.List"%>
<%@page import="java.util.List"%>
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
        <jsp:include page="nav.jsp"/>
        <div class="box-container">
            <h1>Add New Booking</h1>
            <form action="addBooking">
                <table>
                    <tr>
                        <td>
                            Customer:
                        </td>
                        <td>
                            <select id="customerOption" name="customerID">
                                <%
                                    List<Users> users = (List<Users>)request.getAttribute("userList");
                                    for (Users user : users)
                                    { 
                                        out.print("<option value='"+user.getId()+"'>("+user.getId()+") "+user.getName()+"</option>");
                                    }
                                %>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Date:
                        </td>
                        <td>
                            <input type="date" name="date" id="calendar">
                        </td>
                    </tr>
<!--                    <tr>
                        <td>
                            Event Hall:
                        </td>
                        <td>
                            <select id="hallOption" name="hallID">
                                //<%
                                 //   List<Hall> halls = (List<Hall>)request.getAttribute("hallList");
                                 //   for (Hall hall : halls)
                                 //   { 
                                 //       out.print("<option value='"+hall.getId()+"' price='"+hall.getHallDailyPrice()+"'>"+hall.getHallName()+"</option>");
                                 //   }
                               // %>
                            </select>
                        </td>
                    </tr>-->
                </table>
                <table>
                    <tr>
                        <td>
                            Available Hall:
                        </td>
                    </tr>
                    <tr id="availableHall">
                        <td>         
                        </td>
                        <td>
                        </td>
                    </tr>
                </table>
                <table>
                    <tr>
                        <td>
                            Payment
                        </td>
                        <td>
                            RM<span id="totalPrice">0.00</span>
                        </td>
                    </tr>            
                </table>
                <p><input type="submit" class="btn btn-outline-primary" value="Book"></p>
            </form>
        </div>
        
        
    </body>
    
    <script type="text/javascript">
        
        $(function(){
            var dtToday = new Date();

            var month = dtToday.getMonth() + 1;
            var day = dtToday.getDate();
            var year = dtToday.getFullYear();
            if(month < 10)
                month = '0' + month.toString();
            if(day < 10)
                day = '0' + day.toString();

            var maxDate = year + '-' + month + '-' + day;

            $('#calendar').attr('min', maxDate);
        });
        
        $(document).ready(function() {
            
                $('#calendar').change(function(event) {
                        var date = $('#calendar').val();
                        $.get('searchAvailableBooking', {
                                selectedDate : date
                        }, function(responseText) {
                                $('#availableHall').html(responseText);
                        });
                });
        });
    </script>
</html>
