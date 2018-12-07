package com.neuedu.controller;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.neuedu.pojo.Sku;
import com.neuedu.pojo.SkuExample;
import com.neuedu.service.IskuService;

@Controller
@RequestMapping("/sku")
public class SkuController {
	@Resource
	IskuService skuService;
	@RequestMapping("/list.do")
	public String list(int productId,ModelMap map) {
		map.addAttribute("productId", productId);
		return "sku/list";
	}
	@RequestMapping("/get.do")
	@ResponseBody
	public List<Sku> getSku(Sku sku){		
		SkuExample skuExample=new SkuExample();
		skuExample.createCriteria().andProductIdEqualTo(sku.getProductId());
		List<Sku> skus=skuService.getSkus(skuExample);
		System.out.println("skus="+skus);
		return skus;
	}
	@RequestMapping("/update.do")
	@ResponseBody
	public String updateSku(Sku sku) {
		int i=skuService.updateSku(sku);
		return String.valueOf(i);
	}

}
