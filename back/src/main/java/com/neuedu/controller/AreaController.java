package com.neuedu.controller;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.neuedu.pojo.BaseArea;
import com.neuedu.service.IareaService;


@RestController
@RequestMapping("area")
public class AreaController {
	@Resource
	IareaService areaService;
	
	@RequestMapping("/list.do")
	public List<BaseArea>getAreaList(){
		return areaService.getAreas();
	}

}
