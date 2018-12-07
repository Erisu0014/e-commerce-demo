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
	</head>

	<body>
		<div class="panel admin-panel">
			<div class="panel-head"><strong class="icon-reorder"> 商品列表</strong></div>
			<div class="padding border-bottom">
				<ul class="search" style="padding-left:10px;">
					<li><button type="button" class="button border-yellow" onclick="window.location.href='${basepath}/product/add.do'"><span class="icon-plus-square-o"></span> 添加内容</button></li>
					<li>
						 <form id="fm">
							<input type="text" placeholder="请输入搜索商品名" name="name" class="input" style="width:250px; line-height:17px;display:inline-block" value="${product.name }" />
							<%--  &nbsp;&nbsp;是否有效
							 <select name="isDel" class="input"   style="width:60px; line-height:17px;display:inline-block">
					            <option value="">全部</option>
					            
					            <option value="1" <c:if test="${product.isDel==1 }">selected="selected"</c:if>>是</option>
					            <option value="0" <c:if test="${product.isDel==0 }">selected="selected"</c:if>>否</option>
					          </select> --%> 
							<button href="javascript:void(0)" class="button border-main icon-search" > 搜索</button>
						</form> 
					</li>
				</ul>
				
			</div>
			<table class="table table-hover text-center">
			<thead>
					<tr>
						<th>编号</th>
						<th>商品名</th>
						<th>品牌名</th>
						<th>预览图</th>	
						<th>是否有效</th>
						<th>是否热度</th>
						<th>是否新品</th>		
						<th>是否展示</th>									
						<th>排序</th>
						<!-- <th>详细信息</th>	 -->					
						<th>操作</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${products }" var="product" varStatus="loop">
						<tr>
							<td>${product.id }</td>
							<td>${product.name }</td>
							<td>${brandsName[loop.count-1] }</td>						
							<td><img src="http://172.18.0.27/${product.images }" alt="" width="80" height="80" /></td>
							
							<td> 
								<c:if test="${product.isDel==1 }">有效</c:if>
								<c:if test="${product.isDel==0 }">失效</c:if>
							</td>
							<td> 
								<c:if test="${product.isHot==1 }">热度</c:if>
								<c:if test="${product.isHot==0 }">非热度</c:if>
							</td>
							<td> 
								<c:if test="${product.isNew==1 }">新品</c:if>
								<c:if test="${product.isNew==0 }">非新品</c:if>
							</td>
							<td> 
								<c:if test="${product.isShow==1 }">展示</c:if>
								<c:if test="${product.isShow==0 }">不展示</c:if>
							</td>
							<td>${product.sort }</td>
							<td>
								<div class="button-group">
								    <a class="button border-main" href="javascript:void(0)" onclick="up(${product.id},${product.isShow })">
								    <span class="icon-edit"><c:if test="${product.isShow==0 }">上架</c:if>
								    <c:if test="${product.isShow==1}">下架</c:if></span></a>
								    <a class="button border-main" href="details.do?id=${product.id }"><span class="icon-edit"></span>详细信息</a>
								    <a class="button border-main" href="${basepath }/sku/list.do?productId=${product.id }"><span class="icon-edit"></span> sku</a>
									<a class="button border-main" href="update.do?id=${product.id }"><span class="icon-edit"></span> 修改</a>
									<a class="button border-red" href="del.do?id=${product.id }" ><span class="icon-trash-o"></span> 删除</a>
								</div>
							</td>
						</tr>
					</c:forEach>
				</tbody>
				
			</table>
		</div>
		<div id="pagelist" class="pagelist"></div>
		<script src="${resourceServer }/js/page.js"></script>
		<script type="text/javascript">
		function up(id,isShow){
			window.location.href="${basepath}/product/up.do?id="+id+"&isShow="+isShow;
		}
		    $(function(){
			   $("#pagelist").mypage({
				pageNo:${product.pageNo},
				params:"${product.params}",
				url:"${product.url}",
				totalPage:${product.pages}
			   });	
		   }); 
			
		</script>
	</body>
</html>