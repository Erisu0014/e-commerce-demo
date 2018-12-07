package com.neuedu.pojo;

import lombok.Data;

@Data
public class productQuery extends Page{
	private String name;
	private Integer brandId;
	private Integer colorId;
	private Integer storageId;
	private Integer isShow;
	private Integer isDel;	
}
