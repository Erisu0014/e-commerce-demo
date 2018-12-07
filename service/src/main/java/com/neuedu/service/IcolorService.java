package com.neuedu.service;

import java.util.List;

import com.neuedu.pojo.Color;
import com.neuedu.pojo.ColorExample;

public interface IcolorService {
	public List<Color>getColors(ColorExample colorExample);
	public Color getColorById(int id);

}
