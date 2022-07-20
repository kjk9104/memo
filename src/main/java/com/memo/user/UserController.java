package com.memo.user;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.memo.user.bo.UserBO;

// 화면
@Controller
@RequestMapping("/user")
public class UserController {

	
	@Autowired
	private UserBO userBO;
	
	
	/**
	 * 회원 가입 화면
	 * @param model
	 * @return
	 */
	// http://localhost/user/sign_up_view
	@RequestMapping("/sign_up_view")
	public String signUpView(Model model) {
		model.addAttribute("viewName", "user/sign_up");
		return "template/layout";
	}
	/**
	 * 로그인 화면
	 * @param model
	 * @return
	 */
	
	// http://localhost/user/sign_in_view
		@RequestMapping("/sign_in_view")
		public String loginPage(Model model) {
			model.addAttribute("viewName", "user/sign_in_view");
			return "template/layout";
		}

		
	/**
	 * 회원 가입 수행(form) - 사용하지 않음
	 * @param loginId
	 * @param password
	 * @param name
	 * @param email
	 * @return
	 */
//	@PostMapping("/sign_up_for_submit")
//	public String signUpForSubmit(
//			@RequestParam("loginId") String loginId
//			,@RequestParam("password") String password
//			,@RequestParam("name") String name
//			,@RequestParam("email") String email
//			) {
//		
//				return "redirect:/user/sign_in_view";
//		
//	}
	/**
	 * 로그 아웃
	 * @param request
	 * @return
	 */
	@RequestMapping("/sign_out")
	public String signOut(HttpSession session) {
		
		// 로그아웃 - 세션에 있는 키-값들을 모두 지운다.
		session.removeAttribute("userId");
		session.removeAttribute("userLoginId");
		session.removeAttribute("userNmae");
		
		// 리다이렉트
		return "redirect:/user/sign_in_view";
	}
	
}






