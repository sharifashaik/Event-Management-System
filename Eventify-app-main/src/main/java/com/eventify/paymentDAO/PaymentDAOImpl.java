package com.eventify.paymentDAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.eventify.Utility.DBConnection;

public class PaymentDAOImpl implements PaymentDAO {

	private Connection con;
	public PaymentDAOImpl() {
		con=DBConnection.getConnection();
	}

	@Override
	public boolean createPayment(Integer eventId, Integer userId, Double amount, String paymentMethod) {
		String query = "INSERT INTO payments (event_id, user_id, amount, payment_method, payment_status, transaction_id) VALUES (?, ?, ?, ?, 'COMPLETED', ?)";
		
		// To generate fake transaction ID
        String transactionId = "TXN" + System.currentTimeMillis();
        
        Integer i = 0;
        
        try {
			PreparedStatement ps = con.prepareStatement(query);
			
			ps.setInt(1, eventId);
            ps.setInt(2, userId);
            ps.setDouble(3, amount);
            ps.setString(4, paymentMethod);
            ps.setString(5, transactionId);
            
            i=ps.executeUpdate();
            if(i>0) {
            	return true;
            }
            
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		
		return false;
	}

}
