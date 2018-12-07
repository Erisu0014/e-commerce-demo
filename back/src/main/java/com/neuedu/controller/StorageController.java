package com.neuedu.controller;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.neuedu.pojo.Storage;
import com.neuedu.pojo.StorageExample;
import com.neuedu.service.IstorageService;

@Controller
@RequestMapping("/storage")
public class StorageController {
	@Resource
	IstorageService storageService;
	@RequestMapping("/list.do")
	@ResponseBody
	public List<Storage> list(){
		StorageExample storageExample=new StorageExample();
		storageExample.createCriteria().andIsDelEqualTo(1);
		return storageService.getsStorages(storageExample);
	}
}
