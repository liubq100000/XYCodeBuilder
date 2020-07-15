package com.xy.center.management.dao;


import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.mybatis.mapper.BaseMapper;
import org.springframework.stereotype.Repository;

import com.xy.center.management.dto.PermissionDTO;
import com.xy.center.management.pojo.BaseAdminPermission;

@Repository
public interface BaseAdminPermissionMapper extends BaseMapper<BaseAdminPermission> {
    List<PermissionDTO> getPermissionList();

    List<PermissionDTO> parentPermissionList();

    int updatePermission(BaseAdminPermission permission);

    List<PermissionDTO> getPermissionListByPId(@Param("pid") Integer pid);
}