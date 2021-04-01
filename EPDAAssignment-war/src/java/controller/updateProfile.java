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
@WebServlet(name = "updateProfile", urlPatterns = {"/updateProfile"})
public class updateProfile extends HttpServlet {

    @EJB
    private UsersFacade usersFacade;
    
    

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
        if(!request.getParameter("id").isEmpty() && !request.getParameter("password").isEmpty()||!request.getParameter("email").isEmpty()||!request.getParameter("contact").isEmpty()){
            String id = request.getParameter("id");
            //String name= request.getParameter("name");
            //char gender = request.getParameter("gender").charAt(0);
            String password= request.getParameter("password");
            String contact= request.getParameter("contact");
            String email = request.getParameter("email");
            Users updateProfile= usersFacade.find(id);
            
            try (PrintWriter out = response.getWriter()) {
                /* TODO output your page here. You may use following sample code. */
               if(!updateProfile.getPassword().equals(password)||!updateProfile.getContactNumber().equals(contact)||!updateProfile.getEmail().equals(email)){
                   updateProfile.setPassword(password);
                   updateProfile.setContactNumber(contact);
                   updateProfile.setEmail(email);
                   usersFacade.edit(updateProfile);
                   out.println("<script>alert('Profile updated successfully!');</script>");
                   HttpSession s  = request.getSession();
                   s.setAttribute("login",updateProfile);
                   request.getRequestDispatcher("Statistic").include(request, response);
                }
                else{
                   out.println("<script>alert('No data updated!');</script>");
                   request.getRequestDispatcher("profile.jsp").include(request, response);
                }
            }
        }
        else{
            response.getWriter().write("<script>alert('Please fill in all the details!');</script>");
            request.getRequestDispatcher("profile.jsp").include(request, response);
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
