package com.xy.center.management.dao;


import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.mybatis.mapper.BaseMapper;
import org.springframework.stereotype.Repository;

import com.xy.center.management.dto.AdminUserDTO;
import com.xy.center.management.dto.UserSearchDTO;
import com.xy.center.management.pojo.BaseAdminUser;

@Repository
public interface BaseAdminUserMapper extends BaseMapper<BaseAdminUser> {

    List<AdminUserDTO> getUserList(UserSearchDTO userSearchDTO);

    BaseAdminUser getUserByUserName(@Param("sysUserName")String sysUserName,@Param("id") Integer id);

    int updateUserStatus(@Param("id") Integer id,@Param("status") Integer status);

    int updateUser(BaseAdminUser user);

    BaseAdminUser findByUserName(@Param("userName") String userName);

    int updatePwd(@Param("userName") String userName,@Param("password") String password);

}