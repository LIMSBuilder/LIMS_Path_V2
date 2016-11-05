package com.contact.controller.sample;

import com.contact.model.*;
import com.contact.utils.RenderUtils;
import com.jfinal.core.Controller;
import com.jfinal.kit.Prop;
import com.jfinal.kit.PropKit;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.IAtom;

import java.sql.SQLException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by qulongjun on 2016/11/4.
 */
public class SampleController extends Controller {
    public void getSignleSample() {
        try {
            int id = getParaToInt("id");
            Task task = Task.taskDao.findById(id);

            if (task != null) {
                List<Sample> sampleList = Sample.sampleDao.find("SELECT * FROM `db_sample` WHERE state=0 AND task_id=" + id);
                Map result = toJson(sampleList);
                String contract_id = task.get("contract_id") == null ? null : task.get("contract_id").toString();
                result.put("projects", task.getMonitorProjects(contract_id == null ? "task" : "contract"));
                renderJson(result);
            } else {
                renderJson(RenderUtils.CODE_EMPTY);
            }
        } catch (Exception e) {
            renderError(500);
        }
    }


    /**
     * 保存样品
     */
    public void addItem() {
        try {
            Boolean result = Db.tx(new IAtom() {
                @Override
                public boolean run() throws SQLException {
                    int id = getParaToInt("id");//task id
                    Integer[] projects = getParaValuesToInt("projects[]");
                    String identify = identify(id);
                    if (identify == "") {
                        return false;
                    }
                    Sample sample = new Sample();
                    sample.set("identify", identify);
                    sample.set("name", getPara("name"));
                    sample.set("feature", getPara("feature"));
                    sample.set("condition", getPara("condition"));
                    sample.set("color", getPara("color"));
                    sample.set("state", 0);
                    sample.set("task_id", id);
                    Boolean result = sample.save();
                    Boolean item_result = true;
                    //List<Monitor_Project> monitor_projects = new ArrayList<Monitor_Project>();
                    for (int i : projects) {
                        //Monitor_Project monitor_project = Monitor_Project.monitor_projectDao.findById(i);
                        //monitor_projects.add(monitor_project);//保存以便返回json
                        item_result = new Sample_Project().set("sample_id", sample.get("id")).set("project_id", i).save();
                        if (!item_result) break;
                    }
                    return result && item_result;
                }
            });
            renderJson(result ? RenderUtils.CODE_SUCCESS : RenderUtils.CODE_ERROR);


        } catch (Exception e) {
            renderError(500);
        }
    }


    /**
     * 修改Item
     */
    public void changeItem() {
        try {
            Boolean result = Db.tx(new IAtom() {
                @Override
                public boolean run() throws SQLException {
                    String id = getPara("id") == null ? null : getPara("id").toString();
                    if (id != null) {
                        Sample sample = Sample.sampleDao.findById(id);
                        if (sample != null) {
                            Map map = getParaMap();
                            for (Object key : map.keySet()) {
                                if (!key.equals("projects[]") && !key.equals("id")) {
                                    String value = ((String[]) map.get(key))[0];
                                    sample.set(key.toString(), value);
                                }
                            }
                            Boolean result = sample.update();//更新sample是否成功
                            Boolean delete_result = true;//判定删除是否成功
                            Boolean item_result = true;//判定插入新的sample_project是否成功
                            List<Sample_Project> sample_projectList = Sample_Project.sample_projectDao.find("SELECT * FROM `db_sampleProject` WHERE `db_sampleProject`.`sample_id` =" + id);
                            for (Sample_Project sample_project : sample_projectList) {
                                delete_result = sample_project.delete();
                                if (!delete_result) break;
                            }
                            if (delete_result) {
                                //删除成功,重新插入新的sample_project
                                Integer[] projects = getParaValuesToInt("projects[]");
                                for (int i : projects) {
                                    item_result = new Sample_Project().set("sample_id", sample.get("id")).set("project_id", i).save();
                                    if (!item_result) break;
                                }
                            }
                            return result && delete_result && item_result;
                        } else {
                            return false;
                        }
                    } else {
                        return false;
                    }
                }
            });
            renderJson(result ? RenderUtils.CODE_SUCCESS : RenderUtils.CODE_ERROR);
        } catch (Exception e) {
            renderError(500);
        }

    }

    /**
     * 删除样品
     */
    public void delete() {
        try {
            int id = getParaToInt("id");
            Boolean result = Sample.sampleDao.deleteById(id);
            renderJson(result ? RenderUtils.CODE_SUCCESS : RenderUtils.CODE_ERROR);
        } catch (Exception e) {
            renderError(500);
        }
    }

    /**
     * 将查询结果生成JSON
     *
     * @param entityList
     * @return
     */
    public Map toJson(List<Sample> entityList) {
        Map<String, Object> json = new HashMap<>();
        List results = new ArrayList();
        for (Sample sample : entityList) {
            Map map = new HashMap();
            map.put("id", sample.get("id"));
            map.put("identify", sample.get("identify"));
            map.put("feature", sample.get("feature"));
            map.put("condition", sample.get("condition"));
            map.put("name", sample.get("name"));
            map.put("color", sample.get("color"));
            map.put("project", sample.getProject());
            results.add(map);
        }
        json.put("results", results);
        return json;
    }


    /**
     * 生成样品编号
     *
     * @param id 任务书
     */
    public static String identify(int id) {
        try {
            Task task = Task.taskDao.findById(id);
            int sample_type = task.get("sample_type");//判定采样方式
            String contract_id = task.get("contract_id") == null ? null : task.get("contract_id").toString();

            DecimalFormat df = new DecimalFormat("0000");//格式化合同编号字符串
            String identify = "";
            do {
                Properties properties = Properties.propertiesDao.findById(1);
                if (contract_id != null) {
                    //来自合同
                    Contract contract = Contract.contractDao.findById(contract_id);
                    Prop p = PropKit.use("monitorPlan.properties");
                    String pre = p.get(contract.get("monitor_type").toString());//编号前缀
                    String middle = "";//编号中缀
                    String last = "";//编号后缀"
                    if (sample_type == 0) {
                        //自送样
                        middle = properties.get("sample_self_middle");
                        int newId = properties.getInt("sample_self_serial") + 1;
                        last = df.format(newId);
                        if (newId == 9999) {
                            //自送样编号-1
                            properties.set("sample_self_serial", 0);
                            properties.set("sample_self_middle", (char) (Integer.parseInt(middle) - 1));
                        } else {
                            properties.set("sample_self_serial", newId);
                        }

                    } else {
                        //现场采样
                        middle = properties.get("sample_scene_middle");
                        int newId = properties.getInt("sample_scene_serial") + 1;
                        last = df.format(newId);
                        if (newId == 9999) {
                            //自送样编号-1
                            properties.set("sample_scene_serial", 0);
                            properties.set("sample_scene_middle", (char) (Integer.parseInt(middle) - 1));
                        } else {
                            properties.set("sample_scene_serial", newId);
                        }
                    }
                    identify = pre + middle + last;
                } else {
                    //来自自定义


                }
                properties.update();
            }
            while (identify != "" && Sample.sampleDao.find("SELECT * FROM `db_sample` WHERE identify='" + identify + "'").size() != 0);
            return identify;

        } catch (Exception e) {
            //renderError(500);
            return null;
        }
    }
}
