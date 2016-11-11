package com.contact.controller.quality;

import com.contact.model.*;
import com.contact.utils.RenderUtils;
import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.IAtom;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.TimeoutException;

/**
 * Created by qulongjun on 2016/11/11.
 */
public class QualityController extends Controller {

    public void list() {
        try {
            int id = getParaToInt("id");
            List<Quality> qualityList = Quality.qualityDao.find("SELECT * FROM `db_qualityController` WHERE task_id=" + id);
            List result = new ArrayList();
            for (int i = 0; qualityList != null && i < qualityList.size(); i++) {
                Quality quality = qualityList.get(i);
                List<QualityScene> qualitySceneList = QualityScene.qualitySceneDao.find("SELECT * FROM `db_qualityScene` WHERE quality_id=" + quality.get("id"));
                List<QualityLab> qualityLabList = QualityLab.qualityLabDao.find("SELECT * FROM `db_qualityLab` WHERE quality_id=" + quality.get("id"));
                List<QualityMark> qualityMarkList = QualityMark.qualityMarkDao.find("SELECT * FROM `db_qualityMark` WHERE quality_id=" + quality.get("id"));
                Map temp = new HashMap();
                temp.put("id", quality.get("id"));
                temp.put("project", Monitor_Project.monitor_projectDao.findById(quality.get("project_id")));
                temp.put("blind", quality.get("blind"));
                temp.put("scene", toJSONQualityScene(qualitySceneList));
                temp.put("lab", toJSONQualityLab(qualityLabList));
                temp.put("mark", toJSONQualityMark(qualityMarkList));
                result.add(temp);
            }
            Map json = RenderUtils.codeFactory(200);
            json.put("results", result);
            renderJson(json);
        } catch (Exception e) {
            renderError(500);
        }
    }

    public List toJSONQualityScene(List<QualityScene> arr) {
        List result = new ArrayList();
        for (int i = 0; arr != null && i < arr.size(); i++) {
            Map temp = new HashMap();
            QualityScene qualityScene = arr.get(i);
            temp.put("id", qualityScene.get("sample_id"));
            temp.put("name", Sample.sampleDao.findById(qualityScene.get("sample_id")));
            result.add(temp);
        }
        return result;
    }

    public List toJSONQualityMark(List<QualityMark> arr) {
        List result = new ArrayList();
        for (int i = 0; arr != null && i < arr.size(); i++) {
            Map temp = new HashMap();
            QualityMark qualityMark = arr.get(i);
            temp.put("id", qualityMark.get("sample_id"));
            temp.put("name", Sample.sampleDao.findById(qualityMark.get("sample_id")));
            result.add(temp);
        }
        return result;
    }

    public List toJSONQualityLab(List<QualityLab> arr) {
        List result = new ArrayList();
        for (int i = 0; arr != null && i < arr.size(); i++) {
            Map temp = new HashMap();
            QualityLab qualityLab = arr.get(i);
            temp.put("id", qualityLab.get("sample_id"));
            temp.put("name", Sample.sampleDao.findById(qualityLab.get("sample_id")));
            result.add(temp);
        }
        return result;
    }

    public void save() {
        Boolean result = Db.tx(new IAtom() {
            @Override
            public boolean run() throws SQLException {
                Integer[] labList = getParaValuesToInt("labList[]");
                Integer[] markList = getParaValuesToInt("markList[]");
                Integer[] sceneList = getParaValuesToInt("sceneList[]");
                int blindCount = getParaToInt("blindCount");
                int id = getParaToInt("id");
                int project_id = getParaToInt("project_id");
                Quality quality = new Quality();
                quality.set("task_id", id).set("project_id", project_id).set("blind", blindCount);
                Boolean result = quality.save();//保存质量控制本体
                Boolean sceneResult = true;//现场
                Boolean markResult = true;//回收
                Boolean labResult = true;//实验室
                for (int i = 0; sceneList != null && i < sceneList.length; i++) {
                    QualityScene qualityScene = new QualityScene();
                    sceneResult = qualityScene.set("quality_id", quality.get("id")).set("sample_id", sceneList[i]).save();
                    if (!sceneResult) break;
                }
                for (int i = 0; labList != null && i < labList.length; i++) {
                    QualityLab qualityLab = new QualityLab();
                    labResult = qualityLab.set("quality_id", quality.get("id")).set("sample_id", labList[i]).save();
                    if (!labResult) break;
                }
                for (int i = 0; markList != null && i < markList.length; i++) {
                    QualityMark qualityMark = new QualityMark();
                    markResult = qualityMark.set("quality_id", quality.get("id")).set("sample_id", markList[i]).save();
                    if (!markResult) break;
                }
                return result && sceneResult && markResult && labResult;
            }
        });
        renderJson(result ? RenderUtils.CODE_SUCCESS : RenderUtils.CODE_ERROR);
    }

    public void deleteItem() {
        try {
            int id = getParaToInt("id");
            Boolean result = Quality.qualityDao.deleteById(id);
            renderJson(result ? RenderUtils.CODE_SUCCESS : RenderUtils.CODE_ERROR);
        } catch (Exception e) {
            renderError(500);
        }
    }
}
