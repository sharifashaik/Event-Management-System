package com.eventify.model;

import java.sql.Date;

public class Event {
 
 
 public Event(Integer userId, String eventType,Date eventDate, String venue, Integer guestCount) {
		super();
		this.userId = userId;
		this.eventType = eventType;
		this.venue = venue;
		this.eventDate = eventDate;
		this.guestCount = guestCount;
		
	}
 public Event() {
	 
 }
 private Integer eventId;
 private Integer userId;
 private String eventType;
 private String venue;
 private Date eventDate;
 private Integer guestCount;
 private String paymentStatus;
 public Integer getEventId() {
	return eventId;
 }
 public void setEventId(Integer eventId) {
	this.eventId = eventId;
 }
 public Integer getUserId() {
	return userId;
 }
 public void setUserId(Integer userId) {
	this.userId = userId;
 }
 public String getEventType() {
	return eventType;
 }
 public void setEventType(String eventType) {
	this.eventType = eventType;
 }
 public String getVenue() {
	return venue;
 }
 public void setVenue(String venue) {
	this.venue = venue;
 }
 public Date getEventDate() {
	return eventDate;
 }
 public void setEventDate(Date eventDate) {
	this.eventDate = eventDate;
 }
 public Integer getGuestCount() {
	return guestCount;
 }
 public void setGuestCount(Integer guestCount) {
	this.guestCount = guestCount;
 }
 public String getPaymentStatus() {
	return paymentStatus;
 }
 public void setPaymentStatus(String paymentStatus) {
	this.paymentStatus = paymentStatus;
 }
 @Override
 public String toString() {
	return "Event [eventId=" + eventId + ", userId=" + userId + ", eventType=" + eventType + ", venue=" + venue
			+ ", eventDate=" + eventDate + ", guestCount=" + guestCount + ", paymentStatus=" + paymentStatus + "]";
 }
}