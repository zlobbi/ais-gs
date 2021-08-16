package kg.kad.aisgs.table.core;

import com.google.common.base.CaseFormat;
import kg.kad.aisgs.component.Selectable;
import kg.kad.aisgs.table.core.filter.*;
import kg.kad.aisgs.util.Json;
import kg.kad.aisgs.util.MessageHelper;
import org.springframework.util.StringUtils;

import javax.annotation.PostConstruct;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

/**
 * created by kadyrbek.mavlyanov@gamil.com
 * 14/8/21
 */
public abstract class AbstractTable implements Serializable {

    private static final long serialVersionUID = -4769600351747929221L;

    public static final String ORDER_DESC = "desc";
    public static final String ORDER_ASC = "asc";

    private Boolean autoWidth = false;

    protected List<Column> columns = new ArrayList<>();

    protected List<Button> buttons = new ArrayList<>();

    protected List<DropDownButton> dropDownButtons = new ArrayList<>();

    protected List<Filter> filters = new ArrayList<>();

    private List<Object> orders = new ArrayList<>();

    private int rowsPerPage = 10;

    private String thirdIndex = "table";

    abstract protected Class<?> getBaseClass();

    abstract protected String getUrl();

    abstract protected String getTitle();

    protected void initButtons() {
    }

    protected void initColumns() {
    }

    protected void initFilters() {
    }

    protected void initDropDownButtons() {
    }

    protected void initLegend() {
    }

    protected void initRowsPerPage() {
    }

    protected void initPreferenceList() {
    }

    protected void initOrders() {
        addOrder(0, ORDER_ASC);
    }

    protected void addOrder(int index, String direction) {
        List<Object> deflt = new ArrayList<>();
        deflt.add(index);
        deflt.add(direction);
        orders.add(deflt);
    }

    public String title() {
        return MessageHelper.translate(getTitle());
    }

    public String url() {
        return getUrl();
    }

    protected void addColumn(String name) {
        addColumn(name, false);
    }

    public String tableId() {
        return String.format(
                "%s_%s_%s",
                getBaseClass().getSimpleName().toLowerCase(),
                getClass().getSimpleName().toLowerCase(),
                thirdIndex
        );
    }

    public String tableCamelCaseId() {
        return CaseFormat.UPPER_UNDERSCORE.to(CaseFormat.UPPER_CAMEL, tableId());
    }

    private String getClassName() {
        return StringUtils.uncapitalize(getBaseClass().getSimpleName());
    }

    protected void addFilterDateRange(String name) {
        String title = String.format("%s.%s", getClassName(), name);

        DateRangeFilter filter = new DateRangeFilter();
        filter.setName(name)
                .setTitle(title);

        addFilter(filter);
    }

    protected void addFilterText(String name) {
        String title = String.format("%s.%s", getClassName(), name);

        TextFilter filter = new TextFilter();
        filter.setName(name)
                .setTitle(title);

        addFilter(filter);
    }

    protected void addFilterSelect(String name, String url) {
        String title = String.format("%s.%s", getClassName(), name);

        SelectFilter filter = new SelectFilter();
        filter.setName(name)
                .setTitle(title)
                .setUrl(url);

        addFilter(filter);
    }

    protected void addFilterSelectStatic(String name, List<Selectable> options) {
        String title = String.format("%s.%s", getClassName(), name);

        SelectStaticFilter filter = new SelectStaticFilter();
        filter.setName(name)
                .setTitle(title)
                .setOptions(options);

        addFilter(filter);
    }

    protected void addFilterSelectStaticMultiple(String name, List<Selectable> options) {
        String title = String.format("%s.%s", getClassName(), name);

        SelectStaticMultipleFilter filter = new SelectStaticMultipleFilter();
        filter.setName(name)
                .setTitle(title)
                .setOptions(options);

        addFilter(filter);
    }

    protected void addFilterCheckbox(String name) {
        String title = String.format("%s.%s", getClassName(), name);

        CheckboxFilter filter = new CheckboxFilter();
        filter.setName(name)
                .setTitle(title);

        addFilter(filter);
    }

    protected void addFilterMonth(String name) {
        String title = String.format("%s.%s", getClassName(), name);

        MonthFilter filter = new MonthFilter();
        filter.setName(name)
                .setTitle(title);

        addFilter(filter);
    }

    protected void addFilter(Filter filter) {
        this.filters.add(filter);
    }

