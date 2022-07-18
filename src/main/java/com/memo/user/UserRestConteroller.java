package com.memo.user;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.memo.user.bo.UserBO;
import com.memo.user.model.User;

// 데이터 API
@RequestMapping("/user")
@RestController
public class UserRestConteroller {
	@Autowired
	private UserBO userBO;
	
	
	// http://localhost/user/user_list
	@RequestMapping("/user_list")
	public List<User> userList(){
		return userBO.getUserList();
		
	}

}
