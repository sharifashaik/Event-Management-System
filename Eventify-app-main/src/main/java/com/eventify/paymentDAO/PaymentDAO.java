package com.eventify.paymentDAO;

public interface PaymentDAO {
	
	 public boolean createPayment(Integer eventId, Integer userId, Double amount, String paymentMethod);

}
