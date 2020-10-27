package com.xy.system.codebuilder.ftl;

import com.xy.system.codebuilder.domain.DataSourceVO;
import freemarker.template.Template;

import java.io.*;
import java.nio.charset.Charset;
import java.util.*;
import java.util.stream.Collectors;

/**
 * ftl服务
 */
public class FtlServer {

    /**
     * 表单
     *
     * @return
     * @throws Exception
     */
    public static List<PageAttributeRow> assemblyForm(List<PageAttribute> list) throws Exception {
        List<PageAttributeRow> resList = new ArrayList<>();
        int pageRow = PageAttribute.FORM_WIDTH_SIZE;
        int nowLeft = pageRow;
        PageAttributeRow nowRow = new PageAttributeRow();
        int width = 0;
        for (PageAttribute item : list) {
            width = item.getWidthNum();
            if (width > nowLeft) {
                if (nowRow.getRowList().size() > 0) {
                    resList.add(nowRow);
                }
                nowRow = new PageAttributeRow();
                nowRow.getRowList().add(item);
                nowLeft = pageRow - width;
            } else {
                nowRow.getRowList().add(item);
                nowLeft = nowLeft - width;
            }
        }
        if (nowRow.getRowList().size() > 0) {
            resList.add(nowRow);
        }
        return resList;
    }

    /**
     * 查询条件
     *
     * @return
     * @throws Exception
     */
    public static List<PageAttributeRow> assemblyCond(List<PageAttribute> list) throws Exception {
        List<PageAttributeRow> resList = new ArrayList<>();
        int pageSize = 2;
        int len = list.size() / pageSize;
        if (list.size() % pageSize > 0) {
            len = len + 1;
        }
        int pos = 0;
        for (int index = 0; index < len; index++) {
            List<PageAttribute> nowList = new ArrayList<>();
            for (int z = 0; z < pageSize; z++) {
                pos = index * pageSize + z;
                if (pos >= list.size()) {
                    nowList.add(new PageAttribute());
                } else {
                    nowList.add(list.get(pos));
                }

            }
            PageAttributeRow newRow = new PageAttributeRow();
            newRow.setRowList(nowList);
            resList.add(newRow);
        }
        return resList;
    }

    /**
     * 过滤
     *
     * @return
     * @throws Exception
     */
    public static List<PageAttribute> filterCond(Map<String, PageAttribute> queryDataMap) throws Exception {
        List<PageAttribute> resList = new ArrayList<>();
        for (PageAttribute entry : queryDataMap.values()) {
            if ("Y".equalsIgnoreCase(entry.getDisplay())) {
                resList.add(entry);
            }
        }
        Collections.sort(resList, new Comparator<PageAttribute>() {
            @Override
            public int compare(PageAttribute t0, PageAttribute t1) {
                return t0.getSortNum().compareTo(t1.getSortNum());
            }
        });
        return resList;
    }

