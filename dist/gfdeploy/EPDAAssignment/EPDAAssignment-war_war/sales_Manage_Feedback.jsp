
<%@page import="model.Feedback"%>
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
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <style>
            .checked {
                color: orange;
              }
        </style>
    </head>
    <body>
        <jsp:include page="nav.jsp"/>
        <br>
        <h1>My Customer Feedback</h1>
        <table id="data">
            <tr>
                <th>
                    Feedback ID
                </th>
                <th>
                    Booking ID
                </th>
                <th>
                    Feedback
                </th>
                <th>
                    Rating
                </th>
            </tr>
            <%
                List<Feedback> feedbacks = (List<Feedback>)request.getAttribute("feedbacks");
                if(feedbacks!=null){
                for(Feedback feedback: feedbacks){
            %>
            <tr>
                    <td>
                        <%
                           out.print(feedback.getId());
                        %>
                    </td>
                    <td>
                        <%
                           out.print(feedback.getBookingID());
                        %>
                    </td>
                    <td>
                        <%
                           out.print(feedback.getFeedback());
                        %>
                    </td>
                    <td>
                        <%
                           
                           for(int i=1;i<=feedback.getRating();i++){%>
                           <span class="fa fa-star checked"></span>
                        <%
                           }
                           for(int i=1;i<=(5-feedback.getRating());i++){%>
                           <span class="fa fa-star"></span>
                        <%
                            }
                        %>
                    </td>

            </tr>
            <%  }
            }
            %>
        </table>
    </body>
</html>
