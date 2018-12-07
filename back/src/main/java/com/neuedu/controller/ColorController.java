package com.neuedu.controller;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.neuedu.pojo.Color;
import com.neuedu.pojo.ColorExample;
import com.neuedu.service.IcolorService;


@Controller
@RequestMapping("/color")
public class ColorController {
	
	@Resource
	IcolorService colorService;
	
	@RequestMapping("/list.do")
	@ResponseBody
	public List<Color> list(){
		ColorExample colorExample = new ColorExample();
		colorExample.createCriteria().andIsDelEqualTo(1);
		List<Color> colors = colorService.getColors(colorExample);
		return colors;
	}
}
