<%@page import="model.Users"%>
<%
    if (session.getAttribute("login") == null) {
          response.sendRedirect(request.getContextPath()+"/login.jsp");
     }
    Users user=(Users)session.getAttribute("login");
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script type='text/javascript'>
            function invokeBookingServlet()
            {
               // form a URL with the servlet name to be invoked
               var URL = 'http://localhost:8080/EPDAAssignment-war/HallController';

               // This line will inkove a servlet and reload your page
               location.href = URL;
            }
            
            function invokeManageAccountServlet()
            {
               // form a URL with the servlet name to be invoked
               var URL = 'http://localhost:8080/EPDAAssignment-war/ManageAccount?search=all&deactivate=';

               // This line will inkove a servlet and reload your page
               location.href = URL;
            }
            
            function invokeAdminBookingServlet()
            {
               // form a URL with the servlet name to be invoked
               var URL = 'http://localhost:8080/EPDAAssignment-war/AdminBooking?search=all&cancel=';

               // This line will inkove a servlet and reload your page
               location.href = URL;
            }
            
            function invokeSalesManageAccountServlet()
            {
               // form a URL with the servlet name to be invoked
               var URL = 'http://localhost:8080/EPDAAssignment-war/SalesManageAccount?search=all&deactivate=';

               // This line will inkove a servlet and reload your page
               location.href = URL;
            }
            
            function invokeCustomerBookingServlet()
            {
               // form a URL with the servlet name to be invoked
               var URL = 'http://localhost:8080/EPDAAssignment-war/CustomerBooking';

               // This line will inkove a servlet and reload your page
               location.href = URL;
            }
            
            function invokeStatisticServlet()
            {
               // form a URL with the servlet name to be invoked
               var URL = 'http://localhost:8080/EPDAAssignment-war/Statistic';

               // This line will inkove a servlet and reload your page
               location.href = URL;
            }
            
            function invokeSalesManageFeedbackServlet()
            {
               // form a URL with the servlet name to be invoked
               var URL = 'http://localhost:8080/EPDAAssignment-war/SalesManageFeedback';

               // This line will inkove a servlet and reload your page
               location.href = URL;
            }
            
            function invokeManageHallServlet()
            {
               // form a URL with the servlet name to be invoked
               var URL = 'http://localhost:8080/EPDAAssignment-war/ManageHall?search=all&deactivate=';

               // This line will inkove a servlet and reload your page
               location.href = URL;
            }
            
            function invokeCustomerViewHallServlet()
            {
               // form a URL with the servlet name to be invoked
               var URL = 'http://localhost:8080/EPDAAssignment-war/CustomerViewHall';

               // This line will inkove a servlet and reload your page
               location.href = URL;
            }
        </script>
    </head>
    <body>
        <jsp:include page="header.jsp"/>
       
        <div class="navbar">
            <a href="#" onclick="invokeStatisticServlet()">Dashboard</a>
         <%
        if (user.getAccessRight()==0) { %>
            <a href="profile.jsp">My Profile</a> 
            <a href="register.jsp?action=0">New Staff</a> 
            <a href="register.jsp?action=1">New Salesman</a> 
            <a href="#" onclick="invokeManageHallServlet()">Manage Event Hall</a> 
            <a href="#" onclick="invokeManageAccountServlet()">Manage Account</a> 
            <a href="#" onclick="invokeAdminBookingServlet()">View Booking Report</a> 
            <a href="Logout">Logout</a>
            
        <%}
        else if(user.getAccessRight()==1){%>

            <a href="profile.jsp">My Profile</a> 
            <a href="register.jsp">New Customer</a> 
            <a href="#" onclick="invokeBookingServlet()">New Booking</a> 
            <a href="#" onclick="invokeSalesManageAccountServlet()">My Customer</a> 
            <a href="#" onclick="invokeSalesManageFeedbackServlet()">View Feedback</a>
            <a href="Logout">Logout</a>

        <%}
        else if(user.getAccessRight()==2){%>

            <a href="profile.jsp">My Profile</a> 
            <a href="#" onclick="invokeCustomerBookingServlet()">Check My Booking</a> 
            <a href="#" onclick="invokeCustomerViewHallServlet()">Find out Halls</a> 
            <a href="Logout">Logout</a>

        <%}
        else{
            out.println("<script language='javascript'>window.alert('Your account is deactivated. Please contact staff for further assistance!');window.location='"+request.getContextPath()+"/login.jsp';</script>");
            session.invalidate(); 

        }
        %>
        
        
        <%
            if(user!=null){
                %>
                <span id="welcome">Welcome, <%out.print(user.getName());%> !</span> 
                
            <%}
        %>
                </div> 
    </body>
</html>
