package com.xy.center.management.response;

import java.util.List;

/**
 * @Title: PageDataResult
 * @Description: 封装DTO分页数据（记录数和所有记录）
 *
 * @version: 1.0
 * @date: 2018/11/21 11:15
 */
public class PageDataResult {

	private Integer code = 200;

	/**
	 * 当前页码
	 */
	private int pageNum;
	/**
	 * 每页数量
	 */
	private int pageSize;
	/**
	 * 记录总数
	 */
	private long totalSize;
	/**
	 * 页码总数
	 */
	private int totalPages;

	private List<?> list;

	public Integer getCode() {
		return code;
	}

	public void setCode(Integer code) {
		this.code = code;
	}

	public List<?> getList() {
		return list;
	}

	public void setList(List<?> list) {
		this.list = list;
	}

	public int getPageNum() {
		return pageNum;
	}

	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public long getTotalSize() {
		return totalSize;
	}

	public void setTotalSize(long totalSize) {
		this.totalSize = totalSize;
	}

	public int getTotalPages() {
		return totalPages;
	}

	public void setTotalPages(int totalPages) {
		this.totalPages = totalPages;
	}

	@Override
	public String toString() {
		return "PageDataResult{" + "code=" + code + ", pageSize=" + pageSize + ", pageNum=" + pageNum + ", totalSize="
				+ totalSize + ", totalPages=" + totalPages + '}';
	}

}
