package kg.kad.aisgs.component;

public interface Selectable {
    String getSelectorId();

    String getSelectorTitle();

    default public String getClassName() {
        return "";
    }
}
