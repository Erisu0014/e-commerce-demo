package com.neuedu.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.neuedu.dao.SkuMapper;
import com.neuedu.pojo.Sku;
import com.neuedu.pojo.SkuExample;
@Service
public class SkuServiceImpI implements IskuService{
	@Resource
	SkuMapper skumapper;

	@Override
	public int add(Sku sku) {
		return skumapper.insertSelective(sku);
	}

	@Override
	public List<Sku> getSkus(SkuExample example) {
		return skumapper.selectByExample(example);
	}

	@Override
	public int updateSku(Sku sku) {
		return skumapper.updateByPrimaryKeySelective(sku);	
	}

	@Override
	public Sku getSkuById(int id) {
		return skumapper.selectByPrimaryKey(id);
	}

}
