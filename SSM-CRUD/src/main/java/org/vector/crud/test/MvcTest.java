package org.vector.crud.test;

import java.util.List;

import javax.annotation.Resource;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;
import org.vector.crud.bean.Employee;

import com.github.pagehelper.PageInfo;


/*
 * 使用Spring测试模块提供的测试功能,测试crud请求的正确性
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= {"classpath:applicationContext.xml","file:src/main/webapp/WEB-INF/dispatcherServlet-servlet.xml"})
//拿到Spring的容器
@WebAppConfiguration
public class MvcTest {
	//相当于传入Spring 的ioc
	@Resource
	WebApplicationContext  wac;
	
	//MockMvc:虚拟的mvc请求,获取处理结果
	MockMvc mockMvc;

	@Before
	public void  initMockMvc() {
		//MockMvcBuilder构造MockMvc的构造器
		//MockMvcBuilders.webAppContextSetup(wac)：指定WebApplicationContext，将会从该上下文获取相应的控制器并得到相应的MockMvc；
		mockMvc = MockMvcBuilders.webAppContextSetup(wac).build();
	}
	
	//编写分页的测试方法
	@Test
	public void  testPage() throws Exception {
		//模拟请求拿到返回值
		MvcResult ret = mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pn","5")).andReturn();
		//请求成功后,请求域中会有allpages,取出allpages进行验证
		MockHttpServletRequest re = ret.getRequest();
		 PageInfo a = (PageInfo) re.getAttribute("allpages");
		 System.out.println("当前页码:"+a.getPageNum());
		 System.out.println("总页码:"+a.getPages());
		 System.out.println("总记录数:"+a.getTotal());
		 System.out.println("在页面中需要显示的页码");
		 int[] nowpage = a.getNavigatepageNums();
		 for (int i : nowpage) {
			System.out.println(" " + i);
		}
		 //获取员工数据
		 List<Employee> list = a.getList();
		 for (Employee employee : list) {
			System.out.println("id:" + employee.getEmpId()+" "+ "name:"+employee.getEmpName() + " " + "dept:" + employee.getDepartment());
		}
		 
	}
	
}
