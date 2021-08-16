package kg.kad.aisgs.controller.web.crud;

import org.jetbrains.annotations.NotNull;

/**
 * created by kadyrbek.mavlyanov@gamil.com
 * 14/8/21
 */
public interface CrudController {

    @NotNull
    String templates();

    @NotNull
    String url();
}
