package com.xy.system.codebuilder.ftl;

public class FtlVO {
    private String prePath;
    private boolean shortPath;
    private boolean shortName;
    private String afterPath;
    private String ftlName;
    private String preName;
    private String afterName;

    public FtlVO(String ftlName, String prePath, String afterPath, String preName, String afterName) {
        this.ftlName = ftlName;
        this.shortPath = false;
        this.prePath = prePath;
        this.afterPath = afterPath;
        this.shortName = false;
        this.preName = preName;
        this.afterName = afterName;
    }

    public FtlVO(String ftlName, boolean shortPath, String prePath, String afterPath, boolean shortName, String preName, String afterName) {
        this.ftlName = ftlName;
        this.shortPath = shortPath;
        this.prePath = prePath;
        this.afterPath = afterPath;
        this.shortName = shortName;
        this.preName = preName;
        this.afterName = afterName;
    }

    public String getPrePath() {
        return prePath;
    }

    public void setPrePath(String prePath) {
        this.prePath = prePath;
    }

    public boolean isShortPath() {
        return shortPath;
    }

    public void setShortPath(boolean shortPath) {
        this.shortPath = shortPath;
    }

    public boolean isShortName() {
        return shortName;
    }

    public void setShortName(boolean shortName) {
        this.shortName = shortName;
    }

    public String getAfterPath() {
        return afterPath;
    }

    public void setAfterPath(String afterPath) {
        this.afterPath = afterPath;
    }

    public String getFtlName() {
        return ftlName;
    }

    public void setFtlName(String ftlName) {
        this.ftlName = ftlName;
    }

    public String getPreName() {
        return preName;
    }

    public void setPreName(String preName) {
        this.preName = preName;
    }

    public String getAfterName() {
        return afterName;
    }

    public void setAfterName(String afterName) {
        this.afterName = afterName;
    }
}

