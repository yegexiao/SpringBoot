package com.comtop.controller;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class IndexController {
	
	
	@RequestMapping(value="/index")
	public String init(ModelMap map){
		
		return "index";
	}
	
	@RequestMapping(value="/welcome")
	public String welcome(ModelMap map){
		
		return "welcome";
	}
}
