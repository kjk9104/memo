package com.memo.post.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.memo.post.model.Post;

@Repository
public interface PostDAO {
	
	public void insertPost(
			@Param("userId") int userId
			,@Param("subject")String subject
			,@Param("content")String content
			,@Param("imagePath")String imagePath);
	
	public List<Post> selectPost();
	
	public Post selectPostById(int id);
	
	public int updatePostByPostIdandUserId(
			@Param("userId")int userId,
			@Param("postId")int postId, 
			@Param("subject")String subject, 
			@Param("content")String content, 
			@Param("imagePath")String imagePath);
	
	public void deletePost(	@Param("postId") int postId, @Param("userId") int userId);
	}





 