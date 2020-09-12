package org.vector.crud.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.vector.crud.bean.Employee;
import org.vector.crud.bean.EmployeeExample;
import org.vector.crud.bean.EmployeeExample.Criteria;
import org.vector.crud.dao.EmployeeMapper;

@Service 
public class EmployeeService {

	/*
	 * 查询所有员工
	 */
	@Resource
	EmployeeMapper employeeMapper;
	
	public List<Employee> selectAll() {
		return employeeMapper.selectByExampleWithDept(null);
	}

	public void saveEmp(Employee employee) {
		employeeMapper.insertSelective(employee);
	}

	public Boolean chackUser(String empName) {
		//EmployeeExample针对某个类进行单表操作,用于添加条件，相当where后面的部分 
		//XxxExample.java中包含一个static的内部类Criteria，Criteria中的方法是定义SQL 语句where后的查询条件。
		EmployeeExample example = new EmployeeExample();
		Criteria createCriteria = example.createCriteria();
		createCriteria.andEmpNameEqualTo(empName);
		long countByExample = employeeMapper.countByExample(example);
		//如果数据库中没有数据就返回0,可用
		//如果数据库中有数据就返回大于0,不可用
		return countByExample == 0;

	}

	/*
	 * 按员工id查询
	 */
	public Employee getEmpty(Integer id) {
		Employee primaryKey = employeeMapper.selectByPrimaryKey(id);
		return primaryKey;
	}
	//更新员工
	public void updateEmp(Employee employee) {
		employeeMapper.updateByPrimaryKeySelective(employee);
	}

	//员工删除
	public void deleteEmpty(Integer id) {
		employeeMapper.deleteByPrimaryKey(id);
	}
	
	//批量删除
	public void deleteSelect(List<Integer> allid) {
		EmployeeExample ee = new EmployeeExample();
		Criteria c = ee.createCriteria();
		c.andEmpIdIn(allid);
		//会变成delete from xxx where 	emp_id in (split); 	
		employeeMapper.deleteByExample(ee);
	}
	 	
}
