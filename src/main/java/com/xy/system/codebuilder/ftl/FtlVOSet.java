package com.xy.system.codebuilder.ftl;

import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateExceptionHandler;

import java.io.File;
import java.io.IOException;
import java.util.List;

public class FtlVOSet {
    private List<FtlVO> files;
    private FtlPath nowConfig;
    public String subPath;

    public Integer mode;
    public FtlVOSet(List<FtlVO> files, FtlPath ftlConfig, String inSubPath) {
        this(files,ftlConfig,inSubPath,0);

    }

    public FtlVOSet(List<FtlVO> files, FtlPath ftlConfig, String inSubPath,Integer inMode) {
        this.files = files;
        this.nowConfig = ftlConfig;
        this.subPath = inSubPath;
        this.mode = inMode;
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

    public Integer getMode() {
        return mode;
    }

}
