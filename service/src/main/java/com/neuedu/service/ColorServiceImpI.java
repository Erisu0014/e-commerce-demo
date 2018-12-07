package com.neuedu.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.neuedu.dao.ColorMapper;
import com.neuedu.pojo.Color;
import com.neuedu.pojo.ColorExample;
@Service
public class ColorServiceImpI implements IcolorService{
	@Resource
	ColorMapper colormapper;

	@Override
	public List<Color> getColors(ColorExample colorExample) {		
		return colormapper.selectByExample(colorExample);
	}

	@Override
	public Color getColorById(int id) {
		return colormapper.selectByPrimaryKey(id);
	}

}
