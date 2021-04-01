
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="model.Booking"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" type="text/css" href="css/main.css"/>
        <style>
            /* The popup form - hidden by default */
            .form-popup {
              display: block;
              bottom: 0;
              right: 15px;
              z-index: 9;
            }

            /* Add styles to the form container */
            .form-container {
              max-width: 300px;
              padding: 30px;
              background-color: white;
              position: absolute;
              top: 30%;
              left: 40%;
              border-radius: 10px;
            }
            
            
            
            .form-container label,.form-container input, .form-container textarea{
                width: 100%;
                text-align: left;
                margin: 5px;
                resize: none;
            }
            
            .form-container input[type=submit],.form-container input[type=button]{
                text-align: center;
            }
            
            #overlay{
                display: none;
                width: 100%;
                height: 100%;
                position: absolute;
                top: 0;
                background-color: rgba(0, 0, 0, 0.3);
            }
            td{
                max-width: 100px;
            }
        </style>
    </head>
    <body>
        <jsp:include page="nav.jsp"/>
        <br>
        <h1>My Booking</h1>
        <table id="data">
            <tr>
                <th>
                    Booking ID
                </th>
                <th>
                    Booking Date
                </th>
                <th>
                    Hall Name
                </th>
                <th>
                    Booking Price
                </th>
                <th>
                    Booking Status
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
                    for(int i =0; i<row.size()-1;i++){
                    %>
                    <td>
                        <%
                            out.println(row.get(i));
                        %>
                    </td>
                    <% 
                     if(i==row.size()-2){%>
                        <td>
                            <input type="button" onclick="openForm('<%out.print(row.get(0));%>')" class="btn btn-warning" value="Make Feedback" <%out.println(row.get(row.size()-1).equals("true")||row.get(row.size()-2).equals("Cancelled")||today.compareTo(sdf.parse(row.get(1)))<0?"Disabled":"");%>>
                            
                        </td>
                     <%}
                    }
                %>
            </tr>
            <%  }
            %>
        </table>
        
        <div id="overlay">
            <div class="form-popup" id="myForm">
                <form action="SubmitFeedback" class="form-container" method="POST">
                  <h1>Submit Feedback</h1>
                  <table>
                      <tr>
                          <input type="hidden" id="bookingID" name="bookingID" value="">
                          <label>Feedback:</label>
                      </tr>
                      <tr>
                      <textarea  required title="Your feedback is valuable for us." rows="2" type="textarea" name="feedback" placeholder="Please insert you feedback here!"></textarea>
                      </tr>
                      <tr>
                           <label>Rating:</label>
                      </tr>
                      <tr>
                          <input type="range" name="rating"  min="0" max="5" placeholder="How would you rate our hall?">
                      </tr>
                      <tr>
                        <input type="submit" value="Submit" class="btn btn-primary btn-lg btn-block">
                        <input type="button" onclick="closeForm()" value="Cancel" class="btn btn-light btn-lg btn-block">
                      </tr>
                  </table>
                </form>
              </div>
        </div>
    </body>
    
<script>
    function openForm(bookingID) {
      document.getElementById("overlay").style.display = "block";
      document.getElementById("bookingID").value=bookingID;
    }

    function closeForm() {
      document.getElementById("overlay").style.display = "none";
    }
</script>
</html>
