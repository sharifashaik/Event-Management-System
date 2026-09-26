package com.eventify.bookingDAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.eventify.Utility.DBConnection;

public class BookingDAOImpl implements BookingDAO {

	private Connection con;
	public BookingDAOImpl() {
		con=DBConnection.getConnection();
	}

	@Override
	public Boolean createBookings(Integer eventId, Integer[] vendorIds) {
		
		String query = "INSERT INTO bookings (event_id, vendor_id) VALUES (?, ?)";
		
		try {
			PreparedStatement ps = con.prepareStatement(query);
			
			for(Integer vendorId: vendorIds) {
				ps.setInt(1, eventId);
                ps.setInt(2, vendorId);
                ps.addBatch();
			}
			
			ps.executeBatch(); // execute all at once
            return true;
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return false;
	}

}
