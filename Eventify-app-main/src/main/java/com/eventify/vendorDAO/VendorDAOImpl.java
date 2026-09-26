package com.eventify.vendorDAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.eventify.Utility.DBConnection;
import com.eventify.model.Vendor;

public class VendorDAOImpl implements VendorDAO {

    private Connection con;

    public VendorDAOImpl() {
        con = DBConnection.getConnection();
    }

    @Override
    public List<Vendor> getApprovedVendors() {
        List<Vendor> vendorsList = new ArrayList<>();
        String query = "SELECT * FROM vendors WHERE approval_status = 'APPROVED' ORDER BY rating DESC";
        Vendor v = null;

        try {
            PreparedStatement ps = con.prepareStatement(query);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                v = new Vendor();
                v.setVendorId(rs.getInt("vendor_id"));
                v.setVendorName(rs.getString("vendor_name"));
                v.setCategory(rs.getString("category"));
                v.setDescription(rs.getString("description"));
                v.setPrice(rs.getDouble("price"));
                v.setRating(rs.getDouble("rating"));
                v.setApprovalStatus(rs.getString("approval_status"));
                v.setContactEmail(rs.getString("contact_email"));
                v.setContactPhone(rs.getString("contact_phone"));  // ✅ getString instead of getInt
                vendorsList.add(v);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return vendorsList;
    }

    @Override
    public List<Vendor> getVendorsByIds(Integer[] vendorIds) {
        List<Vendor> vendorsList = new ArrayList<>();

        if (vendorIds == null || vendorIds.length == 0) {
            return vendorsList;
        }

        StringBuilder query = new StringBuilder("SELECT * FROM vendors WHERE vendor_id IN (");
        for (int i = 0; i < vendorIds.length; i++) {
            query.append(i == 0 ? "?" : ", ?");
        }
        query.append(")");
        Vendor v = null;

        try {
            PreparedStatement ps = con.prepareStatement(query.toString());

            for (int i = 0; i < vendorIds.length; i++) {
                ps.setInt(i + 1, vendorIds[i]);
            }

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                v = new Vendor();
                v.setVendorId(rs.getInt("vendor_id"));
                v.setVendorName(rs.getString("vendor_name"));
                v.setCategory(rs.getString("category"));
                v.setDescription(rs.getString("description"));
                v.setPrice(rs.getDouble("price"));
                v.setRating(rs.getDouble("rating"));
                v.setApprovalStatus(rs.getString("approval_status"));
                v.setContactEmail(rs.getString("contact_email"));
                v.setContactPhone(rs.getString("contact_phone"));  // ✅ getString instead of getInt
                vendorsList.add(v);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return vendorsList;
    }

    @Override
    public List<Vendor> getAllVendors(String filterStatus) {
        List<Vendor> vendorsList = new ArrayList<>();

        String query = "SELECT * FROM vendors";
        if (filterStatus != null && !filterStatus.equals("all")) {
            query += " WHERE approval_status = ?";
        }
        query += " ORDER BY created_at DESC";

        Vendor v = null;

        try {
            PreparedStatement ps = con.prepareStatement(query);

            if (filterStatus != null && !filterStatus.equals("all")) {
                ps.setString(1, filterStatus);
            }

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                v = new Vendor();
                v.setVendorId(rs.getInt("vendor_id"));
                v.setVendorName(rs.getString("vendor_name"));
                v.setCategory(rs.getString("category"));
                v.setDescription(rs.getString("description"));
                v.setPrice(rs.getDouble("price"));
                v.setRating(rs.getDouble("rating"));
                v.setApprovalStatus(rs.getString("approval_status"));
                v.setContactEmail(rs.getString("contact_email"));
                v.setContactPhone(rs.getString("contact_phone"));  // ✅ getString instead of getInt
                vendorsList.add(v);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return vendorsList;
    }

    @Override
    public Boolean addVendor(Vendor v) {
        String query = "INSERT INTO vendors (vendor_name, category, description, price, contact_email, contact_phone, approval_status) VALUES (?,?,?,?,?,?,'APPROVED')";
        Integer i = 0;
        try {
            PreparedStatement ps = con.prepareStatement(query);

            ps.setString(1, v.getVendorName());
            ps.setString(2, v.getCategory());
            ps.setString(3, v.getDescription());
            ps.setDouble(4, v.getPrice());
            ps.setString(5, v.getContactEmail());
            ps.setString(6, v.getContactPhone());  // ✅ setString instead of setInt
            i = ps.executeUpdate();

            if (i > 0) {
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public Boolean updateApprovalStatus(Integer vendorId, String status) {
        String query = "UPDATE vendors SET approval_status = ? WHERE vendor_id = ?";
        Integer i = 0;
        try {
            PreparedStatement ps = con.prepareStatement(query);

            ps.setString(1, status);
            ps.setInt(2, vendorId);

            i = ps.executeUpdate();

            if (i > 0) {
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public Boolean deleteVendor(Integer vendorId) {
        String query = "DELETE FROM vendors WHERE vendor_id = ?";
        Integer i = 0;
        try {
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, vendorId);

            i = ps.executeUpdate();

            if (i > 0) {
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public Integer getTotalVendors() {
        String query = "SELECT COUNT(*) FROM vendors";

        try {
            PreparedStatement ps = con.prepareStatement(query);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    @Override
    public Integer getPendingVendors() {
        String query = "SELECT COUNT(*) FROM vendors WHERE approval_status = 'PENDING'";

        try {
            PreparedStatement ps = con.prepareStatement(query);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
}