package com.memo.post;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.memo.post.bo.PostBO;
import com.memo.post.model.Post;

@RequestMapping("/post")
@Controller
public class PostController {
	@Autowired
	private PostBO postBO;
	
	// http://localhost/post/post_list_view
	@RequestMapping("/post_list_view")
	public String postListView(Model model) {
		List<Post> postList = postBO.getPost();
		model.addAttribute("viewName","post/post_list");
		model.addAttribute("postList",postList);
		
		return "template/layout";
	}
	/**
	 * 글쓰기 화면
	 * @param model
	 * @return
	 */
	// http://localhost/post/post_create_view
	@RequestMapping("/post_create_view")
	public String postCreateView(Model model) {
		model.addAttribute("viewName","post/post_create");
		return"template/layout";
	}
	
	
	// http://localhost/post/post_detail_view
	@RequestMapping("/post_detail_view")
	public String postDetailView(
			@RequestParam("postId") int postId,
			Model model
			) {
		
		Post post = postBO.getPostById(postId);
		model.addAttribute("viewName", "post/post_detail");
		model.addAttribute("post", post);
		return "template/layout";
	}
	
	
}
