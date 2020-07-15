package com.xy.center.management.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.mybatis.mapper.BaseMapper;
import org.springframework.stereotype.Repository;

import com.xy.center.management.pojo.BaseAdminRole;

@Repository
public interface BaseAdminRoleMapper extends BaseMapper<BaseAdminRole> {

    List<BaseAdminRole> getRoleList();

    List<BaseAdminRole> getRoles();

    int updateRole(BaseAdminRole role);

    int updateRoleStatus(@Param("id") Integer id,@Param("roleStatus") Integer roleStatus);

}