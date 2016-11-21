package com.contact.controller.template;

import com.contact.model.InspectionTemplate;
import com.contact.model.Monitor_Category;
import com.contact.model.OriginRecordTemplate;
import com.contact.utils.ParaUtils;
import com.contact.utils.RenderUtils;
import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.IAtom;
import com.jfinal.plugin.activerecord.Page;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by qulongjun on 2016/11/7.
 */
public class TemplateController extends Controller {

    public void inspectionList() {
        int rowCount = getParaToInt("rowCount");
        int currentPage = getParaToInt("currentPage");
        String condition_temp = getPara("condition");
        Map condition = ParaUtils.getSplitCondition(condition_temp);
        if (rowCount == 0) {
            rowCount = ParaUtils.getRowCount();
        }
        String paras = "";
        Object[] keys = condition.keySet().toArray();
        for (int i = 0; i < keys.length; i++) {
            if (i == 0) {
                paras += " WHERE ";
            }
            String key = (String) keys[i];
            Object value = condition.get(key);
            paras += ("AND " + key + " like \"%" + value + "%\"");
        }
        Page<InspectionTemplate> inspectionTemplatePage = InspectionTemplate.inspectionTemplateDao.paginate(currentPage, rowCount, "SELECT *", " FROM `db_inspectionTemplate`" + paras);
        List<InspectionTemplate> inspectionTemplateList = inspectionTemplatePage.getList();
        Map results = toJson(inspectionTemplateList);
        results.put("currentPage", currentPage);
        results.put("totalPage", inspectionTemplatePage.getTotalPage());
        results.put("rowCount", rowCount);
        results.put("condition", condition_temp);
        renderJson(results);
    }

    public void originRecordList() {
        int rowCount = getParaToInt("rowCount");
        int currentPage = getParaToInt("currentPage");
        if (rowCount == 0) {
            rowCount = ParaUtils.getRowCount();
        }
        Page<OriginRecordTemplate> originRecordTemplatePage = OriginRecordTemplate.originRecordTemplateDao.paginate(currentPage, rowCount, "SELECT *", " FROM `db_originRecordTemplate`");
        List<OriginRecordTemplate> originRecordTemplateList = originRecordTemplatePage.getList();
        Map results = toOriginRecordJson(originRecordTemplateList);
        results.put("currentPage", currentPage);
        results.put("totalPage", originRecordTemplatePage.getTotalPage());
        results.put("rowCount", rowCount);
        renderJson(results);
    }

    /**
     * 将查询结果生成JSON
     *
     * @param entityList
     * @return
     */
    public Map toJson(List<InspectionTemplate> entityList) {
        Map<String, Object> json = new HashMap<>();
        List results = new ArrayList();
        for (InspectionTemplate inspectionTemplate : entityList) {
            results.add(inspectionTemplate);
        }
        json.put("results", results);
        return json;
    }


    /**
     * 将原始记录查询结果生成JSON
     *
     * @param entityList
     * @return
     */
    public Map toOriginRecordJson(List<OriginRecordTemplate> entityList) {
        Map<String, Object> json = new HashMap<>();
        List results = new ArrayList();
        for (OriginRecordTemplate originRecordTemplate : entityList) {
            results.add(originRecordTemplate);
        }
        json.put("results", results);
        return json;
    }


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

    public void getInspection() {
        try {
            List<InspectionTemplate> inspectionTemplates = InspectionTemplate.inspectionTemplateDao.find("SELECT * FROM `db_inspectionTemplate`");
            Map map = new HashMap();
            map.put("results", inspectionTemplates);
            renderJson(map);
        } catch (Exception e) {
            renderError(500);
        }
    }

    public void setInspection() {
        try {
            int id = getParaToInt("id");
            int template_id = getParaToInt("template_id");
            Boolean result = Monitor_Category.monitorCategoryDao.findById(id).set("inspection_template", template_id).update();
            renderJson(result ? RenderUtils.CODE_SUCCESS : RenderUtils.CODE_ERROR);
        } catch (Exception e) {
            renderError(500);
        }
    }

    public void deleteInspection() {
        try {
            int id = getParaToInt("id");
            Boolean result = Monitor_Category.monitorCategoryDao.findById(id).set("inspection_template", null).update();
            renderJson(result ? RenderUtils.CODE_SUCCESS : RenderUtils.CODE_ERROR);
        } catch (Exception e) {
            renderError(500);
        }
    }

    public void delInspectionTemplate() {
        try {
            int id = getParaToInt("id");
            Boolean result = InspectionTemplate.inspectionTemplateDao.deleteById(id);
            renderJson(result ? RenderUtils.CODE_SUCCESS : RenderUtils.CODE_ERROR);
        } catch (Exception e) {
            renderError(500);
        }

    }

    public void changeInspectionTemplate() {
        try {
            int id = getParaToInt("id");
            Boolean result = InspectionTemplate.inspectionTemplateDao.findById(id).set("name", getPara("name")).update();
            renderJson(result ? RenderUtils.CODE_SUCCESS : RenderUtils.CODE_ERROR);
        } catch (Exception e) {
            renderError(500);
        }
    }


    public void originRecord() {
        try {
            Boolean result = Db.tx(new IAtom() {
                @Override
                public boolean run() throws SQLException {
                    String name = getPara("name");
                    String path = getPara("path");
                    OriginRecordTemplate originRecordTemplate = new OriginRecordTemplate();
                    Boolean result = originRecordTemplate.set("name", name).set("path", path).save();
                    return result;
                }
            });
            renderJson(result ? RenderUtils.CODE_SUCCESS : RenderUtils.CODE_ERROR);
        } catch (Exception e) {
            renderError(500);
        }
    }


    public void getOriginRecord() {
        try {
            List<OriginRecordTemplate> originRecordTemplates = OriginRecordTemplate.originRecordTemplateDao.find("SELECT * FROM `db_originRecordTemplate`");
            Map map = new HashMap();
            map.put("results", originRecordTemplates);
            renderJson(map);
        } catch (Exception e) {
            renderError(500);
        }
    }
}
