package com.memo.post;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.memo.post.bo.PostBO;

@RequestMapping("/post")
@RestController
public class PostRestController {
	@Autowired
	private PostBO postBO;
	/**
	 * 메모 글쓰기 API
	 * @param subject
	 * @param content
	 * @param file
	 * @param session
	 * @return
	 */
	@PostMapping("/create")
	public Map<String, Object> create(
			@RequestParam("subject") String subject
			,@RequestParam("content") String content
			,@RequestParam(value="file", required=false) MultipartFile file
			,HttpSession session
			){
		
		Map<String, Object> result = new HashMap<>();
		result.put("result", "success");
		
		// 글쓴이 정보를 세션에서 꺼낸다.
		Object userIdObject = session.getAttribute("userId");
		if(userIdObject == null) {
			// 로그인 되어있지 않음
			result.put("result", "error");
			result.put("error", "로그인 후 사용 가능합니다.");
			return result;
		}
		
		//  로그인 된 사용자
		int userId = (int)userIdObject;
		String userLoginId = (String)session.getAttribute("userLoginId");
		
		// 글쓰기 db insert
		
		postBO.addPost(userId, userLoginId, subject, content, file);
		
		return result;
	}
	/**
	 * 수정 api
	 * @param postId
	 * @param subject
	 * @param content
	 * @param file
	 * @param session
	 * @return
	 */
	@PutMapping("/update")
	public Map<String, Object> update(
			@RequestParam("postId") int postId
			,@RequestParam("subject") String subject
			,@RequestParam("content") String content
			,@RequestParam(value="file", required=false) MultipartFile file
			,HttpSession session
			){
			
			// 로그인 된 사람만 도달했는지 검사 --> 나중에
			String userloginId = (String)session.getAttribute("userloginId");
			int userId = (int)session.getAttribute("userId");
			
			// db update
			int row = postBO.updatePost(userId, userloginId, postId, subject, content, file);
			
			
			// 성공 여부
			Map<String, Object> result = new HashMap<>();
			result.put("result", "success");
			
			if(row < 1) {
				result.put("result", "fail");
			}
			
			return result;
	}
	
	@DeleteMapping("/delete")
	public Map<String, Object> delete(
			@RequestParam("postId") int postId
			,HttpSession session
			){
		Map<String, Object> result = new HashMap<>();
		
		int userId = (int)session.getAttribute("userId");
		
		postBO.deletePost(postId, userId);
		
		result.put("result", "success");
		return result;
	}
}
