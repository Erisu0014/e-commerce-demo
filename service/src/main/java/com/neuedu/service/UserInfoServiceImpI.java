package com.neuedu.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.neuedu.dao.UserinfoMapper;
import com.neuedu.pojo.Userinfo;

@Service
public class UserInfoServiceImpI implements IuserService{
	@Resource
	UserinfoMapper userinfomapper;

	@Override
	public int add(Userinfo userinfo) {
		
		int count= userinfomapper.insertSelective(userinfo);
		return userinfo.getId();
	}

	@Override
	public Userinfo getUserinfoById(int id) {
		return userinfomapper.selectByPrimaryKey(id);
	}

}
