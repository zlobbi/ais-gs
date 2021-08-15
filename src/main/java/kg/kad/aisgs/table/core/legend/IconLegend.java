package kg.kad.aisgs.table.core.legend;

/**
 * Created by abdysamat on 8/17/17.
 * n.u.abdysamat@gmail.com
 */
public class IconLegend extends BaseLegend {
    private String icon;

    public IconLegend(String title, String icon) {
        super(title);
        this.icon = icon;
    }

    public String getIcon() {
        return icon;
    }

    public void setIcon(String icon) {
        this.icon = icon;
    }
}