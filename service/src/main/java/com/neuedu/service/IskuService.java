package com.neuedu.service;

import java.util.List;

import com.neuedu.pojo.Sku;
import com.neuedu.pojo.SkuExample;

public interface IskuService {
	public int add(Sku sku);
	public List<Sku>getSkus(SkuExample example);
	public int updateSku(Sku sku);
	public Sku getSkuById(int id);
}
