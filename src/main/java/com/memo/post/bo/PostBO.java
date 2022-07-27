package com.memo.post.bo;

import java.io.IOException;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.memo.common.FileManagerSevice;
import com.memo.post.dao.PostDAO;
import com.memo.post.model.Post;

@Service
public class PostBO {
//	private Logger logger = LoggerFactory.getLogger(PostBO.class);
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
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
	
	public int updatePost(int userId, String userLoginId, int postId, String subject, String content, MultipartFile file) {
		
		// 기존의 저장된 글을 가져와본다.
		logger.info("updatePost postId:{}", postId);
		
		Post post = getPostById(postId);
		if(post == null) {
			logger.error("[update post] 수정할 게시물이 없습니다. postId:{}", postId);
			return 0;
		}
	
		// 업로드 할 파일이 없는 경우 수정하지 않음
		String imagePath = null;
		if(file != null) {
			// 업로드 할 파일이 있는지 본 후 서버에 업로드하고 imagePath를 받아온다.
			imagePath = fileManager.savsFile(userLoginId, file);
			
			// 새로 업로드된 이미지가 성공하면 기존 이미지 삭제(기존 이미지가 있을 때에만)
			if (imagePath != null && post.getImagePath() != null) {
				// 기존 이미지 삭제
				try {
					fileManager.deleteFile(post.getImagePath());
				} catch (IOException e) {
					logger.error("이미지 삭제 실패. postId:{}", postId);
					
				}
			}
		}
		
		// update
		return postDAO.updatePostByPostIdandUserId(userId, postId, subject, content, imagePath);
	}
}
