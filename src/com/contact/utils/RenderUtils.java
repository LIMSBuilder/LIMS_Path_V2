package com.contact.utils;

import com.jfinal.kit.JsonKit;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by qulongjun on 2016/10/18.
 */
public class RenderUtils {

    public static final String CODE_SUCCESS = "{\"code\":200}";//成功
    public static final String CODE_REPEAT = "{\"code\":500}";//重复
    public static final String CODE_NOTEMPTY = "{\"code\":501}";//不能为空
    public static final String CODE_ERROR = "{\"code\":502}";//数据库异常

    /**
     * 状态码返回
     *
     * @param code
     * @return
     */
    public static String codeFactory(int code) {
        Map jsonMap = new HashMap();
        jsonMap.put("code", code);
        return JsonKit.toJson(jsonMap);
    }

}
