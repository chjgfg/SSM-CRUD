<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>员工列表</title>
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<!--  
	不以 / 开始的相对路径找资源,以当前页面的路径为基准,经常出现问题
	以 /  开始的路径找资源,以服务器为基准(localhost:8080/项目名)
 -->
<!-- 引入jquery -->
<script type="text/javascript"
	src="${pageContext.request.contextPath}/static/js/jquery-2.1.0.min.js"></script>
<!-- 引入bootstrapt样式 -->
<link href="/SSM-CRUD/static/bootstrap-3.3.7-dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>
	<!-- 使用bootstrapt搭建页面 -->
	<div class="container">
		<!-- 标题  -->
		<div class="row ">
			<div class="col-md-12 ">
				<h1>SSM-CRUD</h1>
			</div>
		</div>
		<!-- 按钮  -->
		<div class="row ">
			<div class="col-md-4 col-md-offset-8">
				<button class="btn btn-primary">增加</button>
				<button class="btn btn-danger">删除</button>
			</div>
		</div>
		<!-- 主题 -->
		<div class="row info">
			<div class="col-md-12">
				<table class="table table-hover table-condensed ">
					<tr>
						<th>id</th>
						<th>empName</th>
						<th>gender</th>
						<th>email</th>
						<th>detpName</th>
						<th>操作</th>
					</tr>
					<c:forEach items="${allpages.list }" var="p">
						<tr>
							<th>${p.empId }</th>
							<th>${p.empName }</th>
							<th>${p.gender=="m"?"男":"女" }</th>
							<th>${p.email }</th>
							<th>${p.department.deptName }</th>
							<th>
								<button class="btn btn-primary btn-sm">
									<span class="glyphicon glyphicon-pencil " aria-hidden="true"></span>
									编辑
								</button>
								<button class="btn btn-danger btn-sm">
									<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
									删除
								</button>
							</th>
						</tr>
					</c:forEach>
				</table>
			</div>
		</div>
		<!-- 分页信息 -->
		<div class="row ">
			<!--分页文字信息 -->
			<div class="col-md-6">当前第${allpages.pageNum }页 ,共${allpages.pages }页, 共
				${allpages.total }条记录</div>
			<!-- 分页条 -->
			<div class="col-md-6">
				<nav aria-label="Page navigation">
					<ul class="pagination">
						<li><a href="${APP_PATH }/emps?pn=1">首页</a></li>
						
						<c:if test="${allpages.hasPreviousPage }">
							<li><a href="${APP_PATH }/emps?pn=${allpages.pageNum -1}"
								aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
							</a></li>
						</c:if>
						
						<c:forEach items="${allpages.navigatepageNums }" var="page_Num">
							<c:if test="${page_Num == allpages.pageNum}">
								<li class="active"><a href="#">${page_Num}</a></li>
							</c:if>
							<c:if test="${page_Num != allpages.pageNum}">
								<li><a href="${APP_PATH }/emps?pn=${page_Num}">${page_Num}</a></li>
							</c:if>
						</c:forEach>
						
						<c:if test="${allpages.hasNextPage }">
							<li><a href="${APP_PATH }/emps?pn=${allpages.pageNum +1}"
								aria-label="Next"> <span aria-hidden="true">&raquo;</span>
							</a></li>
						</c:if>
						
						<li><a href="${APP_PATH }/emps?pn=${allpages.pages}">尾页</a></li>
					</ul>
				</nav>
			</div>
		</div>
	</div>
</body>
</html>