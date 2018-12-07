package com.neuedu.service;

import java.util.List;

import com.neuedu.pojo.Shopcart;
import com.neuedu.pojo.ShopcartExample;
import com.neuedu.pojo.ShopcartKey;

public interface IshopcartService {
	public int add(Shopcart shopcart);
	public int update(Shopcart shopcart);
	public List<Shopcart>getShopcarts(ShopcartExample example);
	public int del(ShopcartKey key);

}
