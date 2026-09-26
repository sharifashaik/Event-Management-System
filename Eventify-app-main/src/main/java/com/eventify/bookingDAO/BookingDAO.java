package com.eventify.bookingDAO;

public interface BookingDAO {
	
	public Boolean createBookings(Integer eventId, Integer[] vendorIds);

}
