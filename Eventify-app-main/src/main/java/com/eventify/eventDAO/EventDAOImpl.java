package com.eventify.eventDAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.eventify.Utility.DBConnection;
import com.eventify.model.Event;
import com.eventify.model.User;

public class EventDAOImpl implements EventDAO {

	private Connection con;
	public EventDAOImpl() {
		con=DBConnection.getConnection();
	}

	@Override
	public Integer createEvent(Event e) {
		String query="INSERT  INTO events (user_id, event_type, event_date, venue, guest_count) VALUES (?, ?, ?, ?, ?)";
		
		try {
			PreparedStatement ps = con.prepareStatement(query,Statement.RETURN_GENERATED_KEYS);
			
			ps.setInt(1, e.getUserId());
			ps.setString(2, e.getEventType());
			ps.setDate(3, e.getEventDate());
			ps.setString(4, e.getVenue());
			ps.setInt(5, e.getGuestCount());
			
			Integer i=ps.executeUpdate();
			
			if(i>0) {
				 ResultSet keys = ps.getGeneratedKeys();
	                if (keys.next()) {
	                    return keys.getInt(1);
			}
			}
		} catch (SQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		return -1;
	}

	@Override
	public Event getEventById(Integer id) {
		
		String query = "SELECT e.*, (SELECT p.payment_status FROM payments p WHERE p.event_id = e.event_id LIMIT 1) as payment_status FROM events e WHERE e.event_id = ?";
		Event event = null; 
		
		try {
			PreparedStatement ps = con.prepareStatement(query);
			
			ps.setInt(1, id);
			
			ResultSet rs=ps.executeQuery(); 
			
			if(rs.next()) {
				event= new Event();
				event.setEventId(rs.getInt("event_id"));
		        event.setUserId(rs.getInt("user_id"));
		        event.setEventType(rs.getString("event_type"));
		        event.setEventDate(rs.getDate("event_date"));
		        event.setVenue(rs.getString("venue"));
		        event.setGuestCount(rs.getInt("guest_count"));
		        event.setPaymentStatus(rs.getString("status"));
		        return event;

			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<Event> getEventByUserId(Integer id) {
		List<Event> eventList = new ArrayList<Event>();
		
		String query = "SELECT e.*, (SELECT p.payment_status FROM payments p WHERE p.event_id = e.event_id LIMIT 1) as payment_status FROM events e WHERE e.user_id = ? ORDER BY e.created_at DESC";
		Event event = null;
		try {
			PreparedStatement ps = con.prepareStatement(query);
			
			ps.setInt(1, id);
			
			ResultSet rs=ps.executeQuery(); 
			
			if(rs.next()) {
				event= new Event();
				event.setEventId(rs.getInt("event_id"));
		        event.setUserId(rs.getInt("user_id"));
		        event.setEventType(rs.getString("event_type"));
		        event.setEventDate(rs.getDate("event_date"));
		        event.setVenue(rs.getString("venue"));
		        event.setGuestCount(rs.getInt("guest_count"));
		        event.setPaymentStatus(rs.getString("status"));
		        eventList.add(event);

			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return eventList;
	}

	@Override
	public Integer getTotalEventsForUser(Integer userId) {
		String query = "SELECT COUNT(*) FROM events WHERE user_id = ?";
		
		try {
			PreparedStatement ps = con.prepareStatement(query);
			ps.setInt(1,userId);
			
			ResultSet rs=ps.executeQuery();
			
			if(rs.next()) {
				return rs.getInt(1);

			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return 0;
	}

	@Override
	public Integer getUpcomingEventsForUser(Integer userId) {
		String query="SELECT COUNT(*) FROM events WHERE user_id = ? AND event_date >= CURDATE() AND status != 'CANCELLED'";
		
		try {
			PreparedStatement ps = con.prepareStatement(query);
			
			ps.setInt(1, userId);
			ResultSet rs = ps.executeQuery();
            if (rs.next()) { 
            	return rs.getInt(1);
            }	
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return 0;
	}

	@Override
	public Double getTotalSpentByUser(Integer userId) {
		String query = "SELECT COALESCE(SUM(amount), 0) FROM payments WHERE user_id = ? AND payment_status = 'COMPLETED'";
		
		try {
			PreparedStatement ps = con.prepareStatement(query);
			ps.setInt(1, userId);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) { 
            	return rs.getDouble(1);
            }
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public Boolean updateEventStatus(Integer eventId, String status) {
		String query = "UPDATE events SET status = ? WHERE event_id = ?";
		Integer i= null;
		try {
			PreparedStatement ps = con.prepareStatement(query);
			ps.setString(1, status);
            ps.setInt(2, eventId);
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

	@Override
	public Integer getTotalEvents() {
		String query = "SELECT COUNT(*) FROM events";
		
		try {
			PreparedStatement ps = con.prepareStatement(query);
			
			ResultSet rs = ps.executeQuery();
			
			 if (rs.next()) { 
	            	return rs.getInt(1);
	         }	
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return 0;
	}

	@Override
	public Integer getPendingEvents() {
		
		String query = "SELECT COUNT(*) FROM events WHERE status = 'PENDING'";
		
		
		try {
			PreparedStatement ps = con.prepareStatement(query);
			
			ResultSet rs = ps.executeQuery();
			
			 if (rs.next()) { 
	            	return rs.getInt(1);
	         }	
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return 0;
	}

	@Override
	public Double getTotalRevenue() {
		String query = "SELECT COALESCE(SUM(amount), 0) FROM payments WHERE payment_status = 'COMPLETED'";
		
		try {
			PreparedStatement ps = con.prepareStatement(query);
			ResultSet rs = ps.executeQuery();
			
			 if (rs.next()) { 
	            	return rs.getDouble(1);
	         }	
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return 0.0;
	}

	@Override
	public List<Map<String, Object>> getAllEventsWithCustomer(String filterStatus) {
		
		
		List<Map<String, Object>> eventsWithCustomer = new ArrayList<>();
		String query = "SELECT e.*, u.full_name as customer_name, u.email as customer_email, (SELECT p.payment_status FROM payments p WHERE p.event_id = e.event_id LIMIT 1) as payment_status FROM events e JOIN users u ON e.user_id = u.user_id";
		
		 if (filterStatus != null && !filterStatus.equals("all")) {
	            query += " WHERE e.status = '" + filterStatus + "'";
	        }
	        query += " ORDER BY e.created_at DESC";
	        
	        try {
				PreparedStatement ps = con.prepareStatement(query);
				ResultSet rs = ps.executeQuery();
				
				
				while (rs.next()) {
	                Map<String, Object> event = new HashMap<>();
	                event.put("eventId", rs.getInt("event_id"));
	                event.put("customerName", rs.getString("customer_name"));
	                event.put("customerEmail", rs.getString("customer_email"));
	                event.put("eventType", rs.getString("event_type"));
	                event.put("eventDate", rs.getDate("event_date"));
	                event.put("venue", rs.getString("venue"));
	                event.put("guestCount", rs.getInt("guest_count"));
	                event.put("status", rs.getString("status"));
	                event.put("paymentStatus", rs.getString("payment_status") != null ? rs.getString("payment_status") : "PENDING");
	                eventsWithCustomer.add(event);
	            }
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		return eventsWithCustomer;
		
	}

}
