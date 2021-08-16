package kg.kad.aisgs.resourse.datatable;

import com.fasterxml.jackson.annotation.JsonProperty;

/**
 * created by kadyrbek.mavlyanov@gamil.com
 * 11/8/21
 */
public interface TableRowResource {

    @JsonProperty("DT_RowId")
    String getDT_RowId();

    @JsonProperty("DT_RowClass")
    String getDT_RowClass();

    @JsonProperty("DT_RowData")
    RowData getDT_RowData();
}
