package com.comtop.controller;

import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;
import com.comtop.model.User;

@RestController
public class UserController {

	public ModelAndView User(){
		ModelAndView model = new ModelAndView();
		
		User user = new User();
		user.setId("1");
		user.setName("余威");
		user.setAge(19);
		user.setPhone("123123123");
		model.addObject("User", user);
		
		return model;
	}
}
