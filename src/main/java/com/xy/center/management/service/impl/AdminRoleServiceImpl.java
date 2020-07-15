package com.xy.center.management.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.xy.center.management.common.utils.DateUtils;
import com.xy.center.management.dao.BaseAdminPermissionMapper;
import com.xy.center.management.dao.BaseAdminRoleMapper;
import com.xy.center.management.dto.AdminRoleDTO;
import com.xy.center.management.pojo.BaseAdminPermission;
import com.xy.center.management.pojo.BaseAdminRole;
import com.xy.center.management.response.PageDataResult;
import com.xy.center.management.service.AdminRoleService;

/**
 * @Title: AdminRoleServiceImpl
 * @Description:
 *
 * @version: 1.0
 * @date: 2018/11/21 14:26
 */
@Service
@Primary
public class AdminRoleServiceImpl implements AdminRoleService {

	private Logger logger = LoggerFactory.getLogger(this.getClass());

	@Autowired
	private BaseAdminRoleMapper baseAdminRoleMapper;

	@Autowired
	private BaseAdminPermissionMapper baseAdminPermission;

	@Override
	public PageDataResult getRoleList(Integer pageNum, Integer pageSize) {
		PageDataResult pageDataResult = new PageDataResult();
		List<BaseAdminRole> roles = baseAdminRoleMapper.getRoleList();

		List<AdminRoleDTO> roleList = new ArrayList<>();
		for (BaseAdminRole r : roles) {
			AdminRoleDTO roleDTO = new AdminRoleDTO();

			String permissions = r.getPermissions();
			BeanUtils.copyProperties(r, roleDTO);
			roleDTO.setPermissionIds(permissions);

			if (!StringUtils.isEmpty(permissions)) {
				String[] ids = permissions.split(",");
				List<String> p = new ArrayList<>();
				for (String id : ids) {
					BaseAdminPermission baseAdminPermission = this.baseAdminPermission.selectByPrimaryKey(id);
					String name = baseAdminPermission.getName();
					p.add(name);
				}
				roleDTO.setPermissions(p.toString());
			}
			roleList.add(roleDTO);
		}

		PageHelper.startPage(pageNum, pageSize);

		if (roleList.size() != 0) {
			PageInfo<AdminRoleDTO> pageInfo = new PageInfo<>(roleList);
			pageDataResult.setList(roleList);
			pageDataResult.setPageNum(pageInfo.getPageNum());
			pageDataResult.setPageSize(pageInfo.getPageSize());
			pageDataResult.setTotalPages(pageInfo.getPages());
			pageDataResult.setTotalSize((int) pageInfo.getTotal());
		}
		return pageDataResult;
	}

	@Override
	public Map<String, Object> addRole(BaseAdminRole role) {
		Map<String, Object> data = new HashMap<>();
		try {
			role.setCreateTime(DateUtils.getCurrentDate());
			role.setUpdateTime(DateUtils.getCurrentDate());
			role.setRoleStatus(1);
			int result = baseAdminRoleMapper.insert(role);
			if (result == 0) {
				data.put("code", 0);
				data.put("msg", "新增角色失败");
				logger.error("新增角色失败");
				return data;
			}
			data.put("code", 1);
			data.put("msg", "新增角色成功");
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("添加角色并授权！异常！", e);
		}
		return data;

	}

	@Override
	public BaseAdminRole findRoleById(Integer id) {
		return baseAdminRoleMapper.selectByPrimaryKey(id);
	}

	@Override
	public Map<String, Object> updateRole(BaseAdminRole role) {
		Map<String, Object> data = new HashMap<>();
		try {
			role.setUpdateTime(DateUtils.getCurrentDate());
			int result = baseAdminRoleMapper.updateRole(role);
			if (result == 0) {
				data.put("code", 0);
				data.put("msg", "更新失败！");
				logger.error("角色[更新]，结果=更新失败！");
				return data;
			}
			data.put("code", 1);
			data.put("msg", "更新成功！");
			logger.info("角色[更新]，结果=更新成功！");
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("角色[更新]异常！", e);
			return data;
		}
		return data;
	}

	@Override
	public Map<String, Object> delRole(Integer id, Integer status) {
		Map<String, Object> data = new HashMap<>();
		try {
			int result = baseAdminRoleMapper.updateRoleStatus(id, status);
			if (result == 0) {
				data.put("code", 0);
				data.put("msg", "删除角色失败");
			}
			data.put("code", 1);
			data.put("msg", "删除角色成功");
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("删除角色异常！", e);
		}
		return data;
	}

	@Override
	public Map<String, Object> recoverRole(Integer id, Integer status) {
		Map<String, Object> data = new HashMap<>();
		try {
			int result = baseAdminRoleMapper.updateRoleStatus(id, status);
			if (result == 0) {
				data.put("code", 0);
				data.put("msg", "恢复角色失败");
			}
			data.put("code", 1);
			data.put("msg", "恢复角色成功");
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("恢复角色异常！", e);
		}
		return data;
	}

	@Override
	public List<BaseAdminRole> getRoles() {
		return baseAdminRoleMapper.getRoleList();
	}
}
