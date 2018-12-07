package com.neuedu.service;

import com.neuedu.pojo.Userinfo;

public interface IuserService {
	public int add(Userinfo userinfo);
	public Userinfo getUserinfoById(int id);

}
