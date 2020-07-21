package com.xy.system.codebuilder.web;

import com.xy.center.management.common.utils.JsonUtil;
import com.xy.system.codebuilder.domain.DataSourceVO;
import com.xy.system.codebuilder.ftl.*;
import com.xy.system.codebuilder.service.IDataSourceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

/**
 * @Title: 生成代码
 * @version: 1.0
 * @date: 2018/11/20 11:39
 */
@Controller
@RequestMapping("/code")
public class CodeBuilderController {

    @Autowired
    private IDataSourceService billService;

    @Autowired
    private FtlConfig ftlConfig;

    private ScheduledExecutorService executorService;

    @PostConstruct
    public void init() {
        executorService = Executors.newScheduledThreadPool(1);
        //清理过期目录
        executorService.scheduleWithFixedDelay(new Runnable() {
            @Override
            public void run() {
                try {
                    System.out.println("清理作业执行");
                    FileUtil.deleteFile(new File(ftlConfig.getOut()), 1000L * 3600 * 2);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }, 10, 30, TimeUnit.MINUTES);
    }

    /**
     * 功能描述: 跳到系统用户列表
     *
     * @param:
     * @return:
     * @date: 2018/11/21 13:50
     */
    @RequestMapping("/codebuild")
    public String codebuild(HttpServletRequest req, HttpServletResponse resp) {
        req.setAttribute("selectId", req.getParameter("selectId"));
        req.setAttribute("selectTableNow", req.getParameter("selectTableNow"));
        return "system/codeAssembly";
    }

    /**
     * 查询所有的表
     *
     * @return
     */
    @RequestMapping(value = "/columnInfo", method = {RequestMethod.POST, RequestMethod.GET})
    @ResponseBody
    public Map<String, Object> columnInfo(HttpServletRequest req) {
        Map<String, Object> resMap = new HashMap<>();
        try {
            String selectId = req.getParameter("selectId");
            String selectTableNow = req.getParameter("selectTableNow");
            //查询数据源
            DataSourceVO nowVO = billService.findById(Long.valueOf(selectId));
            List<Attribute> attList = MetadataUtil.getTableColumnsInfo(nowVO, selectTableNow);
            resMap.put("code", "000000");
            resMap.put("attList", attList);
            return resMap;
        } catch (Exception e) {
            e.printStackTrace();
            resMap.put("code", "000001");
            resMap.put("message", e.getMessage());
        }
        return resMap;
    }


    /**
     * 查询所有的表
     *
     * @param cond
     * @return
     */
    @RequestMapping(value = "/tableInfo", method = {RequestMethod.POST, RequestMethod.GET})
    @ResponseBody
    public List<String> tableInfo(DataSourceVO cond) {
        try {
            DataSourceVO nowVO = billService.findById(cond.getId());
            return MetadataUtil.getTableInfo(nowVO);
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }

    /**
     * 生成代码
     *
     * @param:
     * @return:
     * @date: 2018/11/21 11:10
     */
    @RequestMapping(value = "/build", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> build(HttpServletRequest req, HttpServletResponse resp) {
        Map<String, Object> result = new HashMap<>();
        String formDataStr = req.getParameter("formData");
        List<PageAttribute> formDataList = (List<PageAttribute>) JsonUtil.json2Array(formDataStr, PageAttribute.class);
        Map<String, PageAttribute> formDataMap = buildParaMap(formDataList);

        String listDataStr = req.getParameter("listData");
        List<PageAttribute> listDataList = (List<PageAttribute>) JsonUtil.json2Array(listDataStr, PageAttribute.class);
        Map<String, PageAttribute> listDataMap = buildParaMap(listDataList);


        String queryDataStr = req.getParameter("queryData");
        List<PageAttribute> queryDataList = (List<PageAttribute>) JsonUtil.json2Array(queryDataStr, PageAttribute.class);
        Map<String, PageAttribute> queryDataMap = buildParaMap(queryDataList);
        return doAction(req, formDataMap, listDataMap, queryDataMap);
    }

    /**
     * 构造参加结构
     *
     * @param list
     * @return
     */
    private Map<String, PageAttribute> buildParaMap(List<PageAttribute> list) {
        Map<String, PageAttribute> dataMap = new HashMap<>();
        String name;
        for (PageAttribute pa : list) {
            if (pa.getName() == null) {
                continue;
            }
            dataMap.put(pa.getName(), pa);
        }
        return dataMap;
    }


    /**
     * 生成代码
     *
     * @param req
     * @param formDataMap
     * @param listDataMap
     * @param queryDataMap
     * @return
     */
    private Map<String, Object> doAction(HttpServletRequest req,
                                         Map<String, PageAttribute> formDataMap,
                                         Map<String, PageAttribute> listDataMap,
                                         Map<String, PageAttribute> queryDataMap) {
        Map<String, Object> result = new HashMap<>();
        result.put("code", 1);
        String selectId = req.getParameter("selectId");
        String selectTableNow = req.getParameter("selectTableNow");
        String selectProjectName = req.getParameter("selectProjectName");
        String selectTableBaseDir = req.getParameter("selectTableBaseDir");
        String selectMode = req.getParameter("selectMode");
        if (selectTableBaseDir.endsWith(".") || selectTableBaseDir.startsWith(".")) {
            result.put("code", 2);
            result.put("msg", "基础目录不正确");
            return result;
        }
        String[] dirs = selectTableBaseDir.split("\\.");
        if (dirs.length < 4) {
            result.put("code", 2);
            result.put("msg", "基础目录不正确");
            return result;
        }
        try {
            //查询数据源
            DataSourceVO nowVO = billService.findById(Long.valueOf(selectId));
            if (nowVO == null) {
                result.put("code", 2);
                result.put("msg", "数据源不存在");
                return result;
            }
            //生成代码
            String savePath = FtlServer.build(nowVO, ftlConfig, selectTableNow,selectProjectName, selectTableBaseDir, selectMode,formDataMap, listDataMap, queryDataMap);
            //保存目录
            req.getSession().setAttribute("zipDir", savePath);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    /**
     * 下载代码
     *
     * @param req
     * @param resp
     */
    @RequestMapping(value = "/down", method = {RequestMethod.GET})
    public void down(HttpServletRequest req, HttpServletResponse resp) {
        try {
            String zipDir = (String) req.getSession().getAttribute("zipDir");
            ZipUtil.downZipFile(new File(zipDir), resp);
        } catch (Exception e) {
            e.printStackTrace();
            try {
                resp.setCharacterEncoding("UTF-8");
                resp.setContentType("application/json");
                resp.getWriter().write(e.getMessage());
                resp.getWriter().flush();
                resp.getWriter().close();
            } catch (IOException e1) {
                e1.printStackTrace();
            }
        }
    }


}
