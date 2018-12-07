package com.neuedu.service;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.neuedu.dao.BaseAreaMapper;
import com.neuedu.pojo.BaseArea;
import com.neuedu.pojo.BaseAreaExample;

@Service
public class AreaServiceImpI implements IareaService {

	@Resource
	BaseAreaMapper areaMapper;

	@Override
	public List<BaseArea> getAreas() {
		BaseAreaExample areaExample=new BaseAreaExample();
		areaExample.createCriteria().andParentidEqualTo(0);		
		List<BaseArea>list=areaMapper.selectByExample(areaExample);
		for(BaseArea baseArea:list) {
			BaseAreaExample childExample=new BaseAreaExample();
			childExample.createCriteria().andParentidEqualTo(baseArea.getCodeid());
			List<BaseArea>children=areaMapper.selectByExample(childExample);
			for(BaseArea child:children) {
				BaseAreaExample childExample2=new BaseAreaExample();
				childExample2.createCriteria().andParentidEqualTo(child.getCodeid());
				child.setChildren(areaMapper.selectByExample(childExample2));
			}
			baseArea.setChildren(children);
			
		}
		return list;
	}

}
