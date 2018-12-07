package com.neuedu.service;

import java.math.BigDecimal;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.pagehelper.PageHelper;
import com.neuedu.dao.ProductMapper;
import com.neuedu.pojo.Product;
import com.neuedu.pojo.ProductExample;
import com.neuedu.pojo.ProductWithBLOBs;
import com.neuedu.pojo.Sku;
import com.neuedu.pojo.productQuery;

@Service
public class ProductServiceImpI implements IproductService {
	@Resource
	ProductMapper productmapper;
	@Resource
	IskuService skuService;

	@Override
	@Transactional
	public int add(ProductWithBLOBs productWithBLOBs) {
		int result=0;
		result+=productmapper.insertSelective(productWithBLOBs);
		System.out.println("productid="+productWithBLOBs.getId());
		String []storages=productWithBLOBs.getStorageList().split(",");
		String []colors=productWithBLOBs.getColorList().split(",");
		Sku sku=new Sku();
		for(String storage:storages) {
			for(String color:colors) {				
				sku.setColorId(Integer.valueOf(color));
				sku.setStorageId(Integer.valueOf(storage));
				sku.setOriginalPrice(productWithBLOBs.getPrice());
				sku.setPrice(productWithBLOBs.getPrice().multiply(new BigDecimal(0.6)));
				sku.setSales(productWithBLOBs.getSales());
				sku.setSort(1);
				sku.setStock(100);
				sku.setProductId(productWithBLOBs.getId());
				result+=skuService.add(sku);
			}
		}
		return result;
	}

	@Override
	public List<ProductWithBLOBs> getProducts(Product product, ProductExample productExample) {
		if (product.getWithPage() == 1) {
			PageHelper.startPage(product.getPageNo(), product.getPageSize());
		}
		return productmapper.selectByExampleWithBLOBs(productExample);
	}

	@Override
	public ProductWithBLOBs getProductsByID(int id) {
		return productmapper.selectByPrimaryKey(id);
	}

	@Override
	public int updateProduct(ProductWithBLOBs product) {
		return productmapper.updateByPrimaryKeySelective(product);
	}

	@Override
	public List<ProductWithBLOBs> search(productQuery productQuery) {
		productQuery.setWithPage(0);
		if(productQuery.getWithPage()==1) {
			PageHelper.startPage(productQuery.getPageNo(),productQuery.getPageSize());
		}		
		return productmapper.search(productQuery);
	}

	

}
