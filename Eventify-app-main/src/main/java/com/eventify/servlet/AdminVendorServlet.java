package com.eventify.servlet;

import java.io.IOException;
import java.util.List;

import com.eventify.model.Vendor;
import com.eventify.vendorDAO.VendorDAO;
import com.eventify.vendorDAO.VendorDAOImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

//PURPOSE: Admin can view, approve, reject, add, delete vendors
//FLOW: admin clicks Manage Vendors → AdminVendorServlet → manage-vendors.jsp

@WebServlet("/AdminVendorServlet")
public class AdminVendorServlet extends HttpServlet {
	
	private VendorDAO vendorDAO = new VendorDAOImpl();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		HttpSession session = req.getSession(false);
        if (session == null || !"ADMIN".equals(session.getAttribute("role"))) {
            resp.sendRedirect("login.jsp");
            return;
        }

        String filter = req.getParameter("filter"); // "all", "PENDING", "APPROVED", "REJECTED"
        List<Vendor> vendors = vendorDAO.getAllVendors(filter);
        req.setAttribute("vendors", vendors);
        req.getRequestDispatcher("manage-vendors.jsp").forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		HttpSession session = req.getSession(false);
        if (session == null || !"ADMIN".equals(session.getAttribute("role"))) {
            resp.sendRedirect("login.jsp");
            return;
        }

        String action = req.getParameter("action");

        if ("approve".equals(action)) {
            int vendorId = Integer.parseInt(req.getParameter("vendorId"));
            vendorDAO.updateApprovalStatus(vendorId, "APPROVED");

        } else if ("reject".equals(action)) {
            int vendorId = Integer.parseInt(req.getParameter("vendorId"));
            vendorDAO.updateApprovalStatus(vendorId, "REJECTED");

        } else if ("delete".equals(action)) {
            int vendorId = Integer.parseInt(req.getParameter("vendorId"));
            vendorDAO.deleteVendor(vendorId);

        } else if ("add".equals(action)) {
            Vendor v = new Vendor();
            v.setVendorName(req.getParameter("vendorName"));
            v.setCategory(req.getParameter("category"));
            v.setDescription(req.getParameter("description"));
            v.setPrice(Double.parseDouble(req.getParameter("price")));
            v.setContactEmail(req.getParameter("contactEmail"));
            v.setContactPhone(req.getParameter("contactPhone"));
            vendorDAO.addVendor(v);
        }

        resp.sendRedirect("AdminVendorServlet?action=list");
	}


}