    /**
     * 生成地址
     *
     * @param nowVO
     * @param ftlConfig
     * @param selectTableNow
     * @param selectTableBaseDir
     * @return
     * @throws Exception
     */
    public static String build(DataSourceVO nowVO, FtlPath ftlConfig,
                               String selectTableNow,
                               String selectProjectName,
                               String selectTableBaseDir,
                               String selectMode,
                               Map<String, PageAttribute> formDataMap,
                               Map<String, PageAttribute> listDataMap,
                               Map<String, PageAttribute> queryDataMap) throws Exception {
        //属性共享
        PageAttribute nowPageAtt;
        for (PageAttribute pageAtt : formDataMap.values()) {
            nowPageAtt = queryDataMap.get(pageAtt.getName());
            if (nowPageAtt != null) {
                nowPageAtt.setDisType(pageAtt.getDisType());
                nowPageAtt.setDicCode(pageAtt.getDicCode());
                nowPageAtt.setDicParentCode(pageAtt.getDicParentCode());
            }
            nowPageAtt = listDataMap.get(pageAtt.getName());
            if (nowPageAtt != null) {
                nowPageAtt.setDisType(pageAtt.getDisType());
                nowPageAtt.setDicCode(pageAtt.getDicCode());
                nowPageAtt.setDicParentCode(pageAtt.getDicParentCode());
            }
        }
        //加载模板
        FtlVOSet templateSet = FtlFactory.get(selectMode, ftlConfig);
        //固定变量
        Map<String, Object> context = new HashMap<String, Object>();
        context.put("basePackage", JavaNameUtil.getPackage(selectTableBaseDir));
        context.put("basePath", JavaNameUtil.getPath(selectTableBaseDir));
        context.put("tableName", selectTableNow);
        context.put("selectProjectName", selectProjectName);
        String[] dirs = selectTableBaseDir.split("\\.");
        String subTableName = selectTableNow;
        int firstSplit = subTableName.indexOf("_");
        //保护两个分割符号
        if (firstSplit > 0) {
            int secondSplit = subTableName.indexOf("_", firstSplit);
            if (secondSplit > 0) {
                subTableName = subTableName.substring(firstSplit + 1);
            }
        }
        String className = JavaNameUtil.toPascal(subTableName);
        String className2 = JavaNameUtil.toCamel(subTableName);
        context.put("className", className);
        context.put("className2", className2);
        context.put("className3", className.toLowerCase());

        String minPath = dirs[dirs.length - 1];
        context.put("minPath", minPath);
        String modulePath = dirs[dirs.length - 2];
        context.put("modulePath", modulePath);
        List<PageAttribute> queryItemList = filterCond(queryDataMap);
        Map<String, PageAttribute> queryAttMap = queryItemList.parallelStream().collect(Collectors.toMap(queryAtt -> {
            return queryAtt.getName();
        }, queryAtt -> {
            return queryAtt;
        }));
        List<PageAttribute> listItemList = filterCond(listDataMap);
        List<PageAttribute> formItemList = filterCond(formDataMap);
        context.put("queryItemList", queryItemList);
        context.put("listItemList", listItemList);
        context.put("formItemList", formItemList);
        context.put("queryRowList", assemblyCond(queryItemList));
        context.put("formRowList", assemblyForm(formItemList));
        //Attribute里面封装模板使用属性
        List<Attribute> attrList = MetadataUtil.getTableColumnsInfo(nowVO, selectTableNow);
        PageAttribute nowItem;
        String hasHeadId = "N";
        for (Attribute att : attrList) {
            nowItem = queryDataMap.get(att.getCamelName());
            if (nowItem != null) {
                if ("Y".equalsIgnoreCase(nowItem.getQuery())) {
                    att.setQueryByLike(2);
                }
            }
            nowItem = formDataMap.get(att.getCamelName());
            if (nowItem != null) {
                att.setDisType(nowItem.getDisType());
                att.setDicCode(nowItem.getDicCode());
                att.setDicParentCode(nowItem.getDicParentCode());
            }
            att.setMode(templateSet.getMode());
            if(att.getColumnName().equalsIgnoreCase("head_id")){
                hasHeadId = "Y";
            }
        }
        context.put("attrs", attrList);
        context.put("hasHeadId", hasHeadId);
        //生成路径
        String savePath = ftlConfig.getOut() + "//" + System.currentTimeMillis();
        //轮询文件
        for (FtlVO vo : templateSet.getFiles()) {
            String nowPath = savePath + "/" + vo.getPrePath() + "/";
            if (vo.isShortPath()) {
                nowPath += modulePath + "/" + minPath + "/";
            } else {
                nowPath += selectTableBaseDir + "/";
            }
            nowPath = JavaNameUtil.getPath(nowPath, vo.getAfterPath());
            String packageName = JavaNameUtil.getPackage(selectTableBaseDir, vo.getAfterPath());

            //获取模板
            Template temp = templateSet.find(vo.getFtlName());
            context.put("packageName", packageName);
            String classFileName = vo.getPreName() + className + vo.getAfterName();
            if (vo.isShortName()) {
                classFileName = vo.getPreName() + className2 + vo.getAfterName();
            }
            File file = new File(nowPath, classFileName);
            if (!file.getParentFile().exists()) {
                file.getParentFile().mkdirs();
            }
            OutputStream fos = new FileOutputStream(file);
            Writer out = new OutputStreamWriter(fos, Charset.forName("UTF-8"));
            try {
                temp.process(context, out);
            } catch (Exception ex) {
                ex.printStackTrace();
            } finally {
                try {
                    fos.flush();
                } catch (Exception ex) {
                }
                try {
                    fos.close();
                } catch (Exception ex) {
                }
                try {
                    out.close();
                } catch (Exception ex) {
                }
            }
        }
        return savePath;
    }
}
