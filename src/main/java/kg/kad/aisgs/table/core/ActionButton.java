package kg.kad.aisgs.table.core;

/**
 * created by kadyrbek.mavlyanov@gamil.com
 * 14/8/21
 */
public class ActionButton extends Button {

    private static final long serialVersionUID = 1208692960373202928L;

    public static ActionButton of(ActionButtonType type, String title, String url, boolean dialog) {
        return new ActionButton()
                .setButtonType(type)
                .setTitle(title)
                .setActionUrl(url)
                .setDialog(dialog);
    }

    public static ActionButton of(ActionButtonType type, String title, String url, boolean dialog, String target) {
        return new ActionButton()
                .setButtonType(type)
                .setTitle(title)
                .setActionUrl(url)
                .setDialog(dialog)
                .setTarget(target);
    }

    protected ActionButtonType buttonType = ActionButtonType.function;

    protected String method = "get";

    protected boolean needSelected = true;

    protected boolean dialog = false;

    protected String target = "_self";

    public ActionButton() {
    }

    public boolean isDialog() {
        return dialog;
    }

    public ActionButton setDialog(boolean dialog) {
        this.dialog = dialog;
        return this;
    }

    public boolean isNeedSelected() {
        return needSelected;
    }

    public ActionButton setNeedSelected(boolean needSelected) {
        this.needSelected = needSelected;
        return this;
    }

    public ActionButtonType getButtonType() {
        return buttonType;
    }

    public ActionButton setButtonType(ActionButtonType buttonType) {
        this.buttonType = buttonType;
        return this;
    }

    public String getMethod() {
        return method;
    }

    public ActionButton setMethod(String method) {
        this.method = method;
        return this;
    }

    public String getTarget() {
        return target;
    }

    public ActionButton setTarget(String target) {
        this.target = target;
        return this;
    }

    @Override
    public ActionButton setTitle(String title) {
        super.setTitle(title);
        return this;
    }

    @Override
    public ActionButton setActionUrl(String actionUrl) {
        super.setActionUrl(actionUrl);
        return this;
    }

    @Override
    public String text() {
        return null != icon ?
                String.format(
                        "<i class=\"icon-%s position-left\"></i>%s", icon, getTitle()
                ) :
                getTitle();
    }

    public enum ActionButtonType {
        function, // Ajax
        action; // Direct action

        @Override
        public String toString() {
            return super.toString().toLowerCase();
        }
    }
}
