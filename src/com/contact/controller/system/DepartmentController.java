package com.contact.controller.system;

import com.jfinal.core.Controller;
import com.jfinal.kit.JsonKit;

import java.util.*;

/**
 * Created by qulongjun on 2016/10/18.
 */
public class DepartmentController extends Controller {
    public void index() {
        System.out.println("执行到这了");
        Map jsonMap = new HashMap();
        String[] toolbar = {"new", "select_all", "select_toggle", "run", "stop", "delete"};
        jsonMap.put("toolbar", toolbar);
        jsonMap.put("hasSearch", true);
        jsonMap.put("hasSelect", true);
        String[] ths = {"部门编号", "部门名称", "当前状态", "部门人数"};
        jsonMap.put("ths", ths);
        Object[][] datas = {
                {1, "部门1", "<span class=\"label label-warning\">禁用</span>", "20"},
                {2, "部门2", "<span class=\"label label-warning\">禁用</span>", "15"},
                {3, "部门3", "<span class=\"label label-success\">正常</span>", "6"}
        };
        jsonMap.put("datas", datas);
        jsonMap.put("th_opt", true);
        String[] td_opt = {"edit", "run", "stop", "delete"};
        jsonMap.put("td_opt", td_opt);
        Map modal = new HashMap();
        modal.put("name", "张三");
        jsonMap.put("modal", modal);
        jsonMap.put("pageCount",20);
        String value = JsonKit.toJson(jsonMap);
        System.out.println(value);
        renderJson(value);
    }
}
