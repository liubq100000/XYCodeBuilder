package com.xy.system.codebuilder.dao;


import com.xy.system.codebuilder.domain.DataSourceVO;
import org.mybatis.mapper.BaseMapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface DataSourceMapper extends BaseMapper<DataSourceVO> {

    List<DataSourceVO> findList(DataSourceVO cond);

    DataSourceVO queryOne(DataSourceVO cond);

    int updateData(DataSourceVO cond);

    int deleteData(DataSourceVO cond);

    int insertData(DataSourceVO cond);

}