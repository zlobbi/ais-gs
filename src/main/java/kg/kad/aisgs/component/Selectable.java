package kg.kad.aisgs.component;

/**
 * created by kadyrbek.mavlyanov@gamil.com
 * 16.08.2021
 */
public interface Selectable {

    String getSelectorId();

    String getSelectorTitle();

    default String getClassName() {
        return "";
    }
}
