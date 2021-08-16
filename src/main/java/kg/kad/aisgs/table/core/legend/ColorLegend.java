package kg.kad.aisgs.table.core.legend;

import lombok.Getter;
import lombok.Setter;

/**
 * created by kadyrbek.mavlyanov@gamil.com
 * 14/8/21
 */
@Getter
@Setter
public class ColorLegend extends BaseLegend {
    private String color;

    public ColorLegend(String title, String color) {
        super(title);
        this.color = color;
    }
}