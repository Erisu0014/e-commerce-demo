package com.neuedu.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.neuedu.dao.ShopcartMapper;
import com.neuedu.pojo.Shopcart;
import com.neuedu.pojo.ShopcartExample;
import com.neuedu.pojo.ShopcartKey;
@Service
public class ShopcartServiceImpI implements IshopcartService{
	@Resource
	ShopcartMapper shopcartmapper;

	@Override
	public int add(Shopcart shopcart) {
		return shopcartmapper.insertSelective(shopcart);
	}

	@Override
	public int update(Shopcart shopcart) {
		return shopcartmapper.updateByPrimaryKeySelective(shopcart);
	}

	@Override
	public List<Shopcart> getShopcarts(ShopcartExample example) {
		return shopcartmapper.selectByExample(example);
	}

	@Override
	public int del(ShopcartKey key) {
		return shopcartmapper.deleteByPrimaryKey(key);
	}

}
