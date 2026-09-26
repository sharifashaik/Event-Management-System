package com.eventify.eventDAO;

import java.util.List;
import java.util.Map;

import com.eventify.model.Event;
import com.eventify.model.User;

public interface EventDAO {

	public Integer createEvent(Event e);
	
	public Event getEventById(Integer id);
	
	public List<Event> getEventByUserId(Integer userId);
	
	public Integer getTotalEventsForUser(Integer userId);
	
	public Integer getUpcomingEventsForUser(Integer userId);
	
	 public Double getTotalSpentByUser(Integer userId);
	 
	 public Boolean updateEventStatus(Integer eventId, String status);
	 
	 //Admin Method
	 public Integer getTotalEvents();
	 
	 public Integer getPendingEvents();
	 
	 public Double getTotalRevenue();
	 
	 public List<Map<String, Object>> getAllEventsWithCustomer(String filterStatus);
}
