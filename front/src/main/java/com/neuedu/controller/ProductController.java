package com.neuedu.controller;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.alibaba.fastjson.JSON;
import com.neuedu.pojo.Brand;
import com.neuedu.pojo.BrandExample;
import com.neuedu.pojo.Color;
import com.neuedu.pojo.ColorExample;
import com.neuedu.pojo.ProductWithBLOBs;
import com.neuedu.pojo.Shopcart;
import com.neuedu.pojo.ShopcartExample;
import com.neuedu.pojo.ShopcartKey;
import com.neuedu.pojo.Sku;
import com.neuedu.pojo.SkuExample;
import com.neuedu.pojo.Storage;
import com.neuedu.pojo.StorageExample;
import com.neuedu.pojo.Userinfo;
import com.neuedu.pojo.productQuery;
import com.neuedu.service.IbrandService;
import com.neuedu.service.IcolorService;
import com.neuedu.service.IproductService;
import com.neuedu.service.IshopcartService;
import com.neuedu.service.IskuService;
import com.neuedu.service.IstorageService;
import com.neuedu.service.IuserService;
@RestController
@RequestMapping("/product")
public class ProductController {
	@Resource
	IproductService productService;
	@Resource
	IcolorService colorService;
	@Resource
	IbrandService brandService;
	@Resource
	IstorageService storageService;
	@Resource
	IskuService skuService;
	@Resource
	IshopcartService shopcartService;
	@Resource
	IuserService userservice;
	@RequestMapping("/getData.do")
	public Map<String, List<?>>getProducts(){
		/*查询所有的品牌*/
		Map<String, List<?>>map=new HashMap<String, List<?>>();
		Brand brand =new Brand();
		brand.setWithPage(0);
		BrandExample brandExample=new BrandExample();
		brandExample.createCriteria().andIsDelEqualTo(1);
		map.put("brands",brandService.query(brand, brandExample));
		/*查询所有的颜色*/
		ColorExample colorExample=new ColorExample();
		colorExample.createCriteria().andIsDelEqualTo(1);
		map.put("colors", colorService.getColors(colorExample));
		/*查询所有的内存*/
		StorageExample storageExample=new StorageExample();
		storageExample.createCriteria().andIsDelEqualTo(1);
		map.put("storages", storageService.getsStorages(storageExample));
		return map;

	}
	@RequestMapping("/getProducts.do")
	public List<ProductWithBLOBs> getProducts(productQuery productQuery,ModelMap map) {
		System.out.println(productQuery);
		/*Page<ProductWithBLOBs> products = (Page<ProductWithBLOBs>) productService.search(productQuery);
		productQuery.setUrl("index.do");
		productQuery.setPages(products.getPages());
		map.addAttribute("productQuery", productQuery);*/
		return productService.search(productQuery);
	}
	@RequestMapping("/getDetails.do")
	public ProductWithBLOBs getDetails(int id) {
		ProductWithBLOBs productWithBLOBs= productService.getProductsByID(id);
		ColorExample colorExample=new ColorExample();
		StorageExample storageExample=new StorageExample();
		List<Integer> colors=new ArrayList<>();
		List<Integer> storages=new ArrayList<>();
		String[] colorarr= productWithBLOBs.getColorList().split(",");
		for (String string : colorarr) {
			colors.add(Integer.parseInt(string));
		}
		 colorExample.createCriteria().andIdIn(colors);
		 List<Color> colorlist=colorService.getColors(colorExample);
		 String[] storagearr= productWithBLOBs.getStorageList().split(",");
		 for (String string : storagearr) {
			 storages.add(Integer.parseInt(string));
		}
		 storageExample.createCriteria().andIdIn(storages);
		 List<Storage> storagelist=storageService.getsStorages(storageExample);
		 productWithBLOBs.setColors(colorlist);
		 productWithBLOBs.setStorages(storagelist);
		SkuExample skuExample=new SkuExample();
		skuExample.createCriteria().andProductIdEqualTo(id);
		List<Sku> skus= skuService.getSkus(skuExample);
		productWithBLOBs.setSkus(skus);		
		return productWithBLOBs;
	}
	@RequestMapping("skucart.do")
	public List<Sku> shopcart(ModelMap map) {
		ShopcartExample example=new ShopcartExample();		
		List<Sku>skus=this.getSkuByExample(example);	
		//map.addAttribute("shopcarts", shopcarts);
		return skus;
	}
	public List<Sku> getSkuByExample(ShopcartExample example) {
		List<Shopcart>shopcarts=shopcartService.getShopcarts(example);
		List<Sku>skus=new ArrayList<Sku>();
		Sku sku=new Sku();
		Color color=new Color();
		Storage storage=new Storage();
		ProductWithBLOBs product;
		for(Shopcart shopcart:shopcarts) {
			sku=skuService.getSkuById(shopcart.getSkuId());			
			color=colorService.getColorById(sku.getColorId());
			storage=storageService.getStorageById(sku.getStorageId());
			product=productService.getProductsByID(sku.getProductId());
			sku.setColorName(color.getName());
			sku.setImage(product.getImages());
			sku.setIsShow(product.getIsShow());
			sku.setStorageName(storage.getName());
			sku.setProductName(product.getName());
			sku.setNum(shopcart.getNum());
			skus.add(sku);			
		}
		return skus;
	}
	
	@RequestMapping("changenum.do")
	public String changenum(int skuId,int num) {
		Shopcart shopcart=new Shopcart();
		shopcart.setId(1);
		shopcart.setSkuId(skuId);
		shopcart.setNum(num);
		shopcartService.update(shopcart);
		return null;
	}
	@RequestMapping("calculate.do")
	public BigDecimal calculate(int []idList) {
		System.out.println(idList);
		ShopcartExample example=new ShopcartExample();
		List<Shopcart>shopcarts=shopcartService.getShopcarts(example);
		BigDecimal price=new BigDecimal(0);
		Sku sku=new Sku();
		for(Integer id:idList) {
			for(Shopcart shopcart:shopcarts ) {
				if(shopcart.getSkuId()==id) {
					sku=skuService.getSkuById(id);
					price=price.add(sku.getPrice().multiply((new BigDecimal(shopcart.getNum()))));
				}
			}
		}
		return price;
	}
	@RequestMapping("getSelectsku.do")
	public List<Sku>getSelectsku(String idList){
		System.out.println(idList);
		List<Integer>skusIdIntegers=new ArrayList<>();
		String []skusId=idList.split(",");
		for(String id:skusId) {
			System.out.println(id);
			skusIdIntegers.add(Integer.valueOf(id));
		}
		ShopcartExample example=new ShopcartExample();
		/*List<Integer>skusId=new ArrayList<Integer>();
		for(int id:idList) {
			skusId.add(id);
		}*/		
		example.createCriteria().andSkuIdIn(skusIdIntegers);
		List<Sku>skus=this.getSkuByExample(example);
		return skus;
	}
	@RequestMapping("payOrder.do")
	public String payOrder(String info) {
		Userinfo userinfo=JSON.parseObject(info,Userinfo.class);
		int id=userservice.add(userinfo);
		return String.valueOf(id);
	}
	@RequestMapping("getInfo.do")
	public Userinfo getInfo(int id) {
		Userinfo userinfo=userservice.getUserinfoById(id);
		return userinfo;
	}
	@RequestMapping("del.do")
	public String delSkucart(int id) {
		ShopcartKey key=new ShopcartKey();
		key.setId(1);
		key.setSkuId(Integer.valueOf(id));
		shopcartService.del(key);
		return "";
	}
}
