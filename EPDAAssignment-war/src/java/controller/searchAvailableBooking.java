/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.stream.Collectors;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Booking;
import model.BookingFacade;
import model.Hall;
import model.HallFacade;

/**
 *
 * @author tweij
 */
@WebServlet(name = "searchAvailableBooking", urlPatterns = {"/searchAvailableBooking"})
public class searchAvailableBooking extends HttpServlet {

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
            throws ServletException, IOException, ParseException {
        response.setContentType("text/html;charset=UTF-8");
        
        //filter out the bookedSlot based on user selected date
        Date selectedDate = new SimpleDateFormat("yyyy-mm-dd").parse(request.getParameter("selectedDate"));
        List<Booking> bookedSlot = bookingFacade.findAll().stream().filter
            (booking -> booking.getDate().equals(selectedDate)).collect(Collectors.toList());
        List<Hall> availableHall = hallFacade.findAll().stream()
            .filter(hall -> bookedSlot.stream().anyMatch
                (booking -> !booking.getHallID().equals(hall.getId())))
            .collect(Collectors.toList());
        //get the result into string and return as response to AjaxRequest
        String data = null;
//        if(availableHall.size()==0){
//           data= hallFacade.findAll().stream().map(hall-> hall.getId()+hall.getHallName()).collect(Collectors.joining(","));
//        }else{
//           data= availableHall.stream().map(hall-> hall.getId()+hall.getHallName()).collect(Collectors.joining(","));
//
//        }
        if(availableHall.size()==0){
            for(Hall hall:hallFacade.findAll()){
                data+="<tr>\n" +
                      "  <td>\n" +
                            "<input type='radio' onclick='document.getElementById(\"totalPrice\").innerHTML="+hall.getHallDailyPrice()+"' id='"+hall.getId()+"' name='hallID' value='"+hall.getId()+"' price='"+hall.getHallDailyPrice()+"'>"+
                            hall.getHallName()+
                      "  </td>\n" +
                      " </tr>\n";
            }
        }
        else{
            for(Hall hall:availableHall){
                data+="<tr>\n" +
                      "  <td>\n" +
                            "<input type='radio' onclick='document.getElementById(\"totalPrice\").innerHTML="+hall.getHallDailyPrice()+"' id='"+hall.getId()+"' name='hallID' value='"+hall.getId()+"' price='"+hall.getHallDailyPrice()+"'>"+
                            hall.getHallName()+
                      "  </td>\n" +
                      " </tr>\n";
            }
        }
        
        
        
        response.setContentType("text/plain");
        response.getWriter().write(data);
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
        try {
            processRequest(request, response);
        } catch (ParseException ex) {
        }
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
        try {
            processRequest(request, response);
        } catch (ParseException ex) {
            
        }
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
