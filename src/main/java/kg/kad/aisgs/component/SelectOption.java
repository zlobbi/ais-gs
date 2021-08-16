package kg.kad.aisgs.component;

import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

/**
 * created by kadyrbek.mavlyanov@gamil.com
 * 16.08.2021
 */
@NoArgsConstructor
@AllArgsConstructor
public class SelectOption implements Selectable {

    public String id;
    public String title;

    @Override
    public String getSelectorId() {
        return id;
    }

    @Override
    public String getSelectorTitle() {
        return title;
    }
}