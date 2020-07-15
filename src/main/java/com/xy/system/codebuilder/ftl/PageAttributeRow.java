package com.xy.system.codebuilder.ftl;

import java.util.ArrayList;
import java.util.List;

public class PageAttributeRow {
    private List<PageAttribute> rowList = new ArrayList<>();

    public List<PageAttribute> getRowList() {
        return rowList;
    }

    public void setRowList(List<PageAttribute> rowList) {
        this.rowList = rowList;
    }
}
