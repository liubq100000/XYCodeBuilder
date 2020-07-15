package com.xy.system.codebuilder.service;

import com.xy.center.management.dto.UserSearchDTO;
import com.xy.center.management.response.PageDataResult;
import com.xy.system.codebuilder.domain.DataSourceVO;

import java.util.List;
import java.util.Map;


/**
 * @Description:
 * @version: 1.0
 * @date: 2018/11/21 11:04
 */
public interface IDataSourceService {

    PageDataResult findPage(DataSourceVO cond, Integer pageNum, Integer pageSize);

    List<DataSourceVO> findList(DataSourceVO cond);

    DataSourceVO findById(Long id);

    int updateData(DataSourceVO cond);

    int deleteData(Long id);

    int addData(DataSourceVO cond);
}
