package com.memo.post.bo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.memo.common.FileManagerSevice;
import com.memo.post.dao.PostDAO;
import com.memo.post.model.Post;

@Service
public class PostBO {
	@Autowired
	private FileManagerSevice fileManager;
	@Autowired
	private PostDAO postDAO;
	public void addPost(
			int userId
			,String userLoginId
			,String subject
			,String content
			,MultipartFile file
			) {
		String imagePath ="null";
		// 파일이 있으면 파일 업로드 => path 리턴 받음
		if(file != null) {
			imagePath = fileManager.savsFile(userLoginId, file);
		}
		
		// dao insert
		postDAO.insertPost(userId, subject, content, imagePath);
	}
	public List<Post> getPost(){
		return postDAO.selectPost();
	}
	public Post getPostById(int id) {
		return postDAO.selectPostById(id);
		
	}
}
