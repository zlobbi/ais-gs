package kg.kad.aisgs.table.core;

import java.util.List;

/**
 * created by kadyrbek.mavlyanov@gamil.com
 * 14/8/21
 */
public class DropDownButton extends Button {

    private static final long serialVersionUID = -1761043802693728529L;

    public static DropDownButton of(List<ActionButton> buttons) {
        return new DropDownButton()
                .setButtons(buttons);
    }

    public static DropDownButton of(String title, Color color, String icon, List<ActionButton> buttons) {
        return new DropDownButton()
                .setTitle(title)
                .setIcon(icon)
                .setColor(color)
                .setButtons(buttons);
    }

    private List<ActionButton> buttons;

    public DropDownButton() {
        this.setTitle("table.action-with-selected");
        this.setIcon("database-edit2");
        this.setColor(Color.Default);
    }

    @Override
    public DropDownButton setTitle(String title) {
        super.setTitle(title);
        return this;
    }

    @Override
    public DropDownButton setColor(Color color) {
        super.setColor(color);
        return this;
    }

    @Override
    public DropDownButton setIcon(String icon) {
        super.setIcon(icon);
        return this;
    }

    public DropDownButton setButtons(List<ActionButton> buttons) {
        this.buttons = buttons;
        return this;
    }

    public List<ActionButton> getButtons() {
        return buttons;
    }

    @Override
    public String text() {
        return null != icon ?
                String.format(
                        "<i class=\"icon-%s position-left\"></i>%s <span class=\"caret\"></span>", icon, getTitle()
                ) :
                getTitle();
    }
}
