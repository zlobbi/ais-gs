package kg.kad.aisgs.table.core;

/**
 * created by kadyrbek.mavlyanov@gamil.com
 * 14/8/21
 */
public class FilterTemplate {
    private String id;

    private String title;

    public FilterTemplate() {
    }

    public FilterTemplate(String id, String title) {
        this.id = id;
        this.title = title;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }
}