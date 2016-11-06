package com.contact.utils;

import com.contact.model.User;
import com.jfinal.kit.Prop;
import com.jfinal.kit.PropKit;
import sun.misc.BASE64Encoder;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by qulongjun on 2016/10/26.
 */
public class ParaUtils {
    public final static Map flows = new HashMap() {{
        put("create_task", 0);//任务创建成功,进入样品登记环节
        put("create_sample", 1);//样品登记成功,进入交接联单环节
        put("connect_sample", 2);//交接联单生成完成,进入送检单环节
    }};


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

    /**
     * 利用MD5进行加密
     *
     * @param str 待加密的字符串
     * @return 加密后的字符串
     * @throws NoSuchAlgorithmException     没有这种产生消息摘要的算法
     * @throws UnsupportedEncodingException
     */
    public static String EncoderByMd5(String str) throws NoSuchAlgorithmException, UnsupportedEncodingException {
        //确定计算方法
        MessageDigest md5 = MessageDigest.getInstance("MD5");
        BASE64Encoder base64en = new BASE64Encoder();
        //加密后的字符串
        String newstr = base64en.encode(md5.digest(str.getBytes("utf-8")));
        return newstr;
    }


    /**
     * 判断用户密码是否正确
     *
     * @param newpasswd 用户输入的密码
     * @param oldpasswd 数据库中存储的密码－－用户密码的摘要
     * @return
     * @throws NoSuchAlgorithmException
     * @throws UnsupportedEncodingException
     */
    public static boolean checkpassword(String newpasswd, String oldpasswd) throws NoSuchAlgorithmException, UnsupportedEncodingException {
        if (EncoderByMd5(newpasswd).equals(oldpasswd))
            return true;
        else
            return false;
    }

    /**
     * 获取当前登录用户
     *
     * @return
     */
    public static User getCurrentUser() {
        User user = User.userDao.findById(1);
        return user;
    }

}
