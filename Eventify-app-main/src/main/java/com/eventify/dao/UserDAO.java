package com.eventify.dao;

import java.sql.Connection;
import java.util.List;

import com.eventify.model.User;

public interface UserDAO {
	
   public boolean saveUser(User user);
   
   public User loginUser(String email,String password);
   
//   public boolean emailExists(String email);
   public int getallUsers();
   
   public List<User> fetchallUsers();
   
   
}
