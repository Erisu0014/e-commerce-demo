package com.neuedu.pojo;

import java.util.List;

public class BaseArea {
    private Integer codeid;

    private Integer parentid;

    private String cityname;
    
    private List<BaseArea>children;

    public List<BaseArea> getChildren() {
		return children;
	}

	public void setChildren(List<BaseArea> children) {
		this.children = children;
	}

	public Integer getCodeid() {
        return codeid;
    }

    public void setCodeid(Integer codeid) {
        this.codeid = codeid;
    }

    public Integer getParentid() {
        return parentid;
    }

    public void setParentid(Integer parentid) {
        this.parentid = parentid;
    }

    public String getCityname() {
        return cityname;
    }

    public void setCityname(String cityname) {
        this.cityname = cityname == null ? null : cityname.trim();
    }
}