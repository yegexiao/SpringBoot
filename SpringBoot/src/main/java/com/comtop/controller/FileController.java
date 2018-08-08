package com.comtop.controller;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.comtop.constants.SpringbootConstants;
import com.comtop.model.JsonData;

@RestController
public class FileController {

	// 文件放在项目的images下/SpringBoot/src/main/resources/static
	private static final String filePath = "F:\\办公资料\\SpringBoot\\src\\main\\resources\\static\\images\\";

	@RequestMapping("/upload")
	@ResponseBody
	public JsonData upload(@RequestParam("head_img") MultipartFile file,
			HttpServletRequest request) {

		// file.isEmpty(); 判断图片是否为空
		// file.getSize(); 图片大小进行判断
		String name = request.getParameter("name");
		System.out.println("用户名：" + name);
		

		// 获取文件名
		String fileName = file.getOriginalFilename();
		System.out.println("file.getName()文件名：" + file.getName());
		System.out.println("file.getOriginalFilename()上传的文件名为：" + fileName);

		// 获取文件的后缀名,比如图片的jpeg,png
		String suffixName = fileName.substring(fileName.lastIndexOf("."));
		System.out.println("上传的后缀名为：" + suffixName);

		// 文件上传后的路径
		fileName = UUID.randomUUID() + suffixName;
		System.out.println("转换后的名称:" + fileName);
		File dest = new File(filePath + fileName);

		try {
			file.transferTo(dest);
			// 上传成功
			return new JsonData(SpringbootConstants.SUCCESS, fileName);
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		// 上传失败
		return new JsonData(SpringbootConstants.FAIL, "fail to save ", null);
	}
}
