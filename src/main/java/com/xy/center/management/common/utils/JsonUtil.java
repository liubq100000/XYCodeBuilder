package com.xy.center.management.common.utils;

import com.fasterxml.jackson.core.JsonGenerator.Feature;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.JavaType;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ArrayNode;
import com.fasterxml.jackson.databind.node.ObjectNode;

import java.io.IOException;
import java.io.InputStream;
import java.io.StringWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;

public class JsonUtil {

    public JsonUtil() {
    }

    public static String java2Json(Object object) {
        StringWriter var1 = new StringWriter();
        ObjectMapper var2 = new ObjectMapper();
        var2.getFactory().configure(Feature.ESCAPE_NON_ASCII, true);

        try {
            var2.writeValue(var1, object);
        } catch (Exception e) {
            e.printStackTrace();
        }

        if (var1 != null) {
            try {
                var1.flush();
                var1.close();
            } catch (IOException ex) {
                ex.printStackTrace();
            }
        }

        return var1.toString();
    }

    public static <T> Object json2Java(String json, Class<T> type) {
        ObjectMapper var2 = new ObjectMapper();
        var2.disable(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES);
        var2.configure(com.fasterxml.jackson.core.JsonParser.Feature.ALLOW_SINGLE_QUOTES, true);
        Object var3 = null;
        if (json != null && !"".equals(json)) {
            try {
                var3 = var2.readValue(json, type);
            } catch (Exception var5) {
                var5.printStackTrace();
            }
        }

        return var3;
    }

    public static <T> Object jsonNode2Java(JsonNode jsonNode, Class<T> type) {
        ObjectMapper var2 = new ObjectMapper();
        Object var4 = null;

        try {
            String var3 = var2.writeValueAsString((ObjectNode) jsonNode);
            var4 = json2Java(var3, type);
        } catch (JsonProcessingException var6) {
            java.util.logging.Logger.getLogger(JsonUtil.class.getName()).log(Level.SEVERE, (String) null, var6);
        }

        return var4;
    }

    public static <T> List<T> json2Array(String json, Class<T> type) {
        ObjectMapper var2 = new ObjectMapper();
        var2.disable(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES);
        var2.configure(com.fasterxml.jackson.core.JsonParser.Feature.ALLOW_SINGLE_QUOTES, true);
        JavaType var3 = var2.getTypeFactory().constructParametricType(List.class, new Class[]{type});
        Object var4 = new ArrayList();

        try {
            var4 = (List) var2.readValue(json, var3);
        } catch (Exception var6) {
            var6.printStackTrace();
        }

        return (List) var4;
    }

    public static JsonNode createNode() {
        ObjectMapper var0 = new ObjectMapper();
        ObjectNode var1 = var0.createObjectNode();
        return var1;
    }

    public static JsonNode createNode(String json) {
        ObjectMapper var1 = new ObjectMapper();
        var1.configure(com.fasterxml.jackson.core.JsonParser.Feature.ALLOW_SINGLE_QUOTES, true);
        JsonNode var2 = null;

        try {
            var2 = var1.readTree(json);
        } catch (Exception var4) {
            var4.printStackTrace();
        }

        return var2;
    }

    public static JsonNode createNode(InputStream json) {
        ObjectMapper var1 = new ObjectMapper();
        var1.disable(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES);
        var1.configure(com.fasterxml.jackson.core.JsonParser.Feature.ALLOW_SINGLE_QUOTES, true);
        JsonNode var2 = null;

        try {
            var2 = var1.readTree(json);
        } catch (Exception var4) {
            var4.printStackTrace();
        }

        return var2;
    }

    public static ArrayNode createArrayNode() {
        ObjectMapper var0 = new ObjectMapper();
        ArrayNode var1 = var0.createArrayNode();
        return var1;
    }
}

