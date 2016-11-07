package com.contact.controller.template;

import com.contact.model.InspectionTemplate;
import com.contact.model.Monitor_Category;
import com.contact.utils.RenderUtils;
import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.IAtom;

import java.sql.SQLException;

/**
 * Created by qulongjun on 2016/11/7.
 */
public class TemplateController extends Controller {
    public void inspection() {
        try {
            Boolean result = Db.tx(new IAtom() {
                @Override
                public boolean run() throws SQLException {
                    String name = getPara("name");
                    int id = getParaToInt("category_id");
                    String path = getPara("path");
                    InspectionTemplate inspectionTemplate = new InspectionTemplate();
                    Boolean result = inspectionTemplate.set("name", name).set("path", path).save();
                    Boolean result_category = false;
                    if (result) {
                        result_category = Monitor_Category.monitorCategoryDao.findById(id).set("inspection_template", inspectionTemplate.get("id")).update();
                    }
                    return result && result_category;
                }
            });
            renderJson(result ? RenderUtils.CODE_SUCCESS : RenderUtils.CODE_ERROR);
        } catch (Exception e) {
            renderError(500);
        }
    }
}
