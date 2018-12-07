package com.neuedu.controller;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.alibaba.fastjson.JSONObject;
import com.github.pagehelper.Page;
import com.neuedu.pojo.Brand;
import com.neuedu.pojo.BrandExample;
import com.neuedu.pojo.Color;
import com.neuedu.pojo.ColorExample;
import com.neuedu.pojo.ProductExample;
import com.neuedu.pojo.ProductExample.Criteria;
import com.neuedu.pojo.ProductWithBLOBs;
import com.neuedu.pojo.Shopcart;
import com.neuedu.pojo.ShopcartExample;
import com.neuedu.pojo.Sku;
import com.neuedu.pojo.SkuExample;
import com.neuedu.pojo.Storage;
import com.neuedu.pojo.StorageExample;
import com.neuedu.service.IbrandService;
import com.neuedu.service.IcolorService;
import com.neuedu.service.IproductService;
import com.neuedu.service.IshopcartService;
import com.neuedu.service.IskuService;
import com.neuedu.service.IstorageService;
import com.neuedu.utils.Myutils;

@Controller
@RequestMapping("/product")
public class ProductController {
	@Resource
	IbrandService brandservice;
	@Resource
	IstorageService storageservice;
	@Resource
	IcolorService colorservice;
	@Resource
	IproductService productservice;
	@Resource
	IskuService skuservice;
	@Resource
	IshopcartService shopcartservice;
	

	@RequestMapping(value = "/list.do", method = RequestMethod.GET)
	public String list(ProductWithBLOBs product, ModelMap map) {
		ProductExample example = new ProductExample();
		example.setOrderByClause("sort desc");
		StringBuilder params = new StringBuilder();
		Criteria criteria = example.createCriteria();
		if (StringUtils.isNotBlank(product.getName())) {
			criteria.andNameLike("%" + product.getName() + "%");
			params.append("&name=" + product.getName().trim());
		}
		Page<ProductWithBLOBs> products = (Page<ProductWithBLOBs>) productservice.getProducts(product, example);
		/* 查询商品对应的品牌 */
		/* 查询商品预览图 */
		List<String> brandsName = new ArrayList<String>();
		Brand brand = null;
		String imgView = null;
		for (ProductWithBLOBs productWithBLOBs : products) {
			brand = brandservice.getBrandByID(productWithBLOBs.getBrandId());
			imgView = productWithBLOBs.getImages().split(" ")[0];
			productWithBLOBs.setImages(imgView);
			brandsName.add(brand.getName());
		}
		product.setUrl("list.do");
		product.setPages(products.getPages());
		product.setParams(params.toString());
		map.addAttribute("product", product);
		map.addAttribute("brandsName", brandsName);
		map.addAttribute("products", products);
		return "product/list";
	}

	@RequestMapping(value = "/add.do", method = RequestMethod.GET)
	public String goAdd(ModelMap map) {
		/* 查询品牌列表 */
		Brand brand = new Brand();
		brand.setWithPage(0);
		BrandExample brandExample = new BrandExample();
		brandExample.createCriteria().andIsDelEqualTo(1);
		List<Brand> brands = brandservice.query(brand, brandExample);
		/* 查询内存列表 */
		StorageExample sExample = new StorageExample();
		sExample.createCriteria().andIsDelEqualTo(1);
		List<Storage> storages = storageservice.getsStorages(sExample);
		/* 查询颜色列表 */
		ColorExample colorExample = new ColorExample();
		colorExample.createCriteria().andIsDelEqualTo(1);
		List<Color> colors = colorservice.getColors(colorExample);

		map.addAttribute("colors", colors);
		map.addAttribute("storages", storages);
		map.addAttribute("brands", brands);
		return "product/add";
	}

	@RequestMapping(value = "upload.do")
	@ResponseBody
	public String upload(MultipartFile imgFile) {
		JSONObject json = new JSONObject();
		System.out.println("进入upload方法" + imgFile.getOriginalFilename());
		String str = null;
		try {
			str = Myutils.upload(imgFile);
			json.put("error", 0);
			json.put("url", Myutils.IMGSERVER + str);
		} catch (Exception e) {
			json.put("error", 1);
			json.put("message", "上传错误");
			e.printStackTrace();
		}
		return json.toJSONString();
	}

	@RequestMapping(value = "/add.do", method = RequestMethod.POST)
	public String doAdd(ProductWithBLOBs product, @RequestParam("image") MultipartFile[] image) {
		System.out.println(product.toString());
		StringBuilder images = new StringBuilder();
		String str = null;
		for (int i = 0; i < image.length; i++) {
			try {
				str = Myutils.upload(image[i]);
			} catch (Exception e) {
				e.printStackTrace();
			}
			images.append(str + " ");
		}
		System.out.println(images);
		product.setImages(images.toString());
		productservice.add(product);
		return "redirect:list.do";
	}

