package com.xy.system.codebuilder.ftl;

import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateExceptionHandler;

import java.io.File;
import java.io.IOException;

public class FreeMarkerInit {


    private FtlConfig ftlConfig;

    private FreeMarkerInit(FtlConfig config) {
        ftlConfig = config;
    }

    //静态工厂方法
    public static FreeMarkerInit getInstance(FtlConfig ftlConfig) {
        try {
            return new FreeMarkerInit(ftlConfig);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }

    }

    public Template getDefinedTemplate(String templateName) throws Exception {
        try {
            //配置类
            Configuration cfg = new Configuration();
            System.out.println("模板加载normal地址" + ftlConfig.getPath());
            cfg.setDirectoryForTemplateLoading(new File(ftlConfig.getPath() + "/normal"));
            cfg.setDefaultEncoding("UTF-8");
            cfg.setTemplateExceptionHandler(TemplateExceptionHandler.RETHROW_HANDLER);
            return cfg.getTemplate(templateName);
        } catch (IOException e) {
            e.printStackTrace();
            return null;
        }
    }

    public Template getWorkflowTemplate(String templateName) throws Exception {
        try {
            //配置类
            Configuration cfg = new Configuration();
            cfg.setDirectoryForTemplateLoading(new File(ftlConfig.getPath() + "/workflow"));
            System.out.println("模板加载workflow地址" + ftlConfig.getPath());
            cfg.setDefaultEncoding("UTF-8");
            cfg.setTemplateExceptionHandler(TemplateExceptionHandler.RETHROW_HANDLER);
            return cfg.getTemplate(templateName);
        } catch (IOException e) {
            e.printStackTrace();
            return null;
        }
    }
}
