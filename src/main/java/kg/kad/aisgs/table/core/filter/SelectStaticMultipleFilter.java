package kg.kad.aisgs.table.core.filter;

import kg.kad.aisgs.component.SelectOption;
import kg.kad.aisgs.component.Selectable;
import kg.kad.aisgs.table.core.Filter;
import kg.kad.aisgs.util.MessageHelper;

import java.util.ArrayList;
import java.util.List;

/**
 * created by kadyrbek.mavlyanov@gamil.com
 * 14/8/21
 */
public class SelectStaticMultipleFilter implements Filter {

    private String title;

    private String name;

    private List<Selectable> options;

    public SelectStaticMultipleFilter() {
        this.options = new ArrayList<>();
    }

    public SelectStaticMultipleFilter addOption(SelectOption option) {
        options.add(option);
        return this;
    }

    public String getTitle() {
        return MessageHelper.translate(title);
    }

    public SelectStaticMultipleFilter setTitle(String title) {
        this.title = title;
        return this;
    }

    public String getName() {
        return name;
    }

    public SelectStaticMultipleFilter setName(String name) {
        this.name = name;
        return this;
    }

    public List<Selectable> getOptions() {
        return options;
    }

    public SelectStaticMultipleFilter setOptions(List<Selectable> options) {
        this.options = options;
        return this;
    }

    @Override
    public String title() {
        return getTitle();
    }

    @Override
    public String name() {
        return getName();
    }

    @Override
    public String node() {
        return "selectStaticMultiple";
    }
}
