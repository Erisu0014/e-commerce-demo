<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="/WEB-INF/common/Head.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1.0 ,minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">

<title>结算页面</title>

<link href="${resourceServer }/AmazeUI-2.4.2/assets/css/amazeui.css"
	rel="stylesheet" type="text/css" />

<link href="${resourceServer }/basic/css/demo.css" rel="stylesheet"
	type="text/css" />
<link href="${resourceServer }/css/cartstyle.css" rel="stylesheet"
	type="text/css" />

<link href="${resourceServer }/css/jsstyle.css" rel="stylesheet"
	type="text/css" />
<link href="${basepath }/alert/css/style.css" rel="stylesheet"
	type="text/css" />

<script type="text/javascript" src="${resourceServer }/js/address.js"></script>
<script type="text/javascript" src="${resourceServer }/js/jquery.js"></script>
<script type="text/javascript" src="${resourceServer }/js/vue.min.js"></script>
<script type="text/javascript" src="${basepath }/alert/js/ui.js"></script>
<style>
[v-cloak] {
	display: none
}
.fade-enter-active, .fade-leave-active {
  transition: opacity .5s;
}
.fade-enter, .fade-leave-to /* .fade-leave-active below version 2.1.8 */ {
  opacity: 0;
}
</style>

</head>
<body>
	<div id="app" v-cloak >
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
						<a href="#" target="_top" class="h">商城首页</a>
					</div>
				</div>
				<div class="topMessage my-shangcheng">
					<div class="menu-hd MyShangcheng">
						<a href="#" target="_top"><i class=" am-icon-fw"></i>个人中心</a>
					</div>
				</div>
				<div class="topMessage mini-cart">
					<div class="menu-hd">
						<a id="mc-menu-hd" href="#" target="_top"><i
							class="  am-icon-fw"></i><span>购物车</span><strong
							id="J_MiniCartNum" class="h"></strong></a>
					</div>
				</div>
				<div class="topMessage favorite">
					<div class="menu-hd">
						<a href="#" target="_top"><i class=" am-icon-fw"></i><span>收藏夹</span></a>
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
		<div class="concent">
			<!--地址 -->
			<div class="paycont">
				<div class="address">
					<h3>确认收货地址</h3>
					<div class="control">
						<div class="tc-btn createAddr theme-login am-btn am-btn-danger">添加新地址</div>
					</div>
					<div class="clear"></div>
					<ul>
						<div class="per-border"></div>
						<!-- defaultAddr -->
						 <transition name="fade">
						<li class="user-addresslist" v-if="bool">

							<div class="address-left">
								<div class="user DefaultAddr">

									<span class="buy-address-detail"> <span class="buy-user">{{info.usr}}
									</span> <span class="buy-phone">{{info.tel}}</span>
									</span>
								</div>
								<div class="default-address DefaultAddr">
									<span class="buy-line-title buy-line-title-type">收货地址：</span> <span
										class="buy--address-detail"> <span class="province">{{info.sheng}}</span>
										<span class="city">{{info.shi}}</span><span class="dist">{{info.xian}}</span>
										<span class="street">{{info.description}}</span>
									</span>
									<!--  </span> -->
								</div>
								<!-- 	<ins class="deftip">默认地址</ins> -->
							</div>
							<div class="address-right">
								<a href="${resourceServer }/person/address.html"> <span
									class="am-icon-angle-right am-icon-lg"></span></a>
							</div>
							<div class="clear"></div>

							<div class="new-addr-btn">
								<a href="javascript:void(0);" class="hidden">设为默认</a> <span
									class="am-btn am-btn-danger close new-addr-bar hidden">|</span>
								<a href="javascript:void(0);">编辑</a> <span class="new-addr-bar">|</span>
								<a href="javascript:void(0);" @click="del()">删除</a>
							</div>

						</li>
						</transition>
						<div class="per-border"></div>
						<!-- <li class="user-addresslist">
							<div class="address-left">
								<div class="user DefaultAddr">

									<span class="buy-address-detail"> <span class="buy-user">艾迪
									</span> <span class="buy-phone">15871145629</span>
									</span>
								</div>
								<div class="default-address DefaultAddr">
									<span class="buy-line-title buy-line-title-type">收货地址：</span> <span
										class="buy--address-detail"> <span class="province">湖北</span>省
										<span class="city">武汉</span>市 <span class="dist">武昌</span>区 <span
										class="street">东湖路75号众环大厦2栋9层902</span>
									</span> </span>
								</div>
								<ins class="deftip hidden">默认地址</ins>
							</div>
							<div class="address-right">
								<span class="am-icon-angle-right am-icon-lg"></span>
							</div>
							<div class="clear"></div>

							<div class="new-addr-btn">
								<a href="#">设为默认</a> <span class="new-addr-bar">|</span> <a
									href="#">编辑</a> <span class="new-addr-bar">|</span> <a
									href="javascript:void(0);" onclick="delClick(this);">删除</a>
							</div>

						</li> -->

					</ul>

					<div class="clear"></div>
				</div>
				<!--物流 -->
				<div class="logistics">
					<h3>选择物流方式</h3>
					<ul class="op_express_delivery_hot">
						<li data-value="yuantong" class="OP_LOG_BTN  "><i
							class="c-gap-right" style="background-position: 0px -468px"></i>圆通<span></span></li>
						<li data-value="shentong" class="OP_LOG_BTN  "><i
							class="c-gap-right" style="background-position: 0px -1008px"></i>申通<span></span></li>
						<li data-value="yunda" class="OP_LOG_BTN  "><i
							class="c-gap-right" style="background-position: 0px -576px"></i>韵达<span></span></li>
						<li data-value="zhongtong"
							class="OP_LOG_BTN op_express_delivery_hot_last "><i
							class="c-gap-right" style="background-position: 0px -324px"></i>中通<span></span></li>
						<li data-value="shunfeng"
							class="OP_LOG_BTN  op_express_delivery_hot_bottom"><i
							class="c-gap-right" style="background-position: 0px -180px"></i>顺丰<span></span></li>
					</ul>
				</div>
				<div class="clear"></div>

				<!--支付方式-->
				<div class="logistics">
					<h3>选择支付方式</h3>
					<ul class="pay-list">
						<li class="pay card"><img
							src="${resourceServer }/images/wangyin.jpg" />银联<span></span></li>
						<li class="pay qq"><img
							src="${resourceServer }/images/weizhifu.jpg" />微信<span></span></li>
						<li class="pay taobao"><img
							src="${resourceServer }/images/zhifubao.jpg" />支付宝<span></span></li>
					</ul>
				</div>
				<div class="clear"></div>

				<!--订单 -->
				<div class="concent">
					<div id="payTable">
						<h3>确认订单信息</h3>
						<div class="cart-table-th">
							<div class="wp">

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
								<div class="th th-oplist">
									<div class="td-inner">配送方式</div>
								</div>

							</div>
						</div>
						<div class="clear"></div>
						<template v-for="(sku,index) in skuList">
						<tr class="item-list">
							<div class="bundle  bundle-last">

								<div class="bundle-main">
									<ul class="item-content clearfix">
										<div class="pay-phone">
											<li class="td td-item">
												<div class="item-pic">
													<a href="#" class="J_MakePoint"> <img
														:src="'http://172.18.0.27/'+defaultImg(sku.image)"
														height="80" width="80" class="itempic J_ItemImg"></a>
												</div>
												<div class="item-info">
													<div class="item-basic-info">
														<a href="'${basepath }/getProduct.do?id='+sku.productId"
															class="item-title J_MakePoint" data-point="tbcart.8.11">{{sku.productName}}</a>
													</div>
												</div>
											</li>
											<li class="td td-info">
												<div class="item-props">
													<span class="sku-line">颜色：{{sku.colorName}}</span> <span
														class="sku-line">包装：裸装</span>
												</div>
											</li>
											<li class="td td-price">
												<div class="item-price price-promo-promo">
													<div class="price-content">
														<em class="J_Price price-now">{{sku.price}}</em>
													</div>
												</div>
											</li>
										</div>
										<li class="td td-amount">
											<div class="amount-wrapper ">
												<div class="item-amount ">
													<span class="phone-title">购买数量</span>
													<div class="sl">
														<input class="min am-btn" name="" type="button" value="-" />
														<input class="text_box" name="" type="text"
															:value="sku.num" style="width: 30px;" /> <input
															class="add am-btn" name="" type="button" value="+" />
													</div>
												</div>
											</div>
										</li>
										<li class="td td-sum">
											<div class="td-inner">
												<em tabindex="0" class="J_ItemSum number">{{sku.price*sku.num+sku.freight|numFilter
													}}</em>
											</div>
										</li>
										<li class="td td-oplist">
											<div class="td-inner">
												<span class="phone-title">配送方式</span>
												<div class="pay-logis">
													快递<b class="sys_item_freprice">{{sku.freight }}</b>元
												</div>
											</div>
										</li>

									</ul>
									<div class="clear"></div>

								</div>
						</tr>
						</template>
						<div class="clear"></div>
					</div>


				</div>
				<div class="clear"></div>
				<div class="pay-total">
					<!--留言-->
					<div class="order-extra">
						<div class="order-user-info">
							<div id="holyshit257" class="memo">
								<label>买家留言：</label> <input type="text"
									title="选填,对本次交易的说明（建议填写已经和卖家达成一致的说明）"
									placeholder="选填,建议填写和卖家达成一致的说明"
									class="memo-input J_MakePoint c2c-text-default memo-close">
								<div class="msg hidden J-msg">
									<p class="error">最多输入500个字符</p>
								</div>
							</div>
						</div>

					</div>
					<!--优惠券 -->
					<!-- <div class="buy-agio">
						<li class="td td-coupon"><span class="coupon-title">优惠券</span>
							<select data-am-selected>
								<option value="a">
									<div class="c-price">
										<strong>￥8</strong>
									</div>
									<div class="c-limit">【消费满95元可用】</div>
								</option>
								<option value="b" selected>
									<div class="c-price">
										<strong>￥3</strong>
									</div>
									<div class="c-limit">【无使用门槛】</div>
								</option>
						</select></li>

						<li class="td td-bonus"><span class="bonus-title">红包</span> <select
							data-am-selected>
								<option value="a">
									<div class="item-info">
										¥50.00<span>元</span>
									</div>
									<div class="item-remainderprice">
										<span>还剩</span>10.40<span>元</span>
									</div>
								</option>
								<option value="b" selected>
									<div class="item-info">
										¥50.00<span>元</span>
									</div>
									<div class="item-remainderprice">
										<span>还剩</span>50.00<span>元</span>
									</div>
								</option>
						</select></li>

					</div> -->
					<div class="clear"></div>
				</div>
				<!--含运费小计 -->
				<div class="buy-point-discharge ">
					<p class="price g_price ">
						合计（含运费） <span>¥</span><em class="pay-sum">{{money|numFilter}}</em>
					</p>
				</div>

				<!--信息 -->
				<div class="order-go clearfix">
					<div class="pay-confirm clearfix">
						<div class="box">
							<div tabindex="0" id="holyshit267" class="realPay">
								<em class="t">实付款：</em> <span class="price g_price "> <span>¥</span>
									<em class="style-large-bold-red " id="J_ActualFee">{{money|numFilter}}</em>
								</span>
							</div>

							<div id="holyshit268" class="pay-address">

								<p class="buy-footer-address">
									<span class="buy-line-title buy-line-title-type">寄送至：</span> <span
										class="buy--address-detail"> <span class="province">{{info.sheng}}</span>
										<span class="city">{{info.shi}}</span> <span class="dist">{{info.xian}}</span>
										<span class="street">{{info.description}}</span>
									</span> </span>
								</p>
								<p class="buy-footer-address">
									<span class="buy-line-title">收货人：</span> <span
										class="buy-address-detail"> <span class="buy-user">{{info.usr}}
									</span> <span class="buy-phone">{{info.tel}}</span>
									</span>
								</p>
							</div>
						</div>

						<div id="holyshit269" class="submitOrder">
							<div class="go-btn-wrap">
								<a id="J_Go" href="javascript:void(0)" class="btn-go"
									tabindex="0" title="点击此按钮，提交订单" @click="payOrder">提交订单</a>
							</div>
						</div>
						<div class="clear"></div>
					</div>
				</div>
			</div>

			<div class="clear"></div>
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

		<div class="theme-popover-mask"></div>
		<div class="theme-popover">

			<!--标题 -->
			<div class="am-cf am-padding">
				<div class="am-fl am-cf">
					<strong class="am-text-danger am-text-lg">新增地址</strong> / <small>Add
						address</small>
				</div>
			</div>
			<hr />

			<div class="am-u-md-12">
				<form class="am-form am-form-horizontal">

					<div class="am-form-group">
						<label for="user-name" class="am-form-label">收货人</label>
						<div class="am-form-content">
							<input type="text" id="user-name" placeholder="收货人" v-model="usr"
								value="">
						</div>
					</div>

					<div class="am-form-group">
						<label for="user-phone" class="am-form-label">手机号码</label>
						<div class="am-form-content">
							<input id="user-phone" placeholder="手机号必填" v-model="tel" value="">
						</div>
					</div>

					<div class="am-form-group">
						<label for="user-phone" class="am-form-label">所在地</label>
						<!-- <div class="am-form-content address">
							<select data-am-selected>
								<option value="a">浙江省</option>
								<option value="b">湖北省</option>
							</select> <select data-am-selected>
								<option value="a">温州市</option>
								<option value="b">武汉市</option>
							</select> <select data-am-selected>
								<option value="a">瑞安区</option>
								<option value="b">洪山区</option>
							</select>
						</div> -->
						<div class="am-form-content address">
							<select style="height: 30px;" @change="changesheng()"
								v-model="selectedsheng">
								<template v-for="sheng in area">
								<option :value="sheng">{{sheng.cityname}}</option>
								</template>
							</select> <select style="height: 30px;" @change="changeshi()"
								v-model="selectedshi">
								<template v-for="s in shi">
								<option :value="s">{{s.cityname}}</option>
								</template>
							</select> <select style="height: 30px;" @change="changexian()"
								v-model="selectedxian">
								<template v-for="x in xian">
								<option :value="x">{{x.cityname}}</option>
								</template>
							</select>
						</div>
					</div>

					<div class="am-form-group">
						<label for="user-intro" class="am-form-label">详细地址</label>
						<div class="am-form-content">
							<textarea class="" rows="3" id="user-intro" placeholder="输入详细地址"
								v-model="description" value=""></textarea>
							<small>100字以内写出你的详细地址...</small>
						</div>
					</div>

					<div class="am-form-group theme-poptit">
						<div class="am-u-sm-9 am-u-sm-push-3">
							<div class="am-btn am-btn-danger close" @click="save()">保存</div>
							<div class="am-btn am-btn-danger close">取消</div>
						</div>
					</div>
				</form>
			</div>

		</div>

		<div class="clear"></div>
	</div>
	<script type="text/javascript">
		var skuList;
		var area;
		console.log("${idList}");

		$.ajax({
			url : "${basepath}/product/getSelectsku.do?idList=${idList}",
			dataType : "json",
			async : false,
			type : "get",
			success : function(result) {
				skuList = result;
				console.log(skuList);
			}
		});
		$.ajax({
			url : "${basepath}/area/list.do",
			type : "get",
			dataType : "json",
			async : false,
			success : function(data) {
				area = data;
			}
		});
		var vue = new Vue({
			el : "#app",
			data : {
				skuList : skuList,
				checkId : 0,
				area : area,
				shi : area[0].children,
				xian : area[0].children[0].children,
				selectedsheng : area[0],
				selectedshi : area[0].children[0],
				selectedxian : area[0].children[0].children[0],
				usr : null,
				tel : null,
				description : null,
				info : {
					sheng : null,
					shi : null,
					xian : null,
					usr : null,
					tel : null,
					description : null
				},
				bool : false
			},
			computed : {
				money : function() {
					var money = 0;
					for (var i = 0; i < this.skuList.length; i++) {
						money += skuList[i].price * skuList[i].num
								+ skuList[i].freight;
					}
					return money;
				}
			},
			filters: {

				  numFilter(value) {

				  // 截取当前数据到小数点后三位

				    let realVal = Number(value).toFixed(3)

				    // num.toFixed(3)获取的是字符串

				    return Number(realVal)

				  }
			},
			methods : {
				defaultImg : function(images) {
					return images.split(" ")[0];
				},
				save : function() {
					//alert(this.tel);
					this.info.sheng = this.selectedsheng.cityname;
					this.info.shi = this.selectedshi.cityname;
					this.info.xian = this.selectedxian.cityname;
					this.info.usr = this.usr;
					this.info.tel = this.tel;
					this.info.description = this.description;
					console.log(this.info);
					this.bool = true;
				},
				changesheng : function() {
					//alert(this.selectedsheng.codeid);
					for (var i = 0; i < this.area.length; i++) {
						if (this.selectedsheng.codeid == this.area[i].codeid) {
							this.shi = this.area[i].children;
							this.selectedshi = this.area[i].children[0];
							this.xian = this.area[i].children[0].children;
							this.selectedxian = this.xian[0];
							console.log(this.selectedshi);
							return;
						}
					}
				},
				changeshi : function() {

					for (var i = 0; i < this.shi.length; i++) {
						if (this.selectedshi.codeid == this.shi[i].codeid) {
							this.xian = this.shi[i].children;
							this.selectedxian = this.shi[i].children[0];
							return;
						}
					}
				},
				changexian : function() {
					console.log(this.selectedxian.cityname);
					return;
				},
				payOrder : function() {
					if (this.info.usr == null) {
						 mizhu.alert('警告', '请先填写好个人信息及收货地址哦','alert_red'); 
						/* alert("请先填写好个人信息及收货地址哦") */
					} else {
						var id=0;
						var userinfo=this.info;
						$.ajax({
							url:"${basepath}/product/payOrder.do",
							type : "get",
							data:{
								info:JSON.stringify(userinfo)							
							},
							dataType : "json",
							async : false,
							success : function(data) {
								id=data;
							}
						});		
						/* alert(id); */
						window.location.href="${basepath}/success.do?money="+this.money+"&checkId=${idList}"+"&id="+id;						
					}

				},
				del:function(){
					this.bool = false;
					this.info.sheng = null;
					this.info.shi = null;
					this.info.xian = null;
					this.info.usr = null;
					this.info.tel = null;
					this.info.description = null;					
				}
			}
		});
	</script>
</body>
</html>