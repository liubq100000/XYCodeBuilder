package com.xy.system.codebuilder.ftl;

import java.util.ArrayList;
import java.util.List;

public class ConfigFactory {
    public static List<ConfigVO> getNormalFileList() {
        List<ConfigVO> voList = new ArrayList<>();
        voList.add(new ConfigVO("dao.ftl", "java", "dao", "I", "Dao.java"));
        voList.add(new ConfigVO("daoImpl.ftl", "java", "dao/impl", "", "DaoImpl.java"));
        voList.add(new ConfigVO("domain.ftl", "java", "domain", "", ".java"));
        voList.add(new ConfigVO("validator.ftl", "java", "domain/validator", "", "Validator.java"));
        voList.add(new ConfigVO("xml.ftl", "java", "domain/map", "", "Map.xml"));
        voList.add(new ConfigVO("service.ftl", "java", "service", "I", "Service.java"));
        voList.add(new ConfigVO("serviceImpl.ftl", "java", "service/impl", "", "ServiceImpl.java"));
        voList.add(new ConfigVO("controller.ftl", "java", "web", "", "Controller.java"));
        voList.add(new ConfigVO("listjs.ftl",false, "webapp/js", "", true,"", "List.js"));
        voList.add(new ConfigVO("formjs.ftl",false, "webapp/js", "", true,"", "Form.js"));
        voList.add(new ConfigVO("listjsp.ftl",true, "webapp/WEB-INF/web", "", true,"", "List.jsp"));
        voList.add(new ConfigVO("formjsp.ftl",true, "webapp/WEB-INF/web", "", true,"", "Form.jsp"));
        return voList;
    }

    public static List<ConfigVO> getWorkFlowFileList() {
        List<ConfigVO> voList = new ArrayList<>();
        voList.add(new ConfigVO("dao.ftl", "java", "dao", "I", "Dao.java"));
        voList.add(new ConfigVO("daoImpl.ftl", "java", "dao/impl", "", "DaoImpl.java"));
        voList.add(new ConfigVO("domain.ftl", "java", "domain", "", ".java"));
        voList.add(new ConfigVO("validator.ftl", "java", "domain/validator", "", "Validator.java"));
        voList.add(new ConfigVO("xml.ftl", "java", "domain/map", "", "Map.xml"));
        voList.add(new ConfigVO("service.ftl", "java", "service", "I", "Service.java"));
        voList.add(new ConfigVO("serviceImpl.ftl", "java", "service/impl", "", "ServiceImpl.java"));
        voList.add(new ConfigVO("controller.ftl", "java", "web", "", "Controller.java"));
        voList.add(new ConfigVO("todolistjs.ftl",false, "webapp/js", "", true,"", "_todoList.js"));
        voList.add(new ConfigVO("donelistjs.ftl",false, "webapp/js", "", true,"", "_doneList.js"));
        voList.add(new ConfigVO("formjs.ftl",false, "webapp/js", "", true,"", "_form.js"));
        voList.add(new ConfigVO("formvalidatejs.ftl",false, "webapp/js", "", true,"", ".validate.js"));
        voList.add(new ConfigVO("todolistjsp.ftl",true, "webapp/WEB-INF/web", "", true,"", "_todoList.jsp"));
        voList.add(new ConfigVO("donelistjsp.ftl",true, "webapp/WEB-INF/web", "", true,"", "_doneList.jsp"));
        voList.add(new ConfigVO("formjsp.ftl",true, "webapp/WEB-INF/web", "", true,"", "_form.jsp"));
        return voList;
    }
}
