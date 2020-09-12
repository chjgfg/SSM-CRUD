package org.vector.crud.bean;

import java.util.HashMap;
import java.util.Map;

/*
 * 通用的返回类 
 */
public class Massage {

	// 状态码 100成功 200失败
	private int code;
	// 提示信息
	private String msg;
	// 用户要返回给浏览器的信息
	private Map<String, Object> map = new HashMap<String, Object>();

	//处理成功
	public static Massage success() {
		Massage massage = new Massage();
		massage.setCode(100);
		massage.setMsg("处理成功");
		return massage;
	}

	//处理失败
	public static Massage fail() {
		Massage massage = new Massage();
		massage.setCode(200);
		massage.setMsg("处理失败");
		return massage;
	}

	public Massage add(String key, Object value) {
		this.getMap().put(key, value);
		return this;
	}

	public int getCode() {
		return code;
	}

	public void setCode(int code) {
		this.code = code;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public Map<String, Object> getMap() {
		return map;
	}

	public void setMap(Map<String, Object> map) {
		this.map = map;
	}

}
