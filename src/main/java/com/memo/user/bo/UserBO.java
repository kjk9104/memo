package com.memo.user.bo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.memo.post.model.Post;
import com.memo.user.dao.UserDAO;
import com.memo.user.model.User;
@Service
public class UserBO {
	@Autowired
	private UserDAO userDAO;
	
	public List<User> getUserList(){
		return userDAO.selectUserList();
	}
	
	public boolean existLoginId(String loginId) {
		return userDAO.existLoginId(loginId);
	}
	
	public void addUser(
			String loginId
			,String encryptPassword
			,String name
			,String email
			) {
			userDAO.insertUser(loginId, encryptPassword, name, email);
		
		
	}
	
	public User getUserByLoginIdPassword(String loginId, String encryptPassword) {
		return userDAO.selectUserByLoginIdPassword(loginId, encryptPassword);
	}
	

}
