package kg.kad.aisgs.util;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;

/**
 * created by kadyrbek.mavlyanov@gamil.com
 * 14/8/21
 */
@Component
public class MessageHelper {

    @Autowired
    private MessageSource ms;

    private static MessageSource messageSource;

    @PostConstruct
    private void initStaticDao() {
        messageSource = this.ms;
    }

    public static String translate(String name) {
        return messageSource.getMessage(name, null, LocaleContextHolder.getLocale());
    }

    public String get(String key) {
        return messageSource.getMessage(key, null, LocaleContextHolder.getLocale());
    }

}