package com.xy.system.codebuilder.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.xy.center.management.response.PageDataResult;
import com.xy.system.codebuilder.dao.DataSourceMapper;
import com.xy.system.codebuilder.domain.DataSourceVO;
import com.xy.system.codebuilder.service.IDataSourceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Description:
 * @version: 1.0
 * @date: 2018/11/21 11:04
 */
@Service
@Primary
public class DataSourceServiceImpl implements IDataSourceService {


    @Autowired
    private DataSourceMapper billMapper;


    @Override
    public PageDataResult findPage(DataSourceVO cond, Integer pageNum, Integer pageSize) {
        PageDataResult pageDataResult = new PageDataResult();
        PageHelper.startPage(pageNum, pageSize);
        List<DataSourceVO> dataSourceVOList = billMapper.findList(cond);
        if (dataSourceVOList.size() != 0) {
            PageInfo<DataSourceVO> pageInfo = new PageInfo<>(dataSourceVOList);
            pageDataResult.setList(dataSourceVOList);
            pageDataResult.setPageSize(pageInfo.getPageSize());
            pageDataResult.setPageNum(pageInfo.getPageNum());
            pageDataResult.setTotalPages(pageInfo.getPages());
            pageDataResult.setTotalSize((int) pageInfo.getTotal());
        }

        return pageDataResult;
    }

    @Override
    public List<DataSourceVO> findList(DataSourceVO cond) {
        List<DataSourceVO> dataSourceVOList = billMapper.findList(cond);
        return dataSourceVOList;
    }

    @Override
    public DataSourceVO findById(Long id) {
        DataSourceVO cond = new DataSourceVO();
        cond.setId(id);
        return billMapper.queryOne(cond);
    }

    @Override
    public int updateData(DataSourceVO cond) {
        int result = billMapper.updateData(cond);
        return result;
    }

    @Override
    public int deleteData(Long id) {
        DataSourceVO cond = new DataSourceVO();
        cond.setId(id);
        int result = billMapper.deleteData(cond);
        return result;
    }

    @Override
    public int addData(DataSourceVO cond) {
        int result = billMapper.insertData(cond);
        return result;
    }
}
