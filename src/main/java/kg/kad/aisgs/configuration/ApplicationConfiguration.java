package kg.kad.aisgs.configuration;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.view.freemarker.FreeMarkerConfigurer;

import javax.annotation.PostConstruct;
import java.util.Collections;
import java.util.Objects;

/**
 * created by kadyrbek.mavlyanov@gamil.com
 * 14/8/21
 */
@Configuration
public class ApplicationConfiguration {

    private final FreeMarkerConfigurer freeMarkerConfigurer;

    public ApplicationConfiguration(
            FreeMarkerConfigurer freeMarkerConfigurer
    ) {
        this.freeMarkerConfigurer = freeMarkerConfigurer;
    }

    @PostConstruct
    public void loadClassPathTlds() {
        if (Objects.isNull(freeMarkerConfigurer.getTaglibFactory().getObjectWrapper()))
            freeMarkerConfigurer.getTaglibFactory().setObjectWrapper(freeMarkerConfigurer.getConfiguration().getObjectWrapper());
        freeMarkerConfigurer
                .getTaglibFactory()
                .setClasspathTlds(Collections.singletonList("/META-INF/security.tld"));
    }
}