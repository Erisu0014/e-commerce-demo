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
			<div class="panel-head"><strong class="icon-reorder"> 内容列表</strong></div>
			<div class="padding border-bottom">
				<ul class="search" style="padding-left:10px;">
					<li><button type="button" class="button border-yellow" onclick="window.location.href='${basepath}/brand/add.do'"><span class="icon-plus-square-o"></span> 添加内容</button></li>
					<li>
						<form id="fm">
							<input type="text" placeholder="请输入搜索品牌名" name="name" class="input" style="width:250px; line-height:17px;display:inline-block" value="${brand.name }" />
							 &nbsp;&nbsp;是否有效
							<select name="isDel" class="input"   style="width:60px; line-height:17px;display:inline-block">
					            <option value="">全部</option>
					            
					            <option value="1" <c:if test="${brand.isDel==1 }">selected="selected"</c:if>>是</option>
					            <option value="0" <c:if test="${brand.isDel==0 }">selected="selected"</c:if>>否</option>
					          </select>
							<button href="javascript:void(0)" class="button border-main icon-search" > 搜索</button>
						</form>
					</li>
				</ul>
				
			</div>
			<table class="table table-hover text-center">
				<thead>
					<tr>
						<th>编号</th>
						<th>品牌名</th>
						<th>商标</th>
						<th>网站首页</th>
						<th>排序</th>
						<th>是否有效</th>
						<th>操作</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${brands }" var="brand">
						<tr>
							<td>${brand.id }</td>
							<td>${brand.name }</td>
							<td><img src="http://172.18.0.27/${brand.imgUrl}" alt="" width="80" height="80" /></td>
							<td>${brand.webSite }</td>
							<td>${brand.sort }</td>
							<td> 
								<c:if test="${brand.isDel==1 }">有效</c:if>
								<c:if test="${brand.isDel==0 }">失效</c:if>
							</td>
							<td>
								<div class="button-group">
									<a class="button border-main" href="update.do?id=${brand.id }"><span class="icon-edit"></span> 修改</a>
									<a class="button border-red" href="del.do?id=${brand.id }" ><span class="icon-trash-o"></span> 删除</a>
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
		   $(function(){
			   $("#pagelist").mypage({
				pageNo:${brand.pageNo},
				params:"${brand.params}",
				url:"${brand.url}",
				totalPage:${brand.pages}
			   });
		   });
			
		</script>
	</body>
</html>