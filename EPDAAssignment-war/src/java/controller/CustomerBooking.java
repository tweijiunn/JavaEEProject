/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Booking;
import model.BookingFacade;
import model.FeedbackFacade;
import model.Hall;
import model.HallFacade;
import model.Users;

/**
 *
 * @author tweij
 */
@WebServlet(name = "CustomerBooking", urlPatterns = {"/CustomerBooking"})
public class CustomerBooking extends HttpServlet {

    @EJB
    private FeedbackFacade feedbackFacade;

    @EJB
    private HallFacade hallFacade;

    @EJB
    private BookingFacade bookingFacade;
    
    

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
        
        HttpSession s = request.getSession(false);
        Users customer= (Users)s.getAttribute("login");
        
//        filter the booking list for only specific customer
        List<Booking> bookingList = bookingFacade.findAll().stream().filter(booking-> booking.getUserID().equals(customer.getId())).collect(Collectors.toList());
        ArrayList<ArrayList<String>> collections = new ArrayList<ArrayList<String>>();
        
//        store into array of array list
        for(Booking booking:bookingList){
            boolean feedbackExist = feedbackFacade.findAll().stream().anyMatch(feedback -> feedback.getBookingID().equals(booking.getId()));
            ArrayList<String> singleRow = new ArrayList<String>();
            String hallID= booking.getHallID();
            Hall hallDetails = hallFacade.find(hallID);
            singleRow.add(booking.getId());
            
//          date format here
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-mm-dd");
            Date date = booking.getDate();
            singleRow.add(dateFormat.format(date));
            singleRow.add(hallDetails.getHallName());
            singleRow.add(String.format( "%.2f",hallDetails.getHallDailyPrice()).toString());
            singleRow.add(booking.getStatus()==0?"Cancelled":"Completed");
            singleRow.add(feedbackExist?"true":"false");
            collections.add(singleRow);
        }
        
        request.setAttribute("bookingList", collections);
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            request.getRequestDispatcher("cus_booking.jsp").include(request, response);
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
