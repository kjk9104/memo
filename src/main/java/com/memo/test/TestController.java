package com.memo.test;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class TestController {
	
	// http://localhost/test/1
	@ResponseBody
	@RequestMapping("/test/1")
	public String test1() {
		return "Hello world!";
	}
	
	// http://localhost/test/2
	@ResponseBody
	@RequestMapping("/test/2")
	public Map<String, Object> test2(){
		Map<String, Object> map = new HashMap<>();
		map.put("aaaa", 1111);
		map.put("bbbb", 2222);
		map.put("cccc", 3333);
		map.put("dddd", 4444);
		
		return map;
	}
	
	// http://localhost/test/3
	@RequestMapping("/test/3")
	public String testJsp() {
		return "/test/test";
	}
	
}
