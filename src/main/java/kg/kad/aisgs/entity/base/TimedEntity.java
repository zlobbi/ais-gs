package kg.kad.aisgs.entity.base;

import kg.kad.aisgs.util.TimeHelper;
import lombok.Getter;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import javax.persistence.EntityListeners;
import javax.persistence.MappedSuperclass;
import java.time.LocalDateTime;
import java.util.Objects;

/**
 * created by kadyrbek.mavlyanov@gamil.com
 * 12/8/21
 */
@Getter
@MappedSuperclass
@EntityListeners(AuditingEntityListener.class)
public abstract class TimedEntity extends BaseEntity {

    private static final long serialVersionUID = -850788074338551061L;

    @CreatedDate
    private LocalDateTime createdAt;

    @LastModifiedDate
    private LocalDateTime updatedAt;

    public String getCreatedAtFormatted() {
        return createdAt.format(TimeHelper.DATE_TIME_FORMATTER);
    }

    public String getUpdatedAtFormatted() {
        return Objects.nonNull(updatedAt) ? updatedAt.format(TimeHelper.DATE_TIME_FORMATTER) : "";
    }
}
