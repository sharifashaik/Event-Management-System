package com.eventify.vendorDAO;

import java.util.List;

import com.eventify.model.Vendor;

public interface VendorDAO {
	
	 public List<Vendor> getApprovedVendors();
	
	 public List<Vendor> getVendorsByIds(Integer[] vendorIds);
	
	 public List<Vendor> getAllVendors(String filterStatus);
	 
	 public Boolean addVendor(Vendor v);
	 
	 public Boolean updateApprovalStatus(Integer vendorId, String status);
	 
	 public Boolean deleteVendor(Integer vendorId);
	 
	 public Integer getTotalVendors();
	 
	 public Integer getPendingVendors(); 

}
