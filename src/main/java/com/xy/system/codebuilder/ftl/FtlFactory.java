package com.xy.system.codebuilder.ftl;

import java.util.ArrayList;
import java.util.List;

public class FtlFactory {

    public static FltTemplateSet get(final String selectMode,final FtlConfig inFtlConfig){
        if("WorkFlow".equalsIgnoreCase(selectMode)){
            return getWorkFlowFileList(inFtlConfig);
        } else if("NewFile".equalsIgnoreCase(selectMode)){
            return getNewFileList(inFtlConfig);
        } else {
            return getNormalFileList(inFtlConfig);
        }
    }

    private  static FltTemplateSet getNormalFileList(final FtlConfig inFtlConfig) {
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
        return new FltTemplateSet(voList, inFtlConfig, "normal");
    }

    private static FltTemplateSet getWorkFlowFileList(final FtlConfig inFtlConfig) {
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
        return new FltTemplateSet(voList, inFtlConfig, "workflow");
    }

    private static FltTemplateSet getNewFileList(final FtlConfig inFtlConfig) {
        List<FtlVO> voList = new ArrayList<>();
        voList.add(new FtlVO("domain.ftl", "java", "entity", "", ".java"));
        voList.add(new FtlVO("param.ftl", "java", "model/params", "", "Param.java"));
        voList.add(new FtlVO("result.ftl", "java", "model/result", "", "Result.java"));
        voList.add(new FtlVO("service.ftl", "java", "service", "I", "Service.java"));
        voList.add(new FtlVO("serviceImpl.ftl", "java", "service/impl", "", "ServiceImpl.java"));
        voList.add(new FtlVO("mapper.ftl", "java", "mapper", "", "Mapper.java"));
        voList.add(new FtlVO("xml.ftl", "java", "mapper/mapping", "", "Mapper.xml"));
        voList.add(new FtlVO("controller.ftl", "java", "controller", "", "Controller.java"));
        return new FltTemplateSet(voList, inFtlConfig, "newfile");
    }
}
