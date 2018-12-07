package com.neuedu.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.github.pagehelper.PageHelper;
import com.neuedu.dao.BrandMapper;
import com.neuedu.pojo.Brand;
import com.neuedu.pojo.BrandExample;

@Service
public class BrandServiceImpI implements IbrandService{
	@Resource
	BrandMapper brandMapper;

	@Override
	public int add(Brand brand) {
		return brandMapper.insertSelective(brand);	
	}

	@Override
	public List<Brand> query(Brand brand,BrandExample brandExample) {
		if(brand.getWithPage()==1){
			PageHelper.startPage(brand.getPageNo(),brand.getPageSize());
		}
		return brandMapper.selectByExample(brandExample);
	}

	@Override
	public int del(int id) {
		return brandMapper.deleteByPrimaryKey(id);
	}

	@Override
	public Brand getBrandByID(int id) {		
		return brandMapper.selectByPrimaryKey(id);
	}

	@Override
	public int UpdateBrand(Brand brand) {
		return brandMapper.updateByPrimaryKeySelective(brand);
	}

}
