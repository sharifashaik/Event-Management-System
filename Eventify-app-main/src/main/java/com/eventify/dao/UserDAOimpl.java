package com.eventify.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.eventify.Utility.DBConnection;
import com.eventify.model.User;

public class UserDAOimpl implements UserDAO {
    
	private Connection con;
	public UserDAOimpl() {
		this.con=DBConnection.getConnection();
	}
	@Override
	public boolean saveUser(User user) {
		String query = "insert into users(full_name,email,phone,password,role) values(?,?,?,?,?)";
		Integer i = 0;
		try {
			PreparedStatement ps = con.prepareStatement(query);
			ps.setString(1, user.getFull_name());
			ps.setString(2, user.getEmail());
			ps.setString(3, user.getPhone());
			ps.setString(4, user.getPassword());
			ps.setString(5, user.getRole());
			i = ps.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		if(i>0) {
			return true;
		}else {
		return false;
	}
	}

	@Override
	public User loginUser(String email, String password) {
		String query = "select * from users where email = ? and password = ?";
		User u = null;
		try {
			PreparedStatement ps = con.prepareStatement(query);
			ps.setString(1,email);
			ps.setString(2, password);
			ResultSet rs =ps.executeQuery();
			
			while(rs.next()) {
				u = new User();
				u.setUser_id(rs.getInt("user_id"));
				u.setFull_name(rs.getString("full_name"));
				u.setPhone(rs.getString("phone"));
				u.setRole(rs.getString("role"));
				
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return u;
	}

//	@Override
//	public boolean emailExists(String email) {
//		// TODO Auto-generated method stub
//		return false;
//	}

	@Override
	public int getallUsers() {
		String query = "select count(*) from users where role = 'customer'";
		try {
			PreparedStatement ps = con.prepareStatement(query);
			ResultSet rs = ps.executeQuery();
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
	public List<User> fetchallUsers() {
		List<User> list = new ArrayList<User>();
		User u = null;
		String query = "select * from user";
		try {
			PreparedStatement ps = con.prepareStatement(query);
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
			 u = new User();
			 u.setUser_id(rs.getInt("user_id"));
			 u.setFull_name(rs.getString("full_name"));
			 u.setEmail(rs.getString("email"));
			 u.setPassword(rs.getString("password"));
			 u.setPhone(rs.getString("phone"));
             list.add(u);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return list;
	}

}
