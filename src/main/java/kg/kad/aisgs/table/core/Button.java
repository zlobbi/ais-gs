package kg.kad.aisgs.table.core;

import kg.kad.aisgs.component.Selectable;
import kg.kad.aisgs.util.MessageHelper;

import java.io.Serializable;

/**
 * created by kadyrbek.mavlyanov@gamil.com
 * 14/8/21
 */
public class Button implements Serializable {

    public static Button of(String title, String actionUrl, String icon) {
        return new Button().setTitle(title).setActionUrl(actionUrl).setIcon(icon);
    }

    protected String title;
    protected String actionUrl;
    protected String icon;
    protected Color color = Color.primary;
    protected String actionTarget = "_self";

    public String text() {
        return null != icon ?
                String.format(
                        "<i class=\"icon-%s position-left\"></i>%s", icon, getTitle()
                ) :
                getTitle();
    }

    public String getTitle() {
        return MessageHelper.translate(title);
    }

    public Button setTitle(String title) {
        this.title = title;
        return this;
    }

    public String getActionUrl() {
        return actionUrl;
    }

    public Button setActionUrl(String actionUrl) {
        this.actionUrl = actionUrl;
        return this;
    }

    public Color getColor() {
        return color;
    }

    public Button setColor(Color color) {
        this.color = color;
        return this;
    }

    public String getIcon() {
        return icon;
    }

    public Button setIcon(String icon) {
        this.icon = icon;
        return this;
    }

    public String getActionTarget() {
        return this.actionTarget;
    }

    public Button setActionTarget(String actionTarget) {
        this.actionTarget = actionTarget;
        return this;
    }

    public enum Color implements Selectable {
        success(0), danger(1), warning(2), primary(3), Default(4), info(5);
        private static final String TRANSLATE_MASK = "button.color.%s";
        private int order;

        Color(int i) {
        }

        public int getOrder() {
            return order;
        }

        public void setOrder(int order) {
            this.order = order;
        }

        @Override
        public String toString() {
            return super.toString().toLowerCase();
        }

        public String getColor() {
            return this.name();
        }

        @Override
        public String getSelectorId() {
            return name();
        }

        @Override
        public String getSelectorTitle() {
            return MessageHelper.translate(
                    String.format(TRANSLATE_MASK, name())
            );
        }
    }
}
