package com.xy.system.codebuilder.ftl;

public class PageAttribute {

    public static final int FORM_WIDTH_SIZE = 2;

    private String name = "";
    private String type = "";
    private String label = "";
    private String display = "";
    private String width = "";
    private String height = "";
    private String sort = "";
    private String query = "";

    public int getFlag() {
        if (name != null && name.trim().length() > 0) {
            return 1;
        }
        return 0;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getLabel() {
        return label;
    }

    public void setLabel(String label) {
        this.label = label;
    }

    public String getDisplay() {
        return display;
    }

    public void setDisplay(String display) {
        this.display = display;
    }

    public int getWidthNum() {
        int widthNum = 1;
        try {
            widthNum = Integer.valueOf(width);
        } catch (Exception ex) {

        }
        return widthNum;
    }

    public int getColspanSize() {
        return getWidthNum() * FORM_WIDTH_SIZE - 1;
    }

    public String getWidth() {
        return width;
    }

    public void setWidth(String width) {
        this.width = width;
    }

    public String getHeight() {
        return height;
    }

    public void setHeight(String height) {
        this.height = height;
    }

    public String getSort() {
        return sort;
    }

    public Long getSortNum() {
        Long sort1 = 10000L;
        try {
            sort1 = Long.valueOf(sort);
        } catch (Exception ex) {

        }
        return sort1;
    }


    public void setSort(String sort) {
        this.sort = sort;
    }

    public String getQuery() {
        return query;
    }

    public void setQuery(String query) {
        this.query = query;
    }
}
