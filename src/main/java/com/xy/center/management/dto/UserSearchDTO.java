package com.xy.center.management.dto;

/**
 * @Title: UserSearchDTO
 * @Description:
 * @version: 1.0
 * @date: 2018/11/21 11:19
 */
public class UserSearchDTO implements java.io.Serializable {
    private String sysUserName;

    private String userPhone;

    private String startTime;

    private String endTime;

    public String getSysUserName() {
        return sysUserName;
    }

    public void setSysUserName(String sysUserName) {
        this.sysUserName = sysUserName;
    }

    public String getUserPhone() {
        return userPhone;
    }

    public void setUserPhone(String userPhone) {
        this.userPhone = userPhone;
    }

    public String getStartTime() {
        return startTime;
    }

    public void setStartTime(String startTime) {
        this.startTime = startTime;
    }

    public String getEndTime() {
        return endTime;
    }

    public void setEndTime(String endTime) {
        this.endTime = endTime;
    }

}
