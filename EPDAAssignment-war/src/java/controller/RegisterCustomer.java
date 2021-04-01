/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Users;
import model.UsersFacade;

/**
 *
 * @author tweij
 */
@WebServlet(name = "RegisterCustomer", urlPatterns = {"/RegisterCustomer"})
public class RegisterCustomer extends HttpServlet {

    @EJB
    private UsersFacade userFacade;

    
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String name= request.getParameter("name");
        String username= request.getParameter("username");
        String password= request.getParameter("password");
        char gender= request.getParameter("gender").toUpperCase().charAt(0);
        String contact= request.getParameter("contact");
        String email= request.getParameter("email");
        int accessRight=2;
        HttpSession session  = request.getSession();
        Users salesPerson=(Users)session.getAttribute("login");
        String inChargeBy = salesPerson.getId();
        
        boolean usernameExist = userFacade.findAll().stream().anyMatch(user1 -> user1.getUsername().equals(username));

        if(!usernameExist){
            Users newCustomer= new Users(name,username,password,contact,gender,email,accessRight,inChargeBy);
            userFacade.create(newCustomer);
            
            try (PrintWriter out = response.getWriter()) {
                /* TODO output your page here. You may use following sample code. */
                out.println("<script>alert('Registration is completed!');</script>");
                request.getRequestDispatcher("Statistic").include(request,response);
            }
        }
        else{
            try (PrintWriter out = response.getWriter()) {
                /* TODO output your page here. You may use following sample code. */
                out.println("<script>alert('The username has been used.');</script>");
                request.getRequestDispatcher("register.jsp").include(request,response);
            }
        }
        
        
        
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
