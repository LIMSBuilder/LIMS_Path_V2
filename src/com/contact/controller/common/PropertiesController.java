package com.contact.controller.common;

import com.contact.model.Department;
import com.contact.model.Properties;
import com.contact.model.Role;
import com.contact.utils.RenderUtils;
import com.jfinal.core.Controller;
import com.jfinal.kit.Prop;
import com.jfinal.kit.PropKit;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by qulongjun on 2016/11/4.
 */
public class PropertiesController extends Controller {
    /**
     * 获取承接科室信息
     */
    public void getReceiveInfo() {
        Properties properties = Properties.propertiesDao.findById(1);
        int sample_self = properties.get("sample_receive_self");
        int sample_scene = properties.get("sample_receive_scene");
        int sample_self_role = properties.get("sample_receive_self_role");
        int sample_scene_role = properties.get("sample_receive_scene_role");
        Map map = new HashMap();
        if (sample_self != 0) {
            map.put("sample_self", Department.departmentDao.findFirst("SELECT * FROM `db_department` WHERE state=0 AND id=" + sample_self));
        }
        if (sample_scene != 0) {
            map.put("sample_scene", Department.departmentDao.findFirst("SELECT * FROM `db_department` WHERE state=0 AND id=" + sample_scene));
        }
        if (sample_self_role != 0) {
            map.put("sample_self_role", Role.roleDao.findFirst("SELECT * FROM `db_role` WHERE state=0 AND id=" + sample_self_role));
        }
        if (sample_scene_role != 0) {
            map.put("sample_scene_role", Role.roleDao.findFirst("SELECT * FROM `db_role` WHERE state=0 AND id=" + sample_scene_role));
        }
        renderJson(map);
    }

    /**
     * 设置承接科室信息
     */
    public void setReceiveInfo() {
        try {
            Properties properties = Properties.propertiesDao.findById(1);
            if (properties != null) {
                Map params = getParaMap();
                for (Object key : params.keySet()) {
                    String value = ((String[]) params.get(key))[0];
                    properties.set(key.toString(), value);
                }
            }
            Boolean result = properties.update();
            renderJson(result ? RenderUtils.CODE_SUCCESS : RenderUtils.CODE_ERROR);
        } catch (Exception e) {
            renderError(500);
        }
    }
}
