package com.neuedu.test;
import java.io.File;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.mybatis.generator.api.MyBatisGenerator;
import org.mybatis.generator.config.Configuration;
import org.mybatis.generator.config.xml.ConfigurationParser;
import org.mybatis.generator.internal.DefaultShellCallback;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.github.pagehelper.PageHelper;
import com.neuedu.pojo.Brand;
import com.neuedu.pojo.BrandExample;
import com.neuedu.pojo.BrandExample.Criteria;
import com.neuedu.service.IbrandService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations="classpath:applicationContext.xml")
public class MyTest {
	@Resource
	IbrandService brandservice;
	public static void main(String[] args) throws Exception {		
		generator();
		
	}
		
	public static void generator() throws Exception{

	    List<String> warnings = new ArrayList<String>();
	    boolean overwrite = true;
	    //指定逆向工程配置文件
	    File configFile = new File(System.getProperty("user.dir")+"/src/test/resources/mybatis.xml");
	   ConfigurationParser cp = new ConfigurationParser(warnings);
	    Configuration config = cp.parseConfiguration(configFile);
	    DefaultShellCallback callback = new DefaultShellCallback(overwrite);
	    MyBatisGenerator myBatisGenerator = new MyBatisGenerator(config,
	            callback, warnings);
	    myBatisGenerator.generate(null);
	    System.out.println("生成完成");
	} 
	
	@Test
	public void handler() {
		    Brand brand =null;
		for(int i=0;i<100;i++) {
			brand=new Brand();
			brand.setName("小米"+i);
			brand.setImgUrl(i+".jpg");
			brand.setSort(1);
			brand.setIsDel(1);
			brand.setWebSite("www.mi"+i+".com");
			brandservice.add(brand);
		}
		
		
		/*PageHelper.startPage(0,3);
		BrandExample brandExample=new BrandExample();
		brandExample.createCriteria().andNameLike("%i%");
		List<Brand>brands=brandservice.query(brandExample);
		for(Brand brand:brands) {
			System.out.println(brand.getName());
		}*/
	}
}
