package com.neuedu.service;

import java.util.List;

import com.neuedu.pojo.Product;
import com.neuedu.pojo.ProductExample;
import com.neuedu.pojo.ProductWithBLOBs;
import com.neuedu.pojo.productQuery;

public interface IproductService {
	public List<ProductWithBLOBs>getProducts(Product product,ProductExample productExample);
	public int add(ProductWithBLOBs productWithBLOBs);
	public ProductWithBLOBs getProductsByID(int id);
	public int updateProduct(ProductWithBLOBs product);
	public List<ProductWithBLOBs> search(productQuery productQuery);


}
