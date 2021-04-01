
<%@page import="model.Users"%>
<%@page import="java.util.List"%>
<%@page import="model.Booking"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script src="http://d3js.org/d3.v3.min.js"></script>
        <style>
            .barChart{
               height: 500px;
               width: 100%;
               padding: 20px;
            }
            .bar {
                fill: #0080FF;
              }
              
              .bar:hover{
                transition:1s;
                fill: red;
              }
              h3{
                  text-align: center;
              }
              svg{
                  height:500px;
              }
              
              #chart1,#totalBooking,#totalUser,#totalFeedback{
                padding: 20px 50px 10px 20px;
                margin: 20px 30px 0px 30px;  
                box-shadow: 0 0 6px 2px rgba(0,0,0,.1);
                transition: all .2s ease;
                border-bottom: 5px solid transparent;   
                /* Chrome 10-25, Safari 5.1-6 */
                background: -webkit-linear-gradient(to left, rgba(230, 233, 240, 1), rgba(238, 241, 245, 1));
                /* W3C, IE 10+/ Edge, Firefox 16+, Chrome 26+, Opera 12+, Safari 7+ */
                background: linear-gradient(to left, rgba(230, 233, 240, 1), rgba(238, 241, 245, 1));   
                border-radius: 20px;
                border-radius: 10px;
              }
              
              p.dashboard-data{
                  text-align: center;
                  font-size: 50px;
                  color: green;
              }
              text{
                  font-size: 10px;
              }
        </style>
    </head>
    <body>
        <%
            Users user=(Users)session.getAttribute("login");
        %>
        <div class="container">
            <div class="barChart">
                <div class="row">
                    <div class="col" id="chart1">
                     
                    </div>
                    <div class="col" id="chart2">
                        <div id="totalBooking">
                                    <h3>Total Booking</h3>
                                    <p class="dashboard-data"><%out.print(request.getAttribute("totalBooking"));%></p>    
                        </div>
                        <div id="totalUser">
                                    <h3><% out.print(user.getAccessRight()!=2 ? "Total User" : "Total Amount Spent"); %></h3>
                                    <p class="dashboard-data"><% out.print(user.getAccessRight()!=2 ? request.getAttribute("totalUser") : "RM "+String.format( "%.2f",request.getAttribute("totalExpenses"))); %></p>    
                        </div>
                        <div id="totalFeedback">
                                    <h3>Total Feedback</h3>
                                    <p class="dashboard-data"><%out.print(request.getAttribute("totalFeedback"));%></p>    
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        
        <script>           
            var svg_height = 500, 
            svg_width = 1000;

            // Set the size of the svg through D3
            var svg = d3.select('.vertical-bars').attr('height', svg_height).attr('width', svg_width);
            var scale = d3.scale.linear().domain([0,10]).range([0, svg_height]);
            //var dataArray = [23, 13, 21, 14, 37, 15, 18, 34, 30];
            var jsonHallBooking= <%out.print(request.getAttribute("totalOfHallBooking"));%>;
            let data =Object.keys(jsonHallBooking).map(record => jsonHallBooking[record]);
            //
            d3.select("#chart1").append("h3").text("Hall Booking");
            var chart = d3.select("#chart1").append("svg")
                      .attr("height","100%")
                      .attr("width","100%");

            chart.selectAll('rect')
                .data(data)
                .enter()
                .append('rect')
                .attr("class", "bar")
                .attr('y', function(d) {
                  return svg_height - scale(d.numberOfBooking);
                })
                .attr('x', function(d, i) { return i * 100 })
                .attr('width', 70)
                .attr('height', function(d) { 
                  return scale(d.numberOfBooking);
                });
            
            chart.selectAll("text")
                .data(data)
                .enter().append("text")
                .text(function(d,i) {return d.hallName+"("+d.numberOfBooking+")";})
                    .attr('y', function(d) {
                        return svg_height - scale(d.numberOfBooking)-10;
                    })
                    .attr('x', function(d, i) { return i *100 });

        
        </script>
    </body>
</html>
