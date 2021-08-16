package kg.kad.aisgs.table.core.filter;

import kg.kad.aisgs.table.core.Filter;
import kg.kad.aisgs.util.MessageHelper;

/**
 * created by kadyrbek.mavlyanov@gamil.com
 * 14/8/21
 */
public class CheckboxFilter implements Filter {

    private static final long serialVersionUID = 5153831182405569148L;

    private String title;

    private String name;

    public static CheckboxFilter of(String name, String title) {
        return new CheckboxFilter()
                .setName(name)
                .setTitle(title);
    }

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
        return "checkbox";
    }

    public String getTitle() {
        return title;
    }

    public CheckboxFilter setTitle(String title) {
        this.title = title;
        return this;
    }

    public String getName() {
        return name;
    }

    public CheckboxFilter setName(String name) {
        this.name = name;
        return this;
    }
}
