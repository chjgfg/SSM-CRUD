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
	<!-- 员工修改模态框 -->
	<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" >员工修改</h4>
				</div>
				<div class="modal-body">

					<!-- 修改 -->
					<form class="form-horizontal">
						<div class="form-group">
							<label class="col-sm-2 control-label">empName</label>
							<div class="col-sm-8">
								<p class="form-control-static" id="empName_update"></p>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">empEmail</label>
							<div class="col-sm-8">
								<input type="email" class="form-control" id="update_email" name="email"
									placeholder="xxx@xxx.com">
									<span class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">gender</label>
							<div class="col-sm-8">
								<label class="radio-inline"> <input type="radio"
									name="gender" id="update_gender" value="m" checked="checked">
									男
								</label> <label class="radio-inline"> <input type="radio"
									name="gender" id="update_gender" value="f"> 女
								</label>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">deptName</label>
							<div class="col-sm-4">
								<!-- 部门id -->
								<select class="form-control" name="dId" id="dept_select2">

								</select>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="emp_update">更新</button>
				</div>
			</div>
		</div>
	</div>


	<!-- 员工添加模态框 -->
	<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">员工添加</h4>
				</div>
				<div class="modal-body">

					<!-- 添加 -->
					<form class="form-horizontal">
						<div class="form-group">
							<label class="col-sm-2 control-label">empName</label>
							<div class="col-sm-8">
								<input type="text" class="form-control" id="empName"
									name="empName" placeholder="员工姓名">
									<!-- 用来装校验信息 -->
									<span class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">empEmail</label>
							<div class="col-sm-8">
								<input type="email" class="form-control" id="email" name="email"
									placeholder="xxx@xxx.com">
									<span class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">gender</label>
							<div class="col-sm-8">
								<label class="radio-inline"> <input type="radio"
									name="gender" id="gender" value="m" checked="checked">
									男
								</label> <label class="radio-inline"> <input type="radio"
									name="gender" id="gender" value="f"> 女
								</label>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">deptName</label>
							<div class="col-sm-4">
								<!-- 部门id -->
								<select class="form-control" name="dId" id="dept_select1">

								</select>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="emp_s ave">保存</button>
				</div>
			</div>
		</div>
	</div>

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
				<button class="btn btn-primary" id="emp_add_modal">增加</button>
				<button class="btn btn-danger" id="delete_all_btn">全部删除</button>
			</div>
		</div>
		<!-- 主题 -->
		<div class="row info">
			<div class="col-md-12">
				<table class="table table-hover table-condensed " id="table_emps">
					<thead>
						<tr>
							<th>
								<input type="checkbox" id="check_all"/>
							</th>
							<th>id</th>
							<th>empName</th>
							<th>gender</th>
							<th>email</th>
							<th>detpName</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody></tbody>
				</table>
			</div>
		</div>
		<!-- 分页信息 -->
		<div class="row ">
			<!--分页文字信息 -->
			<div class="col-md-6" id="page-info"></div>
			<!-- 分页条 -->
			<div class="col-md-6" id="page-nav"></div>
		</div>
	</div>
</body>
<script type="text/javascript">
    //定义一个全局变量
	var allTotle,thisPage;
	var updatebtn;
	//1.页面加载完成以后直接发一个ajax请求,要到分页数据
	$(function() {
		to_page(1);
	});

	//4.跳转页面
	function to_page(pn) {
		$.ajax({
			url : "${APP_PATH}/emps",
			type : "GET",
			//在controller中从页面传入的是pn1,因此这里也用pn1
			data : "pn1=" + pn,
			success : function(d) {
				//1.解析并显示员工数据
				table_emps(d);
				//2.解析并显示分页数据
				table_info(d);
				//3.解析显示分页条,点击能动
				table_nav(d);
			}
		});
	};

	//1.解析并显示员工数据
	function table_emps(d) {
		//先清空数据
		$("#table_emps tbody").empty();
		var result = d.map.allpages.list;
		/*result是当前数据的集合
		index是索引
		obj是对象*/
		$.each(result,function(index, obj) {
							var checkboxId = $("<td><input type='checkbox' class='check_item'/></td>");
							var empIdId = $("<td></td>").append(obj.empId);
							var empNameId = $("<td></td>").append(obj.empName);
							var genderId = $("<td></td>").append(obj.gender == 'm' ? "男" : "女");
							var emailId = $("<td></td>").append(obj.email);
							var deptNameId = $("<td></td>").append(obj.department.deptName);
							var edibutton = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn").append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("修改");
							//为修改按钮添加一个自定义属性,来表示当前id
							edibutton.attr("edit_id",obj.empId);
							var delbutton = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn").append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
							//为删除按钮添加一个自定义属性,来表示当前id
							delbutton.attr("del_id",obj.empId);
							var btnId = $("<tr></tr>").append(edibutton).append(" ").append(delbutton);
							$("<tr></tr>").append(checkboxId).append(empIdId).append(empNameId).append(genderId).append(emailId).append(deptNameId).append(btnId).appendTo("#table_emps tbody");
						});
	}

	//2.解析显示分页信息
	function table_info(d) {
		//先清空数据
		$("#page-info").empty();
		$("#page-info").append("当前第" + d.map.allpages.pageNum + "页 ,共" + d.map.allpages.pages+ "页, 共" + d.map.allpages.total + "条记录");
		allTotle = d.map.allpages.total;
		thisPage = d.map.allpages.pageNum;
	}

	//3.解析显示分页条,点击能动
	function table_nav(d) {
		//先清空数据
		$("#page-nav").empty();
		var ul = $("<ul></ul>").addClass("pagination");

		//构建元素
		var firstPage = $("<li></li>").append($("<a></a>").append("首页").attr("href", "#"));
		var prePage = $("<li></li>").append($("<a></a>").append("&laquo;"));
		if (d.map.allpages.hasPreviousPage == false) {
			firstPage.addClass("disabled");
			prePage.addClass("disabled");
		} else {
			//为元素添加监听
			firstPage.click(function() {
				to_page(1);
			});
			prePage.click(function() {
				to_page(d.map.allpages.pageNum - 1);
			});
		}
		//添加首页和前一页
		ul.append(firstPage).append(prePage);

		var nextPage = $("<li></li>").append($("<a></a>").append("&raquo;"));
		var lastPage = $("<li></li>").append($("<a></a>").append("尾页").attr("href", "#"));
		if (d.map.allpages.hasNextPage == false) {
			nextPage.addClass("disabled");
			lastPage.addClass("disabled");
		} else {
			//为元素添加监听
			nextPage.click(function() {
				to_page(d.map.allpages.pageNum + 1);
			});
			lastPage.click(function() {
				to_page(d.map.allpages.pages);
			});
		}

		$.each(d.map.allpages.navigatepageNums, function(index, obj) {
			var namaPage = $("<li></li>").append($("<a></a>").append(obj));
			if (d.map.allpages.pageNum == obj) {
				namaPage.addClass("active");
			}
			//添加页码提示 	
			ul.append(namaPage);
			namaPage.click(function() {
				to_page(obj);
			});
		});
		//添加下一页和尾页提示
		ul.append(nextPage).append(lastPage);

		var navEle = $("<nav></nav>").append(ul);
		navEle.appendTo("#page-nav");
	}

	//清除表单数据
	function reset_tab(ele){
		$(ele)[0].reset();
		$(ele).find("*").removeClass("has-success has-error ");
		$(ele).find(".help-block").text("");
	}
	
	//添加员工模态框
	$("#emp_add_modal").click(function() {
		//清除表单数据(表单数据,表单样式)
		reset_tab("#empAddModal form");
		//发送ajax请求,查出部门信息,显示在下拉列表中
		getDepts("#dept_select1");
		$("#empAddModal").modal({
			//点击背景不会消失
			backdrop : 'static'
		});
	});

	//查出所有部门信息显示在下拉列表中
	function getDepts(ele) {
		$(ele).empty();
		$.ajax({
			url : "${APP_PATH}/dept",
			type : "GET",
			success : function(result) {
				//{"code":100,"msg":"处理成功","map":{"depts":[{"deptId":1,"deptName":"制服部"},{"deptId":2,"deptName":"外联部"},{"deptId":3,"deptName":"社调部"}]}}
				//在下拉列表中显示员工部门信息
				$.each(result.map.depts, function() {
					var op = $("<option></option>").append(this.deptName).attr("value", this.deptId);
					op.appendTo(ele);
				});
			}
		});
	}
	
	
	//服务器对数据进行校验
	function validate_add(){
		//先拿到数据再用正则表达式校验
		var empName = $("#empName").val();
		var regName =/(^[a-zA-Z0-9_-]{4,16}$)|(^[\u2E80-\u9FFF]{2,4})/;
		if(!regName.test(empName)){
			show_validate("#empName","error","用户可以是2-4位中文或4-16位英文字母组成")
			return false;
		}else{
			show_validate("#empName","success","")
		};
		var email = $("#email").val();
		var regEmail =/^[a-z\d]+(\.[a-z\d]+)*@([\da-z](-[\da-z])?)+(\.{1,2}[a-z]+)+$/;
		if(!regEmail.test(email)){
			show_validate("#email","error","邮箱格式不太正确哦!!!")
			return false;
		}else{
			show_validate("#email","success","")
		};
		return true;
	}
	
	//校验的抽取
	function show_validate(ele,sta,msg){
		$(ele).parent().removeClass("has-success has-error ");
		$(ele).next("span").text("");
		if("success" == sta){
			$(ele).parent().addClass("has-success");
			$(ele).next("span").text(msg);
		}else if("error" == sta){
			$(ele).parent().addClass("has-error");
			$(ele).next("span").text(msg);
		}	
	}
	
	//保存信息
	$("#emp_save").click(function(){
		//1.将员工信息保存
		//在发送请求之后先要让服务器对数据进行校验
		if(!validate_add()){
			return false;
		} 
		//2.发送ajax请求 
		//$("#empAddModal form").serialize()获取表单中输入的数据
		$.ajax({
			url:"${APP_PATH}/emp",
			type:"POST",
			data:$("#empAddModal form").serialize(),
			success:function(d){
				if(d.code == 100){
					//员工保存成功,关闭模态框,
					$("#empAddModal").modal('hide');
					//去最后一页 
					to_page(allTotle);
				}else{
					//console.log(d);
					if(undefined != d.map.err_map.email){
						//显示员工邮箱错误信息
						show_validate("#email","error",d.map.err_map.email);
					}
					if(undefined != d.map.err_map.empName){
						//显示员工名字错误信息
						show_validate("#empName","error",d.map.err_map.empName);
					}
				}
			}
		})
	});
	
	//给姓名框绑定事件,当改变的时候发送ajax请求校验
	$("#empName").change(function(){
		var empName = this.value;
		$.ajax({
			url:"${APP_PATH}/chackuser",
			data:"empName="+empName,
			type:"GET",
			success:function(d){
				if(d.code == 100){
					show_validate("#empName","success","用户名可用");
				}else{
					show_validate("#empName","error",d.map.va_msg);
					return false;
				}
			}
		});
	});
	
	//更新
	//绑定事件
	//点击修改按钮
	$(document).on("click",".edit_btn",function(){
		//查出员工信息,并显示
		updatebtn = $(this).attr("edit_id");
		getEmpty(updatebtn);	
		//查出部门信息,并显示部门列表
		getDepts("#dept_select2");
		
		//把员工id传递给更新按钮
		$("#emp_update").attr("edit_id1",updatebtn);
		
		$("#empUpdateModal").modal({
			//点击背景不会消失
			backdrop : 'static'
		});
	});
	//{"code":100,"msg":"处理成功","map":{"value":{"empId":1,"empName":"39508","gender":"m","email":"39508@vector.org","dId":1,"department":null}}}
	function getEmpty(id){
		$.ajax({
			url:"${APP_PATH}/emp/"+id,
			type:"GET",
			success:function(data){
				//console.log(data); 
				var empEle = data.map.value;
				$("#empName_update").text(empEle.empName);
				$("#update_email").val(empEle.email);
				//单选框选中
				$("#empUpdateModal input[name=gender]").val([empEle.gender]);
				$("#empUpdateModal #dept_select2").val([empEle.dId]);
			}
		});
	}
	
	
	//点击更新按钮,更新员工信息
	$("#emp_update").click(function(){
		//1.验证邮箱是否合法
		var email = $("#update_email").val();
		var regEmail =/^[a-z\d]+(\.[a-z\d]+)*@([\da-z](-[\da-z])?)+(\.{1,2}[a-z]+)+$/;
		if(!regEmail.test(email)){
			show_validate("#update_email","error","邮箱格式不太正确哦!!!")
			return false;
		}else{
			show_validate("#update_email","success","")
		};  
		//2.发送ajax请求保存更新的员工数据
		$.ajax({
			url:"${APP_PATH}/emp/"+$(this).attr("edit_id1"), 
			type:"PUT",
			data:$("#empUpdateModal form").serialize(),//+"&_method=PUT",
			success:function(number){
				alert(number.msg);
	            alert(number.code);
				$("#empUpdateModal").modal('hide');
				to_page(thisPage);
			} 
		});
	});
	
	
	//单个删除
	$(document).on("click",".delete_btn",function(){
		 var empName = $(this).parents("tr").find("td:eq(2)").text();
		 var empId = $(this).attr("del_id");
	        if(confirm("确认删除【"+empName+"】吗？")){
	            //发送ajax请求删除
	            $.ajax({
	                url:"${APP_PATH}/emp/"+empId,
	                type:"DELETE",
	                success:function (result) {
	                    alert(result.msg);
	                    //回到本页
	                    to_page(thisPage);
	                }
	            });
	        }
	});
	//完成全选/全不选
	$("#check_all").click(function(){
		//attr获取单选框是否选中总是undefined,因此用prop
		var kk = $(this).prop("checked");
		$(".check_item").prop("checked",kk);
	});
	$(document).on("click",".check_item",function(){
		var ll = $(".check_item:checked").length == $(".check_item").length;		
		$("#check_all").prop("checked",ll);
	});
	//点击全部删除就批量删除
	$("#delete_all_btn").click(function(){
		//组装员工字符串
		var empNames = "";
		var allid = "";
		$.each($(".check_item:checked"),function(){
			 empNames += $(this).parents("tr").find("td:eq(2)").text()+",";
			 allid += $(this).parents("tr").find("td:eq(1)").text() + "-";
		});
		//去掉多余的","
		empNames = empNames.substring(0,empNames.length-1);
		allid = allid.substring(0,allid.length-1);
		if(confirm("确认删除【"+empNames+"】吗？")){
			$.ajax({
				url:"${APP_PATH}/emp/"+allid,
				type:"DELETE",
				success:function(allid){
					alert(allid.massage);
					//回到本页
                    to_page(thisPage);
                    $("#check_all").prop("checked",false);
				}
			});
		}
	});
	
</script>
</html>
