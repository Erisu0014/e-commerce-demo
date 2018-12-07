package com.neuedu.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;


import org.apache.commons.lang3.StringUtils;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;

import com.github.pagehelper.Page;
import com.neuedu.pojo.Brand;
import com.neuedu.pojo.BrandExample;
import com.neuedu.pojo.BrandExample.Criteria;
import com.neuedu.service.IbrandService;
import com.neuedu.utils.Myutils;

@Controller
@RequestMapping("/brand")
public class BrandController {
	@Resource
	IbrandService brandService;

	@RequestMapping("/list.do")
	public String list(Brand brand, ModelMap map) {
		BrandExample example = new BrandExample();
		example.setOrderByClause("sort desc");
		StringBuilder params = new StringBuilder();
		Criteria criteria = example.createCriteria();
		if (StringUtils.isNotBlank(brand.getName())) {
			criteria.andNameLike("%" + brand.getName() + "%");
			params.append("&name=" + brand.getName().trim());
		}
		if (brand.getIsDel() != null) {
			criteria.andIsDelEqualTo(brand.getIsDel());
			System.out.println(brand.getIsDel());
			params.append("&isDel=" + brand.getIsDel());
		}
		Page<Brand> brands = (Page<Brand>) brandService.query(brand, example);
		brand.setUrl("list.do");
		brand.setPages(brand.getPages());
		brand.setParams(params.toString());
		brand.setPages(brands.getPages());
		map.addAttribute("brands", brands);
		map.addAttribute("brand", brand);
		return "brand/list";
	}

	@RequestMapping(value = "/add.do", method = RequestMethod.GET)
	public String goAdd(HttpServletRequest request) {
		request.setAttribute("key", "value");
		request.getSession().setAttribute("key", "session");
		return "brand/add";
	}

	@RequestMapping(value = "/add.do", method = RequestMethod.POST)
	public String doAdd(Brand brand, MultipartFile logoImg) {
		System.out.println(logoImg.getOriginalFilename());

		String str = null;
		try {
			str = Myutils.upload(logoImg);
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println("str=" + str);
		brand.setImgUrl(str);
		brandService.add(brand);
		return "redirect:list.do";
	}

	@RequestMapping(value = "/del.do", method = RequestMethod.GET)
	public String doDel(int id) {
		Brand brand = brandService.getBrandByID(id);
		brand.setIsDel(0);
		brandService.UpdateBrand(brand);
		// brandService.del(id);
		return "redirect:list.do";
	}

	@RequestMapping(value = "/update.do", method = RequestMethod.GET)
	public String goUpdate(int id, ModelMap map) {
		Brand brand = brandService.getBrandByID(id);
		map.addAttribute("brand", brand);
		return "brand/update";

	}

	@RequestMapping(value = "/update.do", method = RequestMethod.POST)
	public String doUpdate(HttpServletRequest request,Brand brand, MultipartFile logoImg) {
		System.out.println("logoImg:"+logoImg.getOriginalFilename());	
		String oldImg=request.getParameter("img");		
		System.out.println("oldImg:"+oldImg);	
		Brand oldBrand=brandService.getBrandByID(brand.getId());
		String str = null; //存放可能需要更新的img
		if(oldBrand.getImgUrl().equals(oldImg)) {
			System.out.println("true");
			str=oldImg;
		}else {
			System.out.println("false");
			try {
				str = Myutils.upload(logoImg);
			} catch (Exception e) {
				e.printStackTrace();
			}			
		}
		brand.setImgUrl(str);
		brandService.UpdateBrand(brand);
		/*String str = null;
		try {
			str = Myutils.upload(logoImg);
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println("str=" + str);
		brand.setImgUrl(str);
		brandService.UpdateBrand(brand);*/
		return "redirect:list.do";
	}

}
