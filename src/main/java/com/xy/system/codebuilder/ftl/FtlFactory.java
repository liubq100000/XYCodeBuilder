package com.xy.system.codebuilder.ftl;

import java.util.ArrayList;
import java.util.List;

public class FtlFactory {

    public static FtlVOSet get(final String selectMode, final FtlPath inFtlConfig){
        if("WorkFlow".equalsIgnoreCase(selectMode)){
            return getWorkFlowFileList(inFtlConfig);
        } else if("NewFile".equalsIgnoreCase(selectMode)){
            return getNewFileList(inFtlConfig);
        }  else if("NewWfFile".equalsIgnoreCase(selectMode)){
            return getNewWfFileList(inFtlConfig);
        } else {
            return getNormalFileList(inFtlConfig);
        }
    }

    private  static FtlVOSet getNormalFileList(final FtlPath inFtlConfig) {
        List<FtlVO> voList = new ArrayList<>();
        voList.add(new FtlVO("dao.ftl", "java", "dao", "I", "Dao.java"));
        voList.add(new FtlVO("daoImpl.ftl", "java", "dao/impl", "", "DaoImpl.java"));
        voList.add(new FtlVO("domain.ftl", "java", "domain", "", ".java"));
        voList.add(new FtlVO("validator.ftl", "java", "domain/validator", "", "Validator.java"));
        voList.add(new FtlVO("xml.ftl", "java", "domain/map", "", "Map.xml"));
        voList.add(new FtlVO("service.ftl", "java", "service", "I", "Service.java"));
        voList.add(new FtlVO("serviceImpl.ftl", "java", "service/impl", "", "ServiceImpl.java"));
        voList.add(new FtlVO("controller.ftl", "java", "web", "", "Controller.java"));
        voList.add(new FtlVO("listjs.ftl", false, "webapp/js", "", true, "", "List.js"));
        voList.add(new FtlVO("formjs.ftl", false, "webapp/js", "", true, "", "Form.js"));
        voList.add(new FtlVO("listjsp.ftl", true, "webapp/WEB-INF/web", "", true, "", "List.jsp"));
        voList.add(new FtlVO("formjsp.ftl", true, "webapp/WEB-INF/web", "", true, "", "Form.jsp"));
        return new FtlVOSet(voList, inFtlConfig, "normal");
    }

    private static FtlVOSet getWorkFlowFileList(final FtlPath inFtlConfig) {
        List<FtlVO> voList = new ArrayList<>();
        voList.add(new FtlVO("dao.ftl", "java", "dao", "I", "Dao.java"));
        voList.add(new FtlVO("daoImpl.ftl", "java", "dao/impl", "", "DaoImpl.java"));
        voList.add(new FtlVO("domain.ftl", "java", "domain", "", ".java"));
        voList.add(new FtlVO("validator.ftl", "java", "domain/validator", "", "Validator.java"));
        voList.add(new FtlVO("xml.ftl", "java", "domain/map", "", "Map.xml"));
        voList.add(new FtlVO("service.ftl", "java", "service", "I", "Service.java"));
        voList.add(new FtlVO("serviceImpl.ftl", "java", "service/impl", "", "ServiceImpl.java"));
        voList.add(new FtlVO("controller.ftl", "java", "web", "", "Controller.java"));
        voList.add(new FtlVO("todolistjs.ftl", false, "webapp/js", "", true, "", "_todoList.js"));
        voList.add(new FtlVO("donelistjs.ftl", false, "webapp/js", "", true, "", "_doneList.js"));
        voList.add(new FtlVO("formjs.ftl", false, "webapp/js", "", true, "", "_form.js"));
        voList.add(new FtlVO("formvalidatejs.ftl", false, "webapp/js", "", true, "", ".validate.js"));
        voList.add(new FtlVO("todolistjsp.ftl", true, "webapp/WEB-INF/web", "", true, "", "_todoList.jsp"));
        voList.add(new FtlVO("donelistjsp.ftl", true, "webapp/WEB-INF/web", "", true, "", "_doneList.jsp"));
        voList.add(new FtlVO("formjsp.ftl", true, "webapp/WEB-INF/web", "", true, "", "_form.jsp"));
        return new FtlVOSet(voList, inFtlConfig, "workflow");
    }

    private static FtlVOSet getNewFileList(final FtlPath inFtlConfig) {
        List<FtlVO> voList = new ArrayList<>();
        voList.add(new FtlVO("xml.ftl", "java", "mapper/mapping", "", "Mapper.xml"));
        voList.add(new FtlVO("domain.ftl", "java", "entity", "", ".java"));
        voList.add(new FtlVO("bean.ftl", "java", "model", "", "Bean.java"));
        voList.add(new FtlVO("service.ftl", "java", "service", "I", "Service.java"));
        voList.add(new FtlVO("serviceImpl.ftl", "java", "service/impl", "", "ServiceImpl.java"));
        voList.add(new FtlVO("mapper.ftl", "java", "mapper", "", "Mapper.java"));
        voList.add(new FtlVO("controller.ftl", "java", "controller", "", "Controller.java"));
        voList.add(new FtlVO("htmllist.ftl", true, "webapp/pages", "", true, "", ".html"));
        voList.add(new FtlVO("htmlfrom.ftl", true, "webapp/pages", "", true, "", "Form.html"));
        voList.add(new FtlVO("jslist.ftl", true, "webapp/assets", "", true, "", ".js"));
        voList.add(new FtlVO("jsform.ftl", true, "webapp/assets", "", true, "", "Form.js"));
        return new FtlVOSet(voList, inFtlConfig, "newfile",1);
    }


    private static FtlVOSet getNewWfFileList(final FtlPath inFtlConfig) {
        List<FtlVO> voList = new ArrayList<>();
        voList.add(new FtlVO("xml.ftl", "java", "mapper/mapping", "", "Mapper.xml"));
        voList.add(new FtlVO("domain.ftl", "java", "entity", "", ".java"));
        voList.add(new FtlVO("bean.ftl", "java", "model", "", "Bean.java"));
        voList.add(new FtlVO("service.ftl", "java", "service", "I", "Service.java"));
        voList.add(new FtlVO("serviceImpl.ftl", "java", "service/impl", "", "ServiceImpl.java"));
        voList.add(new FtlVO("mapper.ftl", "java", "mapper", "", "Mapper.java"));
        voList.add(new FtlVO("controller.ftl", "java", "controller", "", "Controller.java"));
        voList.add(new FtlVO("htmlfrom.ftl", true, "webapp/pages", "", true, "", "_form.html"));
        voList.add(new FtlVO("jsform.ftl", true, "webapp/assets", "", true, "", "_form.js"));
        return new FtlVOSet(voList, inFtlConfig, "newwffile",1);
    }
}