	@RequestMapping(value = "/update.do", method = RequestMethod.GET)
	public String goUpdate(int id, ModelMap map) {
		ProductWithBLOBs productWithBLOBs = productservice.getProductsByID(id);
		String []oldImages=productWithBLOBs.getImages().split(" ");
		String []selectedColors=productWithBLOBs.getColorList().split(",");
		String []selectedStorages=productWithBLOBs.getStorageList().split(",");
		map.addAttribute("product", productWithBLOBs);
		/* 查询品牌列表 */
		Brand brand = new Brand();
		brand.setWithPage(0);
		BrandExample brandExample = new BrandExample();
		brandExample.createCriteria().andIsDelEqualTo(1);
		List<Brand> brands = brandservice.query(brand, brandExample);
		/* 查询内存列表 */
		StorageExample sExample = new StorageExample();
		sExample.createCriteria().andIsDelEqualTo(1);
		List<Storage> storages = storageservice.getsStorages(sExample);
		/* 查询颜色列表 */
		ColorExample colorExample = new ColorExample();
		colorExample.createCriteria().andIsDelEqualTo(1);
		List<Color> colors = colorservice.getColors(colorExample);
		map.addAttribute("oldImages", oldImages);
		map.addAttribute("selectedColors",selectedColors);
		map.addAttribute("selectedStorages", selectedStorages);
		map.addAttribute("colors", colors);
		map.addAttribute("storages", storages);
		map.addAttribute("brands", brands);
		return "product/update";
	}

	@RequestMapping(value="/update.do",method=RequestMethod.POST)
	public String doUpdate(HttpServletRequest request,ProductWithBLOBs product, @RequestParam("image") MultipartFile[] image) {
		String oldImg=request.getParameter("oldImg");
		System.out.println("oldImg:"+oldImg);
		ProductWithBLOBs oldProduct=productservice.getProductsByID(product.getId());
		String str=null;
		StringBuilder images = new StringBuilder();//存放上传的images
		if(oldProduct.getImages().equals(oldImg)) {
			System.out.println("true");
			images.append(oldImg);
		}else {
			System.out.println("false");
			for(int i=0;i<image.length;i++) {
				try {
					str=Myutils.upload(image[i]);
					images.append(str+" ");
				} catch (Exception e) {
					e.printStackTrace();
				}
			}						
		}
		product.setImages(images.toString());
		//System.out.println(product.toString());
		productservice.updateProduct(product);
		return "redirect:list.do";
	}
	@RequestMapping(value="/del.do",method=RequestMethod.GET)
	public String doDel(int id) {
		System.out.println("进入del方法");
		ProductWithBLOBs productWithBLOBs=productservice.getProductsByID(id);
		productWithBLOBs.setIsDel(0);
		productservice.updateProduct(productWithBLOBs);
		return "redirect:list.do";
	}
	@RequestMapping("/details.do")
	public String details(int id,ModelMap map) {		
		map.addAttribute("id", id);
		return "product/product";
	}
	@RequestMapping("/getProduct.do")
	@ResponseBody
	public ProductWithBLOBs getProduct(int id) {
		ProductWithBLOBs productWithBLOBs= productservice.getProductsByID(id);
		ColorExample colorExample=new ColorExample();
		StorageExample storageExample=new StorageExample();
		List<Integer> colors=new ArrayList<>();
		List<Integer> storages=new ArrayList<>();
		String[] colorarr= productWithBLOBs.getColorList().split(",");
		for (String string : colorarr) {
			colors.add(Integer.parseInt(string));
		}
		 colorExample.createCriteria().andIdIn(colors);
		 List<Color> colorlist=colorservice.getColors(colorExample);
		 String[] storagearr= productWithBLOBs.getStorageList().split(",");
		 for (String string : storagearr) {
			 storages.add(Integer.parseInt(string));
		}
		 storageExample.createCriteria().andIdIn(storages);
		 List<Storage> storagelist=storageservice.getsStorages(storageExample);
		 productWithBLOBs.setColors(colorlist);
		 productWithBLOBs.setStorages(storagelist);
		SkuExample skuExample=new SkuExample();
		skuExample.createCriteria().andProductIdEqualTo(id);
		List<Sku> skus= skuservice.getSkus(skuExample);
		productWithBLOBs.setSkus(skus);		
		return productWithBLOBs;
	}
	@RequestMapping("/up.do")
	public String getUp(ProductWithBLOBs product) {
		if(product.getIsShow()==1) {
			product.setIsShow(0);
		}
		else {
			product.setIsShow(1);
		}
		productservice.updateProduct(product);
		return "redirect:list.do";
	}
	

}