    protected void addColumn(String name, boolean orderable) {
        String title = String.format("%s.%s", getClassName(), name);

        Column column = new Column()
                .setName(name)
                .setData(name)
                .setTitle(title)
                .setOrderable(orderable);

        this.columns.add(column);
    }

    protected void addInvisibleColumn(String name) {
        String title = String.format("%s.%s", getClassName(), name);

        Column column = new Column()
                .setName(name)
                .setData(name)
                .setTitle(title)
                .setVisible(false)
                .setOrderable(false);

        this.columns.add(column);
    }

    protected void addColumn(String name, boolean orderable, String width) {
        String title = String.format("%s.%s", getClassName(), name);

        Column column = new Column()
                .setWidth(width)
                .setName(name)
                .setData(name)
                .setTitle(title)
                .setOrderable(orderable);

        this.columns.add(column);
    }

    protected void addColumn(String name, String className, boolean orderable) {
        String title = String.format("%s.%s", getClassName(), name);

        Column column = new Column()
                .setName(name)
                .setClassName(className)
                .setData(name)
                .setTitle(title)
                .setOrderable(orderable);

        this.columns.add(column);
    }

    protected void addButton(String title, String url, String icon, String actionTarget) {
        addButton(title, url, Button.Color.Default, icon, actionTarget);
    }

    protected void addButton(String title, String url, String icon) {
        addButton(title, url, Button.Color.Default, icon);
    }

    protected void addButton(String title, String url) {
        addButton(title, url, Button.Color.Default, null);
    }

    public void addDropDownButton(String title, String icon, Button.Color color, List<ActionButton> list) {
        this.dropDownButtons.add(DropDownButton.of(title, color, icon, list));
    }

    protected void addButton(String title, String url, Button.Color color, String icon) {
        Button button = new Button()
                .setTitle(title)
                .setActionUrl(url)
                .setColor(color)
                .setIcon(icon)
                .setActionTarget("_blank");
        this.buttons.add(button);
    }

    protected void addButton(String title, String url, Button.Color color, String icon, String actionTarget) {
        Button button = new Button()
                .setTitle(title)
                .setActionUrl(url)
                .setColor(color)
                .setIcon(icon)
                .setActionTarget(actionTarget);
        this.buttons.add(button);
    }

    public Boolean getAutoWidth() {
        return autoWidth;
    }

    public AbstractTable setAutoWidth(Boolean autoWidth) {
        this.autoWidth = autoWidth;
        return this;
    }

    public List<Filter> getFilters() {
        return filters;
    }

    public AbstractTable setFilters(List<Filter> filters) {
        this.filters = filters;
        return this;
    }

    public List<Column> getColumns() {
        return columns;
    }

    public AbstractTable setColumns(List<Column> columns) {
        this.columns = columns;
        return this;
    }

    public List<Button> getButtons() {
        return buttons;
    }

    public AbstractTable setButtons(List<Button> buttons) {
        this.buttons = buttons;
        return this;
    }

    public String getJsonColumn() {
        return Json.toJson(columns).toString();
    }

    public String getJson() {
        return Json.toJson(this).toString();
    }

    public boolean hasFilters() {
        return null != filters && !filters.isEmpty();
    }

    public boolean hasDropDownButtons() {
        return null != dropDownButtons && !dropDownButtons.isEmpty();
    }

    @PostConstruct
    protected void init() {
        this.columns = new ArrayList<>();
        this.buttons = new ArrayList<>();
        this.filters = new ArrayList<>();
        this.orders = new ArrayList<>();
        this.dropDownButtons = new ArrayList<>();

        initButtons();
        initDropDownButtons();
        initColumns();
        initFilters();
        initOrders();
        initLegend();
        initPreferenceList();
        initRowsPerPage();
    }

    public String order() {
        return Json.toJson(orders).toString();
    }

    public List<DropDownButton> getDropDownButtons() {
        return dropDownButtons;
    }

    public AbstractTable setDropDownButtons(List<DropDownButton> dropDownButtons) {
        this.dropDownButtons = dropDownButtons;
        return this;
    }

    public int getRowsPerPage() {
        return rowsPerPage;
    }

    public void setRowsPerPage(int rowsPerPage) {
        this.rowsPerPage = rowsPerPage;
    }

    public String getThirdIndex() {
        return thirdIndex;
    }

    public AbstractTable setThirdIndex(String thirdIndex) {
        this.thirdIndex = thirdIndex;
        return this;
    }
}