package kg.kad.aisgs.table.core;


import kg.kad.aisgs.util.MessageHelper;

import java.io.Serializable;

/**
 * created by kadyrbek.mavlyanov@gamil.com
 * 14/8/21
 */
public class Column implements Serializable {

    private static final long serialVersionUID = 5122129687573921858L;

    public static Column of(String name) {
        return new Column().setName(name).setData(name).setTitle(name).setOrderable(true);
    }

    public static Column of(String name, boolean order) {
        return new Column().setName(name).setData(name).setTitle(name).setOrderable(order);
    }

    private String width;

    private String name;

    private String title;

    private String data;

    private String dataSrc;

    private String className;

    private String defaultContent;

    private boolean visible = true;

    private boolean orderable = true;

    public String getWidth() {
        return width;
    }

    public Column setWidth(String width) {
        this.width = width;
        return this;
    }

    public Column() {
    }

    public String getName() {
        return name;
    }

    public Column setName(String name) {
        this.name = name;
        return this;
    }

    public String getTitle() {
        return MessageHelper.translate(title);
    }

    public Column setTitle(String title) {
        this.title = title;
        return this;
    }

    public String getData() {
        return data;
    }

    public Column setData(String data) {
        this.data = data;
        return this;
    }

    public String getDataSrc() {
        return dataSrc;
    }

    public Column setDataSrc(String dataSrc) {
        this.dataSrc = dataSrc;
        return this;
    }

    public String getClassName() {
        return className;
    }

    public Column setClassName(String className) {
        this.className = className;
        return this;
    }

    public boolean isVisible() {
        return visible;
    }

    public Column setVisible(boolean visible) {
        this.visible = visible;
        return this;
    }

    public boolean isOrderable() {
        return orderable;
    }

    public Column setOrderable(boolean orderable) {
        this.orderable = orderable;
        return this;
    }

    public String getDefaultContent() {
        return defaultContent;
    }

    public Column setDefaultContent(String defaultContent) {
        this.defaultContent = defaultContent;
        return this;
    }
}
