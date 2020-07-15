package com.xy.system.codebuilder.web;

import com.xy.center.management.response.PageDataResult;
import com.xy.system.codebuilder.domain.DataSourceVO;
import com.xy.system.codebuilder.service.IDataSourceService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.Map;

/**
 * @Title: test
 * @version: 1.0
 * @date: 2018/11/20 11:39
 */
@Controller
@RequestMapping("/dataSource")
public class DataSourceController {

    private Logger logger = LoggerFactory.getLogger(this.getClass());

    @Autowired
    private IDataSourceService billService;

    /**
     *
     * 功能描述: 跳到系统用户列表
     *
     * @param:
     * @return: 
     * @date: 2018/11/21 13:50
     */
    @RequestMapping("/dataSourceManage")
    public String dataSourceManage() {
        return "system/dataSourceManage";
    }

    /**
     *
     * 功能描述: 分页查询用户列表
     *
     * @param:
     * @return:
     *
     * @date: 2018/11/21 11:10
     */
    @RequestMapping(value = "/findList", method = RequestMethod.POST)
    @ResponseBody
    public PageDataResult getUserList(@RequestParam("pageNum") Integer pageNum,
                                      @RequestParam("pageSize") Integer pageSize,/*@Valid PageRequest page,*/ DataSourceVO cond) {
        /*logger.info("分页查询用户列表！搜索条件：userSearch：" + userSearch + ",pageNum:" + page.getPageNum()
                + ",每页记录数量pageSize:" + page.getPageSize());*/
        PageDataResult pdr = new PageDataResult();
        try {
            if(null == pageNum) {
                pageNum = 1;
            }
            if(null == pageSize) {
                pageSize = 10;
            }
            // 获取用户列表
            pdr = billService.findPage(cond, pageNum ,pageSize);
            logger.info("列表查询=pdr:" + pdr);

        } catch (Exception e) {
            e.printStackTrace();
            logger.error("列表查询异常！", e);
        }
        return pdr;
    }


    /**
     *
     * 功能描述: 新增和更新系统用户
     *
     * @param:
     * @return:
     * @date: 2018/11/22 10:14
     */
    @RequestMapping(value = "/saveDataSource", method = RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> setUser(DataSourceVO cond) {
        logger.info("设置[新增或更新]！user:" + cond);
        Map<String,Object> data = new HashMap<>();
        int res;
        if(cond.getId() == null){
            res = billService.addData(cond);
        }else{
            res = billService.updateData(cond);
        }
        data.put("code",res);
        return data;
    }


    /**
     *
     * 功能描述: 删除/恢复 用户
     *
     * @param:
     * @return:
     *
     * @date: 2018/11/22 11:59
     */
    @RequestMapping(value = "/deleteDataSource", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> updateUserStatus(@RequestParam("id") Long id) {
        logger.info("删除/恢复！id:" + id);
        Map<String, Object> data = new HashMap<>();
        int res = billService.deleteData(id);
        data.put("code",res);
        return data;
    }


}
