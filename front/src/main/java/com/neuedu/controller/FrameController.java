package com.neuedu.controller;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.websocket.Session;

import org.apache.catalina.tribes.tipis.AbstractReplicatedMap.MapOwner;
import org.apache.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import com.neuedu.pojo.Shopcart;
import com.neuedu.pojo.ShopcartKey;
import com.neuedu.pojo.Sku;
import com.neuedu.service.IshopcartService;
import com.neuedu.service.IskuService;


@Controller
public class FrameController {
	@Resource
	IskuService skuservice;
	@Resource
	IshopcartService shopservice;
	
	@RequestMapping("/index.do")
	public String index(){
		return "index";
	} 	
	@RequestMapping("/getProduct.do")
	public String getProduct(int id,ModelMap map) {
		map.addAttribute("id", id);
		return "product";
	}
	@RequestMapping("/goShopcart.do")
	public String goShopCart(int skuId,int num,String productName,ModelMap map) {
		Sku sku=skuservice.getSkuById(skuId);
		Shopcart shopcart=new Shopcart();
		shopcart.setId(1);
		shopcart.setSkuId(skuId);
		shopcart.setNum(num);
		shopcart.setProductName(productName);
		shopservice.add(shopcart);
		//map.addAttribute("sku", sku);
		//map.addAttribute("shopcart", shopcart);
		//map.addAttribute("num", num);
		return "redirect:shopcart.do";
	}
	@RequestMapping("shopcart.do")
	public String shopcart() {
		return "shopcart";
	}
	@RequestMapping("pay.do")
	public String pay(int []idList,ModelMap map) {		
		List<Integer>skusId=new ArrayList<Integer>();
		StringBuilder stringBuilder=new StringBuilder();
		for(int id:idList) {
			stringBuilder.append(id+",");
		}
		map.addAttribute("idList", stringBuilder.toString());
		return "pay";
	}
	@RequestMapping("success.do")
	public String success(BigDecimal money,String checkId,HttpServletRequest request,Integer id) {
		HttpSession session=request.getSession();
		session.setAttribute("money", money);
		String []idList=checkId.split(",");

		ShopcartKey key=new ShopcartKey();
		for(String id2:idList) {
			key.setId(1);
			key.setSkuId(Integer.valueOf(id2));
			shopservice.del(key);
		}
		//map.addAttribute("checkId", checkId);

		session.setAttribute("id", id);
		return "redirect:goSuccess.do";
	}
	@RequestMapping("goSuccess.do")
	public String goSuccess() {
		return "success";
	}
	

}
