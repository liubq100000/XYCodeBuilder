package com.xy.system.codebuilder.ftl;

import java.util.ArrayList;
import java.util.List;

public class Attribute {
    private String camelName;
    private String pascalName;
    private String columnName;
    private String remarks;
    private String typeName;
    private int queryByLike = 0;
    private int size;
    private List<String> extAttList = new ArrayList<>();

    public Attribute(String columnName,String typeName, String remarks,int size) {
        this.columnName = columnName;
        this.camelName = JavaNameUtil.toCamel(columnName);
        this.pascalName = JavaNameUtil.toPascal(columnName);
        this.remarks = remarks;
        this.typeName = typeName;
        this.size = size;

    }

    public int getBusiItemType() {
        if(JavaNameUtil.isExt(columnName)){
            return 0;
        }
        return 1;
    }

    public String getColumnName() {
        return columnName;
    }

    public void setColumnName(String columnName) {
        this.columnName = columnName;
    }
    public String getLabel() {
        if(remarks == null||remarks.trim().length() == 0){
            return camelName;
        }
        return remarks;
    }

    public int getQueryByLike() {
        return queryByLike;
    }

    public void setQueryByLike(int queryByLike) {
        this.queryByLike = queryByLike;
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }
    public String getType() {
        return typeName;
    }
    public String getTypeName() {
        return typeName;
    }

    public void setTypeName(String typeName) {
        this.typeName = typeName;
    }

    public String getCamelName() {
        return camelName;
    }

    public void setCamelName(String camelName) {
        this.camelName = camelName;
    }

    public String getPascalName() {
        return pascalName;
    }

    public void setPascalName(String pascalName) {
        this.pascalName = pascalName;
    }

    public int getSize() {
        return size;
    }

    public void setSize(int size) {
        this.size = size;
    }
}
