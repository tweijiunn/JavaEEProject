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
import model.Hall;
import model.HallFacade;

/**
 *
 * @author tweij
 */
@WebServlet(name = "ManageHall", urlPatterns = {"/ManageHall"})
public class ManageHall extends HttpServlet {

    @EJB
    private HallFacade hallFacade;

    
    
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
        
        //this is only for deactivated button
        if(!request.getParameter("deactivate").isEmpty()){
            Hall deactivatedHall = hallFacade.find(request.getParameter("deactivate"));
            deactivatedHall.setStatus(0);
            hallFacade.edit(deactivatedHall);
        }
        
        //this section is for searching function
        String keyword= request.getParameter("search");
        //by default fetch all
        List<Hall> halls=hallFacade.findAll();
        //if detect keywords other than "all", run the search query
        if(!keyword.equalsIgnoreCase("all")) {
            //response.getWriter().write("<script>alert('"+keyword+"');</script>"); 
            halls=hallFacade.findAll().stream()
                    .filter(hall -> 
                               hall.getId().contains(keyword)
                            || hall.getHallName().contains(keyword)
                            || hall.getHallDescription().contains(keyword)
                            || hall.getHallSize().contains(keyword)
                            || (hall.getStatus()==1?"Active".contains(keyword):"Deactivated".contains(keyword))
                            || hall.getHallDailyPrice().toString().equals(keyword))
                    .collect(Collectors.toList());
        }
        
        //update the result list
        request.setAttribute("hallList", halls);
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            request.getRequestDispatcher("manage_Hall.jsp").include(request, response);
                
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
