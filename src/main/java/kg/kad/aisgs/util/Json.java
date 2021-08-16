package kg.kad.aisgs.util;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.lang.reflect.Constructor;
import java.lang.reflect.Field;
import java.util.List;

/**
 * created by kadyrbek.mavlyanov@gamil.com
 * 14/8/21
 */
public class Json {

    private final static Logger LOG = LoggerFactory.getLogger(Json.class);

    public Json() {
    }

    public static JsonNode toJson(Boolean value) {
        ObjectMapper mapper = new ObjectMapper();
        return (JsonNode) mapper.convertValue(value, JsonNode.class);
    }

    public static <T> JsonNode toJson(List<T> models) {
        ObjectMapper mapper = new ObjectMapper();
        return (JsonNode) mapper.convertValue(models, JsonNode.class);
    }

    public static JsonNode toJson(Object obj) {
        ObjectMapper mapper = new ObjectMapper();
        return (JsonNode) mapper.convertValue(obj, JsonNode.class);
    }

    public static JsonNode toJson(String str) {
        return (JsonNode) (new ObjectMapper()).convertValue(str, JsonNode.class);
    }

    public static <T> String toJsonString(List<T> models) {
        ObjectMapper mapper = new ObjectMapper();
        JsonNode jsonNode = (JsonNode) mapper.convertValue(models, JsonNode.class);
        return jsonNode.toString();
    }

    public static JsonNode fromJsonString(String str) {
        try {
            return (new ObjectMapper()).readTree(str);
        } catch (Exception var2) {
            LOG.info(var2.getMessage(), var2);
            return null;
        }
    }

    public static <T> T fromJson(String str, Class<T> clazz) {
        try {
            JsonNode e = fromJsonString(str);
            return (new ObjectMapper()).treeToValue(e, clazz);
        } catch (Exception var3) {
            LOG.info(var3.getMessage(), var3);
            return null;
        }
    }

    public static <T> T fromJson(JsonNode json, Class<T> clazz) {
        try {
            return (new ObjectMapper()).treeToValue(json, clazz);
        } catch (Exception var3) {
            LOG.info(var3.getMessage(), var3);
            return null;
        }
    }

    public static <T> T objectFromJson(String str, Class<T> mainClass) {
        JsonNode jsonNode = fromJsonString(str.trim().substring(1, str.length() - 1));
        return getSimplifiedObject(jsonNode, mainClass);
    }

    private static <T> T getSimplifiedObject(JsonNode jsonNode, Class<T> clazz) {
        try {
            Constructor<T> constructor = clazz.getConstructor();
            T instance = constructor.newInstance();
            ObjectMapper objectMapper = new ObjectMapper();

            for (Field field : clazz.getDeclaredFields()) {
                if (!jsonNode.path(field.getName()).isMissingNode()) {
                    field.setAccessible(true);
                    if (field.getType().getName().contains(Constants.PROJECT_PACKAGE)) {
                        field.set(instance, getSimplifiedObject(jsonNode.path(field.getName()), field.getType()));
                    } else {
                        field.set(instance, objectMapper.convertValue(jsonNode.path(field.getName()), field.getType()));
                    }
                }
            }
            return instance;
        } catch (Exception e) {
            throw new RuntimeException(e.getMessage());
        }
    }

}
