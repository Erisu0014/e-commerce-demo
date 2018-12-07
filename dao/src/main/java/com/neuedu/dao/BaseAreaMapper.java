package com.neuedu.dao;

import com.neuedu.pojo.BaseArea;
import com.neuedu.pojo.BaseAreaExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface BaseAreaMapper {
    long countByExample(BaseAreaExample example);

    int deleteByExample(BaseAreaExample example);

    int insert(BaseArea record);

    int insertSelective(BaseArea record);

    List<BaseArea> selectByExample(BaseAreaExample example);

    int updateByExampleSelective(@Param("record") BaseArea record, @Param("example") BaseAreaExample example);

    int updateByExample(@Param("record") BaseArea record, @Param("example") BaseAreaExample example);
}