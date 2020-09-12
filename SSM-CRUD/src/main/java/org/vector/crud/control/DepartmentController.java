package org.vector.crud.control;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.vector.crud.bean.Department;
import org.vector.crud.bean.Massage;
import org.vector.crud.service.DepartmentService;
/*
 * 处理和部门有关的请求
 */
@Controller
public class DepartmentController {
	
	@Resource
	private DepartmentService  departmentService; 
	
	@ResponseBody
	@RequestMapping("/dept")
	public Massage getDept() {
		List<Department> list = departmentService.selectAllDept();
		return Massage.success().add("depts", list);
	}

}
