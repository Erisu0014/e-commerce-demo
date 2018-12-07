<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ include file="/WEB-INF/common/Head.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
	</head>
	<body>
		<div class="panel admin-panel">
			<div class="panel-head" id="add"><strong><span class="icon-pencil-square-o"></span>修改品牌</strong></div>
			<div class="body-content">
				<form method="post" class="form-x" enctype="multipart/form-data"  >
				<input type="text" name="id" value="${brand.id }" style="display:none">
					<div class="form-group">
						<div class="label">
							<label>品牌名：</label>
						</div>
						<div class="field">
							<input type="text" class="input w50" value="${brand.name }" name="name" data-validate="required:请输入品牌名" />
							<div class="tips"></div>
						</div>
					</div>
					<div class="form-group">
						<div class="label">
							<label>图片：</label>
						</div>
						<div class="field">
							<input type="text" id="url" name="img" class="input tips" style="width:25%; float:left;" value="${brand.imgUrl }"  data-toggle="hover" data-place="right" data-image="http://172.18.0.27/${brand.imgUrl }" />
							<input type="file" id="logo" name="logoImg" style="display:none">
							<input type="button" class="button bg-blue margin-left" id="image" value="+ 浏览上传" style="float:left;">
							<div class="tipss">图片尺寸：500*500</div>
						</div>
					</div>

					<div class="form-group">
						<div class="label">
							<label>品牌首页：</label>
						</div>
						<div class="field">
							<input type="text" class="input w50" value="${brand.webSite }" name="webSite"  />
							<div class="tips"></div>
						</div>
					</div>
					<div class="form-group">
						<div class="label">
							<label>排序：</label>
						</div>
						<div class="field">
							<input type="text" class="input w50" value="${brand.sort }" name="sort"  data-validate="plusinteger:排序必须为数字" />
							<div class="tips"></div>
						</div>
					</div>
					<div class="form-group">
						<div class="label">
							<label></label>
						</div>
						<div class="field">
							<button class="button bg-main icon-check-square-o" type="submit"> 提交</button>
						</div>
					</div>
				</form>
			</div>
		</div>
		<script type="text/javascript">
			$(function(){	
				$("#logo").change(function(){
					var fileReader=new FileReader();
					fileReader.onload=function(e){
						$("#url").attr("data-image",e.target.result);
						$("#url").val($("#logo").val());
						
					}
					fileReader.readAsDataURL($("#logo")[0].files[0]);
				});
				$("#image").click(function(){
					$("#logo").click();
				});
			});
		</script>
	</body>
</html>