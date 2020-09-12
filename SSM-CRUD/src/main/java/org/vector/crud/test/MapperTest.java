package org.vector.crud.test;

import java.util.UUID;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.vector.crud.bean.Employee;
import org.vector.crud.dao.DepartmentMapper;
import org.vector.crud.dao.EmployeeMapper;

/*
 * 测试
 * 推荐有关Spring的项目就用spring的单元测试
 * 1.导入springTest模块
 * 2.@ContextConfiguration指定Spring配置文件位置(把pom.xml 中的<scope>test</scope> 去掉)
 * 3.
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:applicationContext.xml" })
public class MapperTest {
	// 测试DepartmentMapper
	@Resource
	DepartmentMapper departmentMapper;
	@Resource
	EmployeeMapper employeeMapper; 
	@Resource
	SqlSession sqlSession;
	
	
	@Test
	public void testCRUD() {
		System.out.println(departmentMapper);
		//1.插入几个部门
		/*departmentMapper.insertSelective(new Department(null,"研发部"));
		departmentMapper.insertSelective(new Department(null, "社调部"));*/
		//2.生成员工数据,测试员工插入
		//employeeMapper.insertSelective(new Employee(null,"jreey","d","csd@163.com",8));
		//批量的生成多个员工,使用可以执行批量操作的SqlSession,在ioc中配制
		EmployeeMapper  mapper = sqlSession.getMapper(EmployeeMapper.class);
		for(int i = 0 ; i < 1000 ; i++) {
			String uid = UUID.randomUUID().toString().substring(0, 5);
			mapper.insertSelective(new Employee(null,uid,"m",uid + "@vector.org",1));
			/*mapper.deleteByExample(null);*/
		}
	}
}
