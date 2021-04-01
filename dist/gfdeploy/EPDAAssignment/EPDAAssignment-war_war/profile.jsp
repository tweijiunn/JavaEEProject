

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
                String action = request.getParameter("action");
            %>
                <form action="updateProfile" id="profile">
                <h1>My Profile</h1>
            
                <table>
                     <tr>
                        <td>
                            Full Name:
                        </td>
                        <td>
                            <input disabled type="text" name="name" size="20" value="<% out.print(user.getName());%>" required></td>
                            <input type="hidden" name="id" size="20" value="<% out.print(user.getId());%>">
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Gender:
                        </td>
                        <td>
                            <input disabled type="text" name="gender" size="20" value="<% out.print(user.getGender());%>"></td>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Password:
                        </td>
                        <td>
                            <input disabled type="password" class="editable" name="password" size="20" pattern=".{8,}" title="Eight or more characters" value="<% out.print(user.getPassword());%>" required></td>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Contact Number:
                        </td>
                        <td>
                            <input disabled type="text" pattern="[0-9]{10,11}" title="Invalid Phone Number. (example: 012345678)" class="editable" name="contact" size="20" value="<% out.print(user.getContactNumber());%>" required></td>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Email:
                        </td>
                        <td>
                            <input disabled type="email" class="editable" name="email" size="20" pattern="[^@\s]+@[^@\s]+" title="Invalid email address" value="<% out.print(user.getEmail());%>" required></td>
                        </td>
                    </tr>
                </table>
            <p><input onclick="active()" type="button" value="Edit" class="edit btn btn-outline-secondary" ><input disabled type="submit" value="Confirm" class="editable btn btn-outline-primary"></p>
        </form>
        </div>
        
        <script type="text/javascript"> 
            function active(){
                $('#profile table tr td .editable').removeAttr("disabled");
                $('#profile p .editable').removeAttr("disabled");
                $('#profile p .edit').attr("disabled","disabled");
            }
        </script>
    </body>
</html>
