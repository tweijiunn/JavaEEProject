/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.Array;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
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
import model.UsersFacade;
import org.json.simple.JSONObject;

/**
 *
 * @author tweij
 */
@WebServlet(name = "Statistic", urlPatterns = {"/Statistic"})
public class Statistic extends HttpServlet {

    @EJB
    private FeedbackFacade feedbackFacade;

    @EJB
    private UsersFacade usersFacade;

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
        
        HttpSession session  = request.getSession();
        Users user=(Users)session.getAttribute("login");
        
        JSONObject json = new JSONObject();
        Map<Integer,Map<String,String>> totalOfHallBooking = new HashMap<Integer,Map<String,String>>();
        List<Hall> halls = hallFacade.findAll();
        List<Booking> bookings= bookingFacade.findAll();
        
        //managing staff statistics
        if(user.getAccessRight()==0){
            //calculate total booking per hall
            for(int i =0; i<halls.size();i++){
                String hallName = halls.get(i).getHallName();
                String id= halls.get(i).getId();
                Map<String,String> hallBooking= new HashMap<String,String>();
                long numberOfBooking = bookings
                        .stream()
                        .filter(booking -> booking.getHallID().equals(id)).count();
                hallBooking.put("hallName",hallName);
                hallBooking.put("numberOfBooking",String.valueOf(numberOfBooking));
                totalOfHallBooking.put(i, hallBooking);
            }
            json.putAll(totalOfHallBooking);
            request.setAttribute("totalOfHallBooking",json);
            
            //calculate overall total booking
            int totalBooking= bookings.size();
            request.setAttribute("totalBooking",totalBooking);
            
            //calculate overall total user
            int totalUser= usersFacade.findAll().size();
            request.setAttribute("totalUser",totalUser);
            
            //calculate overall total feeback
            int totalFeedback= feedbackFacade.findAll().size();
            request.setAttribute("totalFeedback",totalFeedback);
        }
        //sales representative statistics
        else if(user.getAccessRight()==1){
            
            //calculate total booking per hall
            for(int i =0; i<halls.size();i++){
                String hallName = halls.get(i).getHallName();
                String id= halls.get(i).getId();
                Map<String,String> hallBooking= new HashMap<String,String>();
                long numberOfBooking = bookings
                        .stream()
                        .filter(booking -> booking.getHallID().equals(id)
                                            && usersFacade
                                                    .findAll()
                                                    .stream()
                                                    .anyMatch(user1 -> user1.getId().equals(booking.getUserID())
                                                                        && user1.getInChargeBy().equals(user.getId()))
                        ).count();
                                            
                hallBooking.put("hallName",hallName);
                hallBooking.put("numberOfBooking",String.valueOf(numberOfBooking));
                totalOfHallBooking.put(i, hallBooking);
            }
            json.putAll(totalOfHallBooking);
            request.setAttribute("totalOfHallBooking",json);
            
            //calculate overall total booking for a specific sales person
            long totalBooking= bookings
                                    .stream()
                                    .filter(booking -> usersFacade
                                                                    .findAll()
                                                                    .stream()
                                                                    .anyMatch(user1 -> user1.getId().equals(booking.getUserID())
                                                                        && user1.getInChargeBy().equals(user.getId())))
                                    .count();
            
            request.setAttribute("totalBooking",totalBooking);
//            
//            //calculate overall total user for a specific sales person
            long totalUser= usersFacade
                                    .findAll()
                                    .stream()
                                    .filter(user1 -> user1.getInChargeBy()!=null?user1.getInChargeBy().equals(user.getId()):false)
                                    .count();
            request.setAttribute("totalUser",totalUser);
//            
//            //calculate overall total feeback for a specific sales person
            long totalFeedback= feedbackFacade.findAll()
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
                                            .count();
            request.setAttribute("totalFeedback",totalFeedback);
        }
        //customer statistics
        else if(user.getAccessRight()==2){
            
            //calculate total booking per hall
            for(int i =0; i<halls.size();i++){
                String hallName = halls.get(i).getHallName();
                String id= halls.get(i).getId();
                Map<String,String> hallBooking= new HashMap<String,String>();
                long numberOfBooking = bookings
                        .stream()
                        .filter(booking -> booking.getHallID().equals(id)
                                            && user.getId().equals(booking.getUserID())
                        ).count();
                                            
                hallBooking.put("hallName",hallName);
                hallBooking.put("numberOfBooking",String.valueOf(numberOfBooking));
                totalOfHallBooking.put(i, hallBooking);
            }
            json.putAll(totalOfHallBooking);
            request.setAttribute("totalOfHallBooking",json);
            
//            //calculate overall total booking for a specific customer
            long totalBooking= bookings
                                    .stream()
                                    .filter(booking -> booking.getUserID().equals(user.getId()))
                                    .count();
            
            request.setAttribute("totalBooking",totalBooking);
//            
//            //calculate overall total amount spent for a customer
            Double totalExpenses = bookings
                                        .stream()
                                        .mapToDouble(booking -> booking.getUserID().equals(user.getId())
                                                                ? hallFacade.find(booking.getHallID()).getHallDailyPrice()
                                                                : 0.0
                                                    )
                                        .sum();
           
            request.setAttribute("totalExpenses",totalExpenses);
//            
////            //calculate overall total feeback for a specific customer
            long totalFeedback= feedbackFacade.findAll()
                                            .stream()
                                            .filter(feedback -> bookingFacade
                                                                .findAll()
                                                                .stream()
                                                                .anyMatch(booking-> (booking.getId().equals(feedback.getBookingID()))
                                                                                    && booking.getUserID().equals(user.getId()))
                                            )
                                            .count();
            request.setAttribute("totalFeedback",totalFeedback);
        }
        
        request.getRequestDispatcher("home.jsp").include(request,response);
  
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
