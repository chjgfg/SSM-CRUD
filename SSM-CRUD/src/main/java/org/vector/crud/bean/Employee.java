package org.vector.crud.bean;

import javax.validation.constraints.Pattern;

public class Employee {
    private Integer empId;

    //jsr303进行数据校验时自定义规则
    @Pattern(regexp="(^[a-zA-Z0-9_-]{4,16}$)|(^[\\u2E80-\\u9FFF]{2,4})",message="用户可以是2-4位中文或4-16位英文字母组成")
    private String empName;

    private String gender;
    
    @Pattern(regexp="^[a-z\\d]+(\\.[a-z\\d]+)*@([\\da-z](-[\\da-z])?)+(\\.{1,2}[a-z]+)+$",message="邮箱格式不太正确哦!!!")
    private String email;

    private Integer dId;
    
    //查询员工的同时也能查询到相应的部门信息
    private Department  department;
    
    
    public Employee() {
		super();
	}

	public Employee(Integer empId, String empName, String gender, String email, Integer dId) {
		super();
		this.empId = empId;
		this.empName = empName;
		this.gender = gender;
		this.email = email;
		this.dId = dId;
	}

	public Department getDepartment() {
		return department;
	}

	public void setDepartment(Department department) {
		this.department = department;
	}

	public Integer getEmpId() {
        return empId;
    }

    public void setEmpId(Integer empId) {
        this.empId = empId;
    }

    public String getEmpName() {
        return empName;
    }

    public void setEmpName(String empName) {
        this.empName = empName == null ? null : empName.trim();
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender == null ? null : gender.trim();
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email == null ? null : email.trim();
    }

    public Integer getdId() {
        return dId;
    }

    public void setdId(Integer dId) {
        this.dId = dId;
    }

	@Override
	public String toString() {
		return "Employee [empId=" + empId + ", empName=" + empName + ", gender=" + gender + ", email=" + email
				+ ", dId=" + dId + ", department=" + department + "]";
	}
    
}