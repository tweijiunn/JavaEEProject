
<%@page import="model.Hall"%>
<%@page import="model.Users"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            .card{
                float:left;
                margin:10px;
                border-radius:20px;
                box-shadow: 0 0 6px 2px rgb(0 0 0 / 10%);
                transition: all .2s ease;
                border-bottom: 5px solid transparent;
                transition: 0.5s;
            }
            
            .card:hover{
                transform: scale(1.2);
                z-index: 9;
            }
            
            ul li{
                list-style: none;
                margin-left: -30px;
            }
            
            ul li:first-child{
                float:left;
            }
            
            ul li:last-child{
                float:right;
            }
            
            h1{
                text-align: center;
            }
        </style>
    </head>
    <body>
        <jsp:include page="nav.jsp"/>
        <br>
        <div class="container">
            <h1>Eventistry Hall</h1>
            <p>Our halls strategically fulfill every customer's needs for 
                different events and number of participants. 
                Contact our sales representative to make booking now!</p>
            <div class="grids-container">
            <%
                if(request.getAttribute("hallList")!=null){
                    List<Hall> halls = (List<Hall>)request.getAttribute("hallList");
                    if(halls!=null){
                    for(Hall hall: halls){
            %>
            
                <div class="card" style="width: 18rem;">
                    <div class="card-body">
                      <h5 class="card-title"><%out.print(hall.getHallName());%></h5>
                      <p class="card-text"><%out.print(hall.getHallDescription());%></p>
                      <ul>
                          <li><%out.print(hall.getHallSize()+" pax");%></li>
                          <li><%out.print("RM "+String.format("%.2f",hall.getHallDailyPrice()));%></li>
                      </ul>
                    </div>
                  </div>
            
            
            <%
                        }
                    }
                }
            %>
            </div>
        </div>
            
<!--            <input type="text" name="search" size="20">
            <input type="hidden" name="deactivate" class="button" >
            <input type="submit" class="btn btn-outline-secondary" value="search">-->
        
    </body>
</html>
