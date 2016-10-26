package com.contact.utils;

import com.jfinal.kit.Prop;
import com.jfinal.kit.PropKit;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by qulongjun on 2016/10/26.
 */
public class ParaUtils {
    /**
     * 获取系统配置的rowCount信息
     *
     * @return
     */
    public static int getRowCount() {
        Prop setting = PropKit.use("setting.properties");
        int rowCount = setting.getInt("rowCount");
        return rowCount;
    }

    /**
     * 拆分请求中的搜索条件
     *
     * @param condition
     * @return
     */
    public static Map getSplitCondition(String condition) {
        String[] conditionArr = condition.split("&&");
        Map paraMap = new HashMap<>();
        for (int i = 0; i < conditionArr.length; i++) {
            String temp = conditionArr[i];
            String[] kv = temp.split("=");
            if (kv.length == 2) paraMap.put(kv[0], convertRequestParam(kv[1]));
        }
        return paraMap;
    }

    /**
     * 过滤中文字符,防止乱码
     *
     * @param param
     * @return
     */
    public static String convertRequestParam(String param) {
        if (param != null) {
            try {
                return URLDecoder.decode(param, "UTF-8");
            } catch (UnsupportedEncodingException e) {
                System.out.println("request convert to UTF-8 error ");
            }
        }
        return "";
    }

}
