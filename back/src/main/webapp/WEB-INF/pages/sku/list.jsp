<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ include file="/WEB-INF/common/Head.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="zh-cn">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
		<meta name="renderer" content="webkit">
		<title></title>
		<link rel="stylesheet" href="${resourceServer }/css/pintuer.css">
		<link rel="stylesheet" href="${resourceServer }/css/admin.css">
		<script src="${resourceServer }/js/jquery.js"></script>
		<script src="${resourceServer }/js/pintuer.js"></script>
		<script src="${resourceServer }/js/vue.min.js"></script>
		<script src="${resourceServer }/js/jquery.form.js"></script>
	</head>

	<body>
		<div id="app">
			<div class="panel admin-panel">
				<div class="panel-head"><strong class="icon-reorder">SKU列表</strong></div>
				 <form id="fm" method="post" action="${basepath }/sku/update.do">
					 <table class="table table-hover text-center">
						<thead>
							<tr>
								<th>编号</th>
								<th>颜色</th>
								<th>内存</th>
								<th>市场价</th>
								<th>现售价</th>
								<th>运费</th>
								<th>库存数</th>
								<th>销量</th>
								<th>操作</th>
							</tr>
						</thead>
						<tbody>
							<template v-for="sku in list">
								<tr v-if="selectid!=sku.id">
									<td>{{sku.id}}</td>
									<td>{{colorName(sku.colorId)}}</td>
									<td>{{storageName(sku.storageId)}}</td>
									<td>{{sku.originalPrice}}</td>
									<td>{{sku.price}}</td>
									<td>{{sku.freight}}</td>
									<td>{{sku.stock}}</td>
									<td>{{sku.sales}}</td>
									<td><a class="button border-main" href="javascript:void(0)" @click="selectid=sku.id"><span class="icon-edit"></span>修改</a></td>
								</tr>
								<tr v-if="selectid==sku.id">
									<td>{{sku.id}}</td>
									<td>{{colorName(sku.colorId)}}</td>
									<td>{{storageName(sku.storageId)}}</td>
									<td><input name="originalPrice" :value="sku.originalPrice"></td>
									<td><input name="price" :value="sku.price"></td>
									<td><input name="freight" :value="sku.freight"></td>
									<td><input name="stock" :value="sku.stock"></td>
									<td>{{sku.sales}}</td>
									<td><a class="button border-main" href="javascript:void(0)" @click="save"><span class="icon-edit"></span>保存</a></td>
								</tr>
							</template>
						</tbody>
					</table> 
				</form>
			</div>
		</div>
		<script type="text/javascript">
		
			$(function(){
				var arr;
				var colors;
				var storages;
				 $.ajax({
					"url":"${basepath}/color/list.do",
					"async":false,
					"dataType":"json",
					"type":"get",
					success:function(data){
						colors=data;
					}
				}); 
				 $.ajax({
					"url":"${basepath}/storage/list.do",
					"async":false,
					"dataType":"json",
					"type":"get",
					success:function(data){
						storages=data;
					}
				});
				 console.log(storages);
				$.ajax({
					"url":"${basepath}/sku/get.do",
					"async":false,
					"data":{productId:${productId}},
					"dataType":"json",
					"type":"get",
					success:function(data){
						arr=data;
					}
				});
				var vue=new Vue({
					el:"#app",
					data:{
						list:arr,
						selectid:0
					},
					methods:{
						colorName:function(id){
							for(var i=0;i<=colors.length;i++){
								if(colors[i].id==id){
									return colors[i].name;
								}
							}
						},
						storageName:function(id){
							for(var i=0;i<=storages.length;i++){
								if(storages[i].id==id){
									return storages[i].name;
								}
							}
						},
						save:function(){
							$("#fm").ajaxSubmit({
								data:{id:vue.selectid},
								success:function(data){
									$.ajax({
										"url":"${basepath}/sku/get.do",
										"async":false,
										"data":{productId:${productId}},
										"dataType":"json",
										"type":"get",
										success:function(data){
											vue.list=data;
										}
									});
									vue.selectid=0;
								}
							});
						}
					}
				});
			})
			
		</script>
	</body>
</html>