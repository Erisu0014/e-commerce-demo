package com.neuedu.pojo;

import lombok.Data;

@Data
public class Page {
	public Integer pageNo=1;
	public Integer pageSize=3;
	public Integer withPage=1;
	public String url;
	public String params;
	public Integer pages;

}
