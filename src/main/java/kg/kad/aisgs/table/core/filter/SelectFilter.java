package kg.kad.aisgs.table.core.filter;

import kg.kad.aisgs.table.core.Filter;
import kg.kad.aisgs.util.MessageHelper;

/**
 * created by kadyrbek.mavlyanov@gamil.com
 * 14/8/21
 */
public class SelectFilter implements Filter {

    public static SelectFilter of(String name, String title, String url) {
        return new SelectFilter()
                .setName(name)
                .setTitle(title)
                .setUrl(url);
    }

    private String title;

    private String name;

    private String url;

    @Override
    public String title() {
        return MessageHelper.translate(title);
    }

    @Override
    public String name() {
        return name;
    }

    @Override
    public String node() {
        return "select";
    }

    public String getTitle() {
        return title;
    }

    public SelectFilter setTitle(String title) {
        this.title = title;
        return this;
    }

    public String getName() {
        return name;
    }

    public SelectFilter setName(String name) {
        this.name = name;
        return this;
    }

    public String getUrl() {
        return url;
    }

    public SelectFilter setUrl(String url) {
        this.url = url;
        return this;
    }

    public String url() {
        return getUrl();
    }
}
