/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.stream.Collectors;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.BookingFacade;
import model.Feedback;
import model.FeedbackFacade;
import model.Users;
import model.UsersFacade;

/**
 *
 * @author tweij
 */
@WebServlet(name = "SalesManageFeedback", urlPatterns = {"/SalesManageFeedback"})
public class SalesManageFeedback extends HttpServlet {

    @EJB
    private BookingFacade bookingFacade;

    @EJB
    private FeedbackFacade feedbackFacade;

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
        
        //get the current sales representative data
        HttpSession session  = request.getSession();
        Users user=(Users)session.getAttribute("login");
        
        //by default fetch all
        List<Feedback> feedbacks=feedbackFacade.findAll()
                .stream()
                .filter(feedback -> bookingFacade
                                    .findAll()
                                    .stream()
                                    .anyMatch(booking-> (booking.getId().equals(feedback.getBookingID()))
                                                        && usersFacade
                                                                .findAll()
                                                                .stream()
                                                                .anyMatch(user1 -> user1.getId().equals(booking.getUserID())
                                                                                    && user1.getInChargeBy()!=null?user1.getInChargeBy().equals(user.getId()):false))
                )
                .collect(Collectors.toList());
        
        //update the result list
        request.setAttribute("feedbacks", feedbacks);
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            request.getRequestDispatcher("sales_Manage_Feedback.jsp").include(request, response);
                
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
