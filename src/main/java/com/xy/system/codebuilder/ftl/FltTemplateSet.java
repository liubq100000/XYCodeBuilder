package com.xy.system.codebuilder.ftl;

import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateExceptionHandler;

import java.io.File;
import java.io.IOException;
import java.util.List;

public class FltTemplateSet {
    private List<FtlVO> files;
    private FtlConfig nowConfig;
    public String subPath;

    public FltTemplateSet(List<FtlVO> files, FtlConfig ftlConfig, String inSubPath) {
        this.files = files;
        this.nowConfig = ftlConfig;
        this.subPath = inSubPath;
    }

    public List<FtlVO> getFiles() {
        return files;
    }

    /**
     * 查询文件
     *
     * @param templateName
     * @return
     */
    public Template find(String templateName) {
        try {
            Configuration cfg = new Configuration();
            cfg.setDirectoryForTemplateLoading(new File(nowConfig.getPath() + "/" + subPath));
            cfg.setDefaultEncoding("UTF-8");
            cfg.setTemplateExceptionHandler(TemplateExceptionHandler.RETHROW_HANDLER);
            Template temp = cfg.getTemplate(templateName);
            if (temp != null) {
                System.out.println("模板加载workflow地址" + nowConfig.getPath() + "/" + subPath + "/" + templateName);
            } else {
                System.out.println("模板加载workflow地址" + nowConfig.getPath() + "/" + subPath + "/" + templateName + ",失败");
            }

            return temp;
        } catch (IOException e) {
            e.printStackTrace();
            return null;
        }
    }


}
