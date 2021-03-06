<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="/WEB-INF/common/Head.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">

<title>购物车页面</title>

<link href="${resourceServer }/AmazeUI-2.4.2/assets/css/amazeui.css"
	rel="stylesheet" type="text/css" />
<link href="${resourceServer }/basic/css/demo.css" rel="stylesheet"
	type="text/css" />
<link href="${resourceServer }/css/cartstyle.css" rel="stylesheet"
	type="text/css" />
<link href="${resourceServer }/css/optstyle.css" rel="stylesheet"
	type="text/css" />

<script type="text/javascript" src="${resourceServer }/js/jquery.js"></script>
<script type="text/javascript" src="${resourceServer }/js/vue.min.js"></script>
	<style>
[v-cloak] {
	display: none;
}
</style>
</head>

<body>
	<div id="app" v-cloak>

		<!--顶部导航条 -->
		<div class="am-container header">
			<ul class="message-l">
				<div class="topMessage">
					<div class="menu-hd">
						<a href="#" target="_top" class="h">亲，请登录</a> <a href="#"
							target="_top">免费注册</a>
					</div>
				</div>
			</ul>
			<ul class="message-r">
				<div class="topMessage home">
					<div class="menu-hd">
						<a href="${basepath }/index.do" target="_top" class="h">商城首页</a>
					</div>
				</div>
				<div class="topMessage my-shangcheng">
					<div class="menu-hd MyShangcheng">
						<a href="#" target="_top"><i class="am-icon-user am-icon-fw"></i>个人中心</a>
					</div>
				</div>
				<div class="topMessage mini-cart">
					<div class="menu-hd">
						<a id="mc-menu-hd" href="#" target="_top"><i
							class="am-icon-shopping-cart  am-icon-fw"></i><span>购物车</span><strong
							id="J_MiniCartNum" class="h">0</strong></a>
					</div>
				</div>
				<div class="topMessage favorite">
					<div class="menu-hd">
						<a href="#" target="_top"><i class="am-icon-heart am-icon-fw"></i><span>收藏夹</span></a>
					</div>
			</ul>
		</div>

		<!--悬浮搜索框-->

		<div class="nav white">
			<div class="logo">
				<img src="${resourceServer }/images/logo.png" />
			</div>
			<div class="logoBig">
				<li><img src="${resourceServer }/images/logobig.png" /></li>
			</div>

			<div class="search-bar pr">
				<a name="index_none_header_sysc" href="#"></a>
				<form>
					<input id="searchInput" name="index_none_header_sysc" type="text"
						placeholder="搜索" autocomplete="off"> <input
						id="ai-topsearch" class="submit am-btn" value="搜索" index="1"
						type="submit">
				</form>
			</div>
		</div>

		<div class="clear"></div>

		<!--购物车 -->
		<div class="concent">
			<div id="cartTable">
				<div class="cart-table-th">
					<div class="wp">
						<div class="th th-chk">
							<div id="J_SelectAll1" class="select-all J_SelectAll"></div>
						</div>
						<div class="th th-item">
							<div class="td-inner">商品信息</div>
						</div>
						<div class="th th-price">
							<div class="td-inner">单价</div>
						</div>
						<div class="th th-amount">
							<div class="td-inner">数量</div>
						</div>
						<div class="th th-sum">
							<div class="td-inner">金额</div>
						</div>
						<div class="th th-op">
							<div class="td-inner">操作</div>
						</div>
					</div>
				</div>
				<div class="clear"></div>
				<template v-for="(sku,index) in skus">
				<tr class="item-list">
					<div class="bundle  bundle-last ">

						<div class="clear"></div>
						<div class="bundle-main">
							<ul class="item-content clearfix">
								<li class="td td-chk">
									<div class="cart-checkbox ">
										<input class="check" id="" name="items[]" :value="sku.id"
											type="checkbox" v-model="checkId" @click="calculate()" v-show="sku.isShow==1">
										<!-- <label for="J_CheckBox_170037950254"></label> -->
									</div>
								</li>
								<li class="td td-item">
									<div class="item-pic">
										<a :href="'${basepath }/getProduct.do?id='+sku.productId"
											target="_blank" data-title="" class="J_MakePoint"
											data-point="tbcart.8.12"> <img
											:src="'http://172.18.0.27/'+defaultImg(sku.image)"
											class="itempic J_ItemImg" height="80" width="80"></a>
									</div>
									<div class="item-info">
										<div class="item-basic-info">
											<a :href="'${basepath }/getProduct.do?id='+sku.productId"
												target="_blank" title="" class="item-title J_MakePoint"
												data-point="tbcart.8.11">{{sku.productName}}</a>
												<div v-show="sku.isShow==0">已失效</div>
										</div>
									</div>
								</li>
								<li class="td td-info">
									<div class="item-props item-props-can">
										<span class="sku-line" value="">{{sku.colorName}}</span> <span
											class="sku-line">{{sku.storageName}}</span>
										<!-- <span tabindex="0" class="btn-edit-sku theme-login">修改</span>  -->
										<i class="theme-login am-icon-sort-desc"></i>
									</div>
								</li>
								<li class="td td-price">
									<div class="item-price price-promo-promo">
										<div class="price-content">
											<div class="price-line">
												<em class="price-original">{{sku.originalPrice}}</em>
											</div>
											<div class="price-line">
												<em class="J_Price price-now" tabindex="0">{{sku.price}}</em>
											</div>
										</div>
									</div>
								</li>
								<li class="td td-amount">
									<div class="amount-wrapper ">
										<div class="item-amount ">
											<div class="sl">
												<input class="am-btn" name="" type="button" value="-" @click="min(index,sku.id,sku.num)" />
												<input class="text_box" name="" type="text" value=""
													v-model.lazy="sku.num" style="width: 30px;"
													@change="numChange(index,sku.num)" /> <input
													class="am-btn" name="" type="button" value="+" @click="add(index,sku.id,sku.num)" />
											</div>
										</div>
									</div>
								</li>
								<li class="td td-sum">
									<div class="td-inner">
										<em tabindex="0" class="J_ItemSum number">{{sku.price*sku.num|numFilter}}</em>
									</div>
								</li>
								<li class="td td-op">
									<div class="td-inner">
										<!-- <a title="移入收藏夹" class="btn-fav" href="#"> 移入收藏夹</a> --> 
										<a href="javascript:void(0)" data-point-url="#" class="" @click="del(sku.id)">
											删除</a>
									</div>
								</li>
							</ul>



						</div>
					</div>
				</tr>
				</template>
				<div class="clear"></div>


			</div>
			<div class="clear"></div>

			<div class="float-bar-wrapper">
				<div id="J_SelectAll2" class="select-all J_SelectAll">
					<div class="cart-checkbox">
						<input class="check-all check" id="J_SelectAllCbx2"
							name="select-all" value="true" type="checkbox"> <label
							for="J_SelectAllCbx2"></label>
					</div>
					<span>全选</span>
				</div>
				<div class="operations">
					<!-- <a href="javascript:void(0)" hidefocus="true" class="" >删除</a> <a href="#"
						hidefocus="true" class="J_BatchFav">移入收藏夹</a> -->
				</div>
				<div class="float-bar-right">
					<div class="amount-sum">
						<!-- <span class="txt">已选商品</span> <em id="J_SelectedItemsCount">0</em><span
							class="txt">件</span> -->
						<div class="arrow-box">
							<span class="selected-items-arrow"></span> <span class="arrow"></span>
						</div>
					</div>
					<div class="price-sum">
						<span class="txt">合计:</span> <strong class="price"> ¥<em
							id="" :value="allPrices">{{allPrices|numFilter}}</em></strong>
					</div>
					<div class="btn-area">
						<a href="javascript:void(0)" id="J_Go"
							class="submit-btn submit-btn-disabled" @click="pay()"
							aria-label="请注意如果没有选择宝贝，将无法结算"> <span>结&nbsp;算</span></a>
					</div>
				</div>

			</div>

			<div class="footer">
				<div class="footer-hd">
					<p>
						<a href="#">恒望科技</a> <b>|</b> <a href="#">商城首页</a> <b>|</b> <a
							href="#">支付宝</a> <b>|</b> <a href="#">物流</a>
					</p>
				</div>
				<div class="footer-bd">
					<p>
						<a href="#">关于恒望</a> <a href="#">合作伙伴</a> <a href="#">联系我们</a> <a
							href="#">网站地图</a> <em>© 2015-2025 Hengwang.com 版权所有. 更多模板 <a
							href="http://www.cssmoban.com/" target="_blank" title="模板之家">模板之家</a>
							- Collect from <a href="http://www.cssmoban.com/" title="网页模板"
							target="_blank">网页模板</a></em>
					</p>
				</div>
			</div>

		</div>

		<!--操作页面-->

		<!-- 		<div class="theme-popover-mask"></div>

		<div class="theme-popover">
			<div class="theme-span"></div>
			<div class="theme-poptit h-title">
				<a href="javascript:;" title="关闭" class="close">×</a>
			</div>
			<div class="theme-popbod dform">
				<form class="theme-signin" name="loginform" action="" method="post">


					<div class="theme-signin-left">

						<li class="theme-options">
							<div class="cart-title">颜色：</div>
							<ul>
								<li class="sku-line selected"><i></i></li>
								<li class="sku-line">10#蜜橘色+17#樱花粉<i></i></li>
							</ul>
						</li>
						<li class="theme-options">
							<div class="cart-title">包装：</div>
							<ul>
								<li class="sku-line selected">包装：裸装<i></i></li>
								<li class="sku-line">两支手袋装（送彩带）<i></i></li>
							</ul>
						</li>
						<div class="theme-options">
							<div class="cart-title number">数量</div>
							<dd>
								<input class="min am-btn am-btn-default" name="" type="button"
									value="-" /> <input class="text_box" name="" type="text"
									:value="sku.num" style="width: 30px;" /> <input
									class="add am-btn am-btn-default" name="" type="button"
									value="+" /> <span class="tb-hidden">库存<span
									class="stock">1000</span>件
								</span>
							</dd>

						</div>
						<div class="clear"></div>
						<div class="btn-op">
							<div class="btn am-btn am-btn-warning">确认</div>
							<div class="btn close am-btn am-btn-warning">取消</div>
						</div>

					</div>

					<div class="theme-signin-right">
						<div class="img-info">
							<img src="../images/kouhong.jpg_80x80.jpg" />
						</div>
						<div class="text-info">
							<span class="J_Price price-now">¥39.00</span> <span id="Stock"
								class="tb-hidden">库存<span class="stock">1000</span>件
							</span>
						</div>
					</div>

				</form>
			</div>
		</div> -->
		<!--引导 -->
		<div class="navCir">
			<li><a href="home.html"><i class="am-icon-home "></i>首页</a></li>
			<li><a href="sort.html"><i class="am-icon-list"></i>分类</a></li>
			<li class="active"><a href="shopcart.html"><i
					class="am-icon-shopping-basket"></i>购物车</a></li>
			<li><a href="${resourceServer }/person/index.html"><i
					class="am-icon-user"></i>我的</a></li>
		</div>
	</div>
	<script type="text/javascript">
		var skuList;
		var product;
		
		$.ajax({
			url : "${basepath}/product/skucart.do",
			async : false,
			dataType : "json",
			type : "get",
			success : function(result) {
				skuList = result;
				console.log(skuList);
			}
		});

		var vue = new Vue({
			el : "#app",
			data : {
				skus : skuList,
				checkId : [],
				allPrices:0
			//sku:this.skus[0]
			},
			filters: {

				  numFilter(value) {

				  // 截取当前数据到小数点后三位

				    let realVal = Number(value).toFixed(3)

				    // num.toFixed(3)获取的是字符串

				    return Number(realVal)

				  }
			},
			/* computed : {
				allPrices : function() {
					checkId=this.checkId;
					console.log(checkId);
					var check_result;
					$.ajax({
						url : "${basepath}/product/calculate.do?idList="
								+ checkId,
						async : false,
						dataType : "json",
						type : "get",
						success : function(result) {
							check_result=result;
							
						}
					});
					return check_result;
				}
			}, */
			methods : {
				defaultImg : function(images) {
					return images.split(" ")[0];
				},
				numChange : function(id, number) {
					//this.skus[id].num=number;

					//console.log(id);
					//console.log(number);
					$.ajax({
						url : "${basepath}/product/changenum.do?skuId=" + id
								+ "&num=" + number,
						async : false,
						dataType : "json",
						type : "get",
						success : function(result) {
							console.log(result);
						}
					});
					for(var a=0;a<this.checkId.length;a++){
						if(this.checkId[a]==id){
						    this.calculate();
						}
					}
				},
				
			add:function(index,id,num){	
				this.skus[index].num=num+1;
				//console.log(this.skus[index].num);
				this.numChange(id,this.skus[index].num);
			},
			min:function(index,id,num){
				if(this.skus[index].num!=1){
					this.skus[index].num=num-1;
					//console.log(this.skus[index].num);
					this.numChange(id,this.skus[index].num);
				}				
			},
			calculate:function(){
				var checkId=this.checkId;
				var check_result;
				//console.log(checkId);
				var check_result;
				$.ajax({
					url : "${basepath}/product/calculate.do?idList="
							+ checkId,
					async : false,
					dataType : "json",
					type : "get",
					success : function(result) {
						check_result=result;
						
					}
				});
				this.allPrices=check_result;
			  },
			  pay:function(){
				  window.location.href="${basepath}/pay.do?idList="+this.checkId;
			  },
			  del:function(idx){
				  $.ajax({
					  url:"${basepath}/product/del.do",
					  data:{
						  id:idx
					  },
					  type:"get",					  
					  dataType:"json",
					  async:false,
					  success:function(result){
						  alert("success");
					  }
				  });
				  $.ajax({
						url : "${basepath}/product/skucart.do",
						async : false,
						dataType : "json",
						type : "get",
						success : function(result) {
							vue.skus=result;
							vue.checkId=[];
							vue.allPrices=0;
							
						}
					});
			  }
			}

		});
	</script>

</body>


</html>