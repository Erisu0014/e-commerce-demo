<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ include file="/WEB-INF/common/Head.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<meta name="renderer" content="webkit">
<title></title>
<link rel="stylesheet" href="${resourceServer }/css/pintuer.css">
<link rel="stylesheet" href="${resourceServer }/css/admin.css">
<script src="${resourceServer }/js/jquery.js"></script>
<script src="${resourceServer }/js/pintuer.js"></script>
<script src="${resourceServer }/js/vue.min.js"></script>
<script charset="utf-8" src="${basepath}/kindeditor/kindeditor.js"></script>
<script charset="utf-8" src="${basepath}/kindeditor/lang/zh_CN.js"></script>
<style>
.search li {
	border: 1px solid #ccc;
	padding: 0px 10px;
	cursor: pointer;
}

.search .select {
	background-color: #66f9fd;
	color: #000;
}
</style>
</head>
<body>
	<div id="app" class="panel admin-panel">
		<div class="panel-head" id="add">
			<strong><span class="icon-pencil-square-o"></span>增加商品</strong>
		</div>
		<div class="padding border-bottom">
			<ul class="search" style="padding-left: 10px;">
				<li :class="{select:selected==1}" @click="selected=1">基本信息</li>
				<li :class="{select:selected==2}" @click="selected=2">图片</li>
				<li :class="{select:selected==3}" @click="selected=3">详细信息</li>
				<li :class="{select:selected==4}" @click="selected=4">其他信息</li>
			</ul>
		</div>
		<form method="post" class="form-x" enctype="multipart/form-data">
		<input type="text" style="display: none" value="${product.id }">
			<div class="body-content" v-show="selected==1">
				<div class="form-group">
					<div class="label">
						<label>商品名：</label>
					</div>
					<div class="field">
						<input type="text" class="input w50" value="${product.name }"
							name="name" data-validate="required:请输入商品名" />
						<div class="tips"></div>
					</div>
				</div>
				<div class="form-group">
					<div class="label">
						<label>品牌名：</label>
					</div>
					<div class="field">
						<select class="input w50" name="brandId">
							<c:forEach items="${brands }" var="brand">
								<option id="${brand.id }" value="${brand.id }"
									<c:if test="${brand.id==product.brandId }">selected</c:if>>${brand.name }</option>

							</c:forEach>
						</select>
					</div>
				</div>
				<div class="form-group">
					<div class="label">
						<label>排序：</label>
					</div>
					<div class="field">
						<input type="text" class="input w50" value="${product.sort }"
							name="sort" data-validate="plusinteger:排序必须为数字" />
						<div class="tips"></div>
					</div>
				</div>
				<div class="form-group">
					<div class="label">
						<label>是否热卖：</label>
					</div>
					<div class="field" style="padding-top: 8px;">
						<label><input name="isHot" type="radio"
							<c:if test="${product.isHot==1 }"> checked="checked" </c:if>
							value="1">是</label>&nbsp;&nbsp; <label><input
							name="isHot" type="radio"
							<c:if test="${product.isHot==0 }"> checked="checked" </c:if>
							value="0">否</label>&nbsp;&nbsp;
					</div>

				</div>
				<div class="form-group">
					<div class="label" style="padding-top: 8px;">
						<label>是否新品：</label>
					</div>
					<div class="field">
						<label><input name="isNew" type="radio"
							<c:if test="${product.isNew==1 }"> checked="checked" </c:if>
							value="1">是</label>&nbsp;&nbsp; <label><input
							name="isNew" type="radio"
							<c:if test="${product.isNew==0 }"> checked="checked" </c:if>
							value="0">否</label>&nbsp;&nbsp;
					</div>

				</div>
				<div class="form-group">
					<div class="label" style="padding-top: 8px;">
						<label>是否推荐：</label>
					</div>
					<div class="field">
						<label><input name="isCommend" type="radio"
							<c:if test="${product.isCommend==1 }"> checked="checked" </c:if>
							value="1">是</label>&nbsp;&nbsp; <label><input
							name="isCommend" type="radio"
							<c:if test="${product.isCommend==0 }"> checked="checked" </c:if>
							value="0">否</label>&nbsp;&nbsp;
					</div>

				</div>
				<div class="form-group">
					<div class="label">
						<label></label>
					</div>
					<div class="field">
						<button class="button bg-main icon-check-square-o" type="submit">
							修改</button>
					</div>
				</div>
			</div>
			<div class="body-content" v-show="selected==2">
				<div class="form-group">
					<div class="label">
						<label>图片：</label>
					</div>
					<div class="field">
						<input type="text" id="oldImg" name="oldImg" style="display: none"
							value="${product.images }"> <input type="file"
							id="image" name="image" style="display: none"
							enctype="multipart/form-data" multiple @change="changeImg()">
						<input type="button" class="button bg-blue margin-left"
							@click="openImg()" value="+ 浏览上传" style="float: left;">
					</div>
					<div id="yulan">
					<c:forEach items="${oldImages }" var="oldImage">
					 <img src="http://172.18.0.27/${oldImage }"> 
					</c:forEach>
					</div>
				</div>
			</div>
			<div class="body-content" v-show="selected==3">
				<div class="form-group">
					<div class="label">
						<label>商品详细信息：</label>
					</div>
					<div class="field">
						<textarea id="description" name="description" class="input"
							style="height: 450px; border: 1px solid #ddd;">${product.description }</textarea>
						<div class="tips"></div>
					</div>
				</div>
			</div>
			<div class="body-content" v-show="selected==4">
				<div class="form-group">
					<div class="label">
						<label>参考价格：</label>
					</div>
					<div class="field">
						<input type="text" class="input w50" value="${product.price }"
							name="price" data-validate="required:请输入参考价,plusdouble:必须是小数	" />
						<div class="tips"></div>
					</div>
				</div>
				<div class="form-group">
					<div class="label">
						<label>销量：</label>
					</div>
					<div class="field">
						<input type="text" class="input w50" value="${product.sales }"
							name="sales" data-validate="required:请输入参考价,plusinteger:必须是正整数	" />
						<div class="tips"></div>
					</div>
				</div>
				<div class="form-group">
					<div class="label">
						<label>内存：</label>
					</div>
					<div class="field">

						<c:forEach items="${storages }" var="storage">
							<label><input name="storageList" type="checkbox"
								value="${storage.id }"
								<c:forEach items="${selectedStorages}" var="selectedStorage">
								
								<c:if test="${ storage.id==selectedStorage}">
								checked="checked"
								</c:if>
								</c:forEach>>${storage.name }</label>&nbsp;&nbsp;						
							</c:forEach>

					</div>
				</div>
				<div class="form-group">
					<div class="label">
						<label>颜色：</label>
					</div>
					<div class="field">

						<c:forEach items="${colors }" var="color">
							<label><input name="colorList" type="checkbox"
								value="${color.id }"
								<c:forEach items="${selectedColors}" var="selectedColor">
								
								<c:if test="${ color.id==selectedColor}">
								checked="checked"
								</c:if>
								</c:forEach>
								>${color.name }</label>&nbsp;&nbsp;						
							</c:forEach>

					</div>
				</div>
			</div>
		</form>

	</div>


	<script type="text/javascript">
		KindEditor.ready(function(K) {
			window.editor = K.create('#description', {
				width : "700px",
				height : "450px",
				uploadJson : "${basepath}/product/upload.do"
			});
		});
		var vue = new Vue({
			el : "#app",
			data : {
				selected : 1
			},
			methods : {
				openImg : function() {
					$("#image").click();
				},
				changeImg : function() {
					$("#yulan").empty();
					$("#oldImg").attr("value", " ");
					for (var i = 0; i < $("#image")[0].files.length; i++) {
						var fileReader = new FileReader();
						fileReader.onload = function(e) {
							var $img = $("<img>");
							$img.attr("src", e.target.result);
							$("#yulan").append($img);
						}
						fileReader.readAsDataURL($("#image")[0].files[i]);
					}
				}
			}
		});
	</script>
</body>
</html>