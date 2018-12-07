package com.neuedu.service;
import java.util.List;

import com.neuedu.pojo.Brand;
import com.neuedu.pojo.BrandExample;

public interface IbrandService {
	public int add(Brand brand);
	//（条件）查询
	public List<Brand>query(Brand brand,BrandExample brandExample);
	//删除
	public int del(int id);
	//根据ID获得brand信息
	public Brand getBrandByID(int id);
	//修改brand信息
	public int UpdateBrand(Brand brand);

}
