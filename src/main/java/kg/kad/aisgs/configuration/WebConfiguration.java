package kg.kad.aisgs.configuration;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.CacheControl;
import org.springframework.web.servlet.config.annotation.*;
import org.springframework.web.servlet.i18n.LocaleChangeInterceptor;

import java.util.concurrent.TimeUnit;

/**
 * created by kadyrbek.mavlyanov@gamil.com
 * 14/8/21
 */
@EnableWebMvc
@Configuration
public class WebConfiguration implements WebMvcConfigurer {

    private LocaleChangeInterceptor localeChangeInterceptor;

    @Autowired
    public WebConfiguration(
            LocaleChangeInterceptor localeChangeInterceptor
    ) {
        this.localeChangeInterceptor = localeChangeInterceptor;
    }

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry
                .addResourceHandler("/favicon.ico")
                .addResourceLocations("classpath:/assets/favicon.ico");
        registry
                .addResourceHandler("/robots.txt")
                .addResourceLocations("classpath:/assets/robots.txt");
        registry
                .addResourceHandler("/assets/**")
                .addResourceLocations("classpath:/assets/")
                .setCacheControl(CacheControl.maxAge(24, TimeUnit.HOURS))
                .resourceChain(true);

        registry
                .addResourceHandler("/downloads/**")
                .addResourceLocations("classpath:/downloads/");
        registry
                .addResourceHandler("/webjars/**")
                .addResourceLocations("classpath:/META-INF/resources/webjars/")
                .setCacheControl(CacheControl.maxAge(24, TimeUnit.HOURS))
                .resourceChain(true);

        registry.addResourceHandler("swagger-ui.html")
                .addResourceLocations("classpath:/META-INF/resources/");

    }

    @Override
    public void addCorsMappings(CorsRegistry registry) {
        registry.addMapping("/**")
                .allowedMethods("HEAD", "GET", "PUT", "POST", "DELETE", "PATCH", "OPTIONS");
    }

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(localeChangeInterceptor);
    }
}