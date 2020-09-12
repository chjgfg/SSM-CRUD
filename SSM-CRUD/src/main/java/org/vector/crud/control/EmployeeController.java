package org.vector.crud.control;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.vector.crud.bean.Employee;
import org.vector.crud.bean.Massage;
import org.vector.crud.service.EmployeeService;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

/*
 * 处理员工crud
 */
@Controller
public class EmployeeController {
	@Resource
	EmployeeService employeeService;
	
	/*
	 * 单个删除和多个删除一起
	 */
	@RequestMapping("/emp/{allid}")
	@ResponseBody
	public Massage deleteSelect(@PathVariable("allid")String allid) {
		if(allid.contains("-")) {
			//组装id为集合
			List<Integer> ll = new ArrayList<>();
			String[]  split = allid.split("-");
			for (String s : split) {
				ll.add(Integer.parseInt(s));
			}
			employeeService.deleteSelect(ll);
		}else {
			Integer id = Integer.parseInt(allid);
			employeeService.deleteEmpty(id);
		}
		return Massage.success();
	}
	
	//更新员工
	//@RequestMapping(value="/emp/{empId}", method=RequestMethod.PUT )
	@PutMapping("/emp/{empId}" )
	@ResponseBody
	public Massage saveEle(Employee employee) {
		employeeService.updateEmp(employee);
		return Massage.success();
	}
	
	//根据id查询员工之后更新
	//@RequestMapping(value="/emp/{id}",method=RequestMethod.GET)
	@GetMapping("/emp/{id}")
	@ResponseBody
	public  Massage getEmpty(@PathVariable("id")Integer id) {
		Employee value = employeeService.getEmpty(id);
		return Massage.success().add("value", value);
	}
	
	
	/*
	 * 检查用户名是否可用
	 */
	@ResponseBody
	@RequestMapping("/chackuser")
	public Massage chackUser(@RequestParam("empName")String empName) {
		//先判断是否合法
		String string = "(^[a-zA-Z0-9_-]{4,16}$)|(^[\\u2E80-\\u9FFF]{2,4})";
		if(!string.matches(empName)) {
			return Massage.fail().add("va_msg", "用户名必须是6-16位英文或2-4位中文组成");
		}
		//在和数据库匹配
		Boolean boolean1 = employeeService.chackUser(empName);
		if(boolean1) {
			return Massage.success();
		}else {
			return Massage.fail().add("va_msg", "用户名已存在") ;
		}
	}
		
	/*
	 * 保存员工 
	 * 规定URI： 
	 * /emg/{id}  GET 查询员工
	 *  /emg        POST保员工 
	 *  /emg/{id} PUT 修改员工 
	 *  /emg/{id} DELETE 删除员工
	 */
	/*
	 * 用jsr303进行数据校验
	 * 导入hibernate -validator
	 * @Valid进行数据校验
	 * BindingResult封装校验的结果
	 */
	@RequestMapping(value="/emp", method=RequestMethod.POST)
	@ResponseBody
	public Massage saveEmp(@Valid Employee employee,BindingResult result ) {
		//校验失败,在模态框中返回错误信息
		Map<String , Object> map = new HashMap<String, Object>();
		if(result.hasErrors()) {
			List<FieldError> 	allErrors = result.getFieldErrors();
			for (FieldError objectError : allErrors) {
				System.out.println("错误字段"+ objectError.getField());
				System.out.println("错误信息"+objectError.getDefaultMessage());
				map.put(objectError.getField(), objectError.getDefaultMessage());
			}
			return Massage.fail().add("err_map", map);
		}else {
			employeeService.saveEmp(employee);
			return Massage.success();
		}
	}

	/*
	 * jackson包
	 * 
	 * @ResponseBody将对象转成json字符串
	 */
	// 获取所有员工(分页查询员工数据)
	@ResponseBody
	@RequestMapping("/emps")
	public Massage getEmpsWithJson(@RequestParam(value = "pn1", defaultValue = "1") Integer pn, Model model) {
		// 在pom.xml中引入pagehelper分页插件
		// 在查询之前调用,传入页码,每一页需要查看的数据量
		PageHelper.startPage(pn, 10);
		// 之后的就是分页查询
		List<Employee> employees = employeeService.selectAll();
		// 结果包装,之后将结果交给页面. 5是传入连续显示的5页
		PageInfo<Employee> pages = new PageInfo<Employee>(employees, 5);
		return Massage.success().add("allpages", pages);
	}

	/*
	 * @RequestParam(value="pn",defaultValue="1")Integer page
	 * 从jsp页面传进来的Integer类型的数据,值为pn,名字是page,默认值是1
	 * 
	 * @RequestMapping("/emps") 也是从前台页面传过来的
	 */
	/*
	 * @RequestMapping("/emps") public String
	 * getEmps(@RequestParam(value="pn",defaultValue="1")Integer pn,Model model ) {
	 * //在pom.xml中引入pagehelper分页插件 //在查询之前调用,传入页码,每一页需要查看的数据量
	 * PageHelper.startPage(pn,10); //之后的就是分页查询 List<Employee> employees =
	 * employeeService.selectAll(); //结果包装,之后将结果交给页面. 5是传入连续显示的5页 PageInfo pages =
	 * new PageInfo(employees,5); model.addAttribute("allpages",pages); return
	 * "list2"; }
	 */

}
