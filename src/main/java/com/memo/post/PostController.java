package com.memo.post;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/post")
public class PostController {

	// http://localhost/post/post_list_view
	@RequestMapping("/post_list_view")
	public String post_list_view(Model model) {
		model.addAttribute("viewName","/post/post_list");
		return"/template/layout";
	}
}
