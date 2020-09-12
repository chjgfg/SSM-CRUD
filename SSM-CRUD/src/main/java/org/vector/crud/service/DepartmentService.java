package org.vector.crud.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.vector.crud.bean.Department;
import org.vector.crud.dao.DepartmentMapper;

@Service
public class DepartmentService {

	@Resource
	private 	 DepartmentMapper departmentMapper ;
	public List<Department> selectAllDept() {
		List<Department> selectByExample = departmentMapper.selectByExample(null);
		return selectByExample;
	}

}
