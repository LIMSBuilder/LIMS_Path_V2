package com.contact.controller.constract;

import com.contact.model.Default;
import com.contact.utils.PropertiesUtlis;
import com.contact.utils.RenderUtils;
import com.jfinal.core.Controller;
import com.jfinal.kit.Prop;
import com.jfinal.kit.PropKit;

import java.util.Hashtable;
import java.util.Map;

/**
 * 预设信息
 */
public class DefaultsController extends Controller {
    public void setDefault() {
        try {
            Boolean result = Default.defaultDao.findFirst("SELECT * FROM `db_default`").setValues(getParaMap());
            renderJson(result ? RenderUtils.CODE_SUCCESS : RenderUtils.CODE_ERROR);
        } catch (Exception e) {
            System.out.println(e);
            renderError(500);
        }
    }

    public void getDefault() {
        renderJson(Default.defaultDao.findFirst("SELECT * FROM `db_default`").getTrusteeInfo());
    }
}
