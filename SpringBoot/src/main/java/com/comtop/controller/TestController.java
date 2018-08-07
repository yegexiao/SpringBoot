package com.comtop.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/TestController")
public class TestController {

	@GetMapping(value="/index")
	public String HelloWord(){
		
		return "springboot";
	}
}
