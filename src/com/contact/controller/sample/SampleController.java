package com.contact.controller.sample;

import com.contact.model.*;
import com.contact.model.Properties;
import com.contact.utils.ParaUtils;
import com.contact.utils.RenderUtils;
import com.jfinal.core.Controller;
import com.jfinal.kit.Prop;
import com.jfinal.kit.PropKit;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.IAtom;

import java.sql.SQLException;
import java.text.DecimalFormat;
import java.util.*;

/**
 * 样品:
 * 0:正常
 * -1:删除
 * 1:已接收
 * 2.实验分析完成
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
     * 获取所有id为task id 的样品的监测项目 不重复
     */
    public void getProjectList() {
        try {
            int id = getParaToInt("id");
            Task task = Task.taskDao.findById(id);
            Map<Monitor_Project, List<Sample>> project_sample = new LinkedHashMap<>();
            List<Sample> sampleList = Sample.sampleDao.find("SELECT * FROM `db_sample` WHERE state!=-1 AND `db_sample`.`task_id`=" + id);

            for (Sample sample : sampleList) {
                List<Sample_Project> sample_projects = Sample_Project.sample_projectDao.find("SELECT * FROM `db_sampleProject` WHERE `db_sampleProject`.`sample_id`=" + sample.get("id"));
                for (Sample_Project sample_project : sample_projects) {
                    Monitor_Project project = Monitor_Project.monitor_projectDao.findById(sample_project.get("project_id"));
                    if (project_sample.get(project) != null) {
                        project_sample.get(project).add(sample);
                    } else {
                        List temp = new ArrayList();
                        temp.add(sample);
                        project_sample.put(project, temp);
                    }
                }
            }


            Map temp = ProjecttoJson(project_sample);
            temp.put("sampleFrom", sampleList.get(0).get("identify"));
            temp.put("sampleTo", sampleList.get(sampleList.size() - 1).get("identify"));
            temp.put("sample_create", task.get("sample_time"));
            temp.put("sample_user", User.userDao.findById(task.getInt("sample_user")));


            renderJson(temp);
        } catch (Exception e) {
            renderError(500);
        }
    }


    /**
     * 通过交接联单进行管理后续项目
     */
    public void getProjectListByDelivery() {
        try {
            Map<Delivery, List<Sample>> project_sample = new HashMap();
            int task_id = getParaToInt("id");
            List<Delivery> deliveryList = Delivery.deliveryDao.find("SELECT * FROM db_delivery WHERE task_id =" + task_id);
            List<Sample> sampleList = Sample.sampleDao.find("SELECT * FROM `db_sample` WHERE state!=-1 AND `db_sample`.`task_id`=" + task_id);
            Task task = Task.taskDao.findById(task_id);
            for (Delivery delivery : deliveryList) {
                Monitor_Project monitor_project = Monitor_Project.monitor_projectDao.findById(delivery.get("project_id"));
                List<Sample> sampleProjectList = Sample.sampleDao.find("SELECT `db_sample`.* FROM `db_sample`,`db_sampleProject` WHERE `db_sample`.`id`=`db_sampleProject`.`sample_id` AND `db_sampleProject`.`project_id`=" + monitor_project.get("id") + " AND`db_sample`.`task_id`=" + task_id);
                project_sample.put(delivery, sampleProjectList);
            }
            Map temp = DeliverytoJson(project_sample);
            temp.put("sampleFrom", sampleList.size() != 0 ? sampleList.get(0).get("identify") : 0);
            temp.put("sampleTo", sampleList.size() != 0 ? sampleList.get(sampleList.size() - 1).get("identify") : 0);
            temp.put("sample_create", task.get("sample_time"));
            temp.put("sample_user", User.userDao.findById(task.getInt("sample_user")));
            renderJson(temp);
        } catch (Exception e) {
            renderError(500);
        }
    }

    /**
     * 通过交联单和当前登录用户获取需要当前用户进行实验分析的项目
     */
    public void getProjectListByDeliveryExperience() {
        try {
            Map<Delivery, List<Sample>> project_sample = new HashMap();
            int task_id = getParaToInt("id");
            User user = ParaUtils.getCurrentUser(getRequest());
            List<Delivery> deliveryList = Delivery.deliveryDao.find("SELECT * FROM db_delivery WHERE task_id =" + task_id + " AND analyst=" + user.get("id"));
//            List<Sample> sampleList = Sample.sampleDao.find("SELECT * FROM `db_sample` WHERE state!=1 AND `db_sample`.`task_id`=" + task_id);
            Task task = Task.taskDao.findById(task_id);
            for (Delivery delivery : deliveryList) {
                Monitor_Project monitor_project = Monitor_Project.monitor_projectDao.findById(delivery.get("project_id"));
                List<Sample> sampleProjectList = Sample.sampleDao.find("SELECT `db_sample`.* FROM `db_sample`,`db_sampleProject` WHERE `db_sample`.receive=1 AND `db_sample`.`id`=`db_sampleProject`.`sample_id` AND `db_sampleProject`.`project_id`=" + monitor_project.get("id") + " AND`db_sample`.`task_id`=" + task_id);
                project_sample.put(delivery, sampleProjectList);
            }
            Map temp = DeliverytoJson(project_sample);
//            temp.put("sampleFrom", sampleList.size() != 0 ? sampleList.get(0).get("identify") : 0);
//            temp.put("sampleTo", sampleList.size() != 0 ? sampleList.get(sampleList.size() - 1).get("identify") : 0);
//            temp.put("sample_create", task.get("sample_time"));
//            temp.put("sample_user", User.userDao.findById(task.getInt("sample_user")));
            renderJson(temp);
        } catch (Exception e) {
            renderError(500);
        }
    }


    /**
     * 将根据项目查找样品转换成合适的JSON并返回
     *
     * @return
     */
    public static Map ProjecttoJson(Map<Monitor_Project, List<Sample>> map) {
        Set result = new TreeSet(new Comparator() {
            @Override
            public int compare(Object o1, Object o2) {
                Map temp1 = (Map) o1;
                Map temp2 = (Map) o2;
                return Integer.parseInt(temp1.get("id").toString()) - Integer.parseInt(temp2.get("id").toString());
            }
        });
        int count = 0;
        for (Monitor_Project project : map.keySet()) {
            if (project != null) {
                List<Sample> value = map.get(project);
                Map<String, Object> temp = new TreeMap<String, Object>();
                temp.put("id", project.get("id"));
                temp.put("name", project.get("name"));
                temp.put("category", Monitor_Category.monitorCategoryDao.findById(project.getInt("category_id")));
                temp.put("samples", value);
                count += value.size();
                result.add(temp);
            }
        }
        Map returnTemp = new TreeMap();
        returnTemp.put("results", result.toArray());
        returnTemp.put("sampleCount", count);
        return returnTemp;
    }

    /**
     * 将根据项目查找样品转换成合适的JSON并返回
     *
     * @return
     */
    public static Map DeliverytoJson(Map<Delivery, List<Sample>> map) {
        List result = new ArrayList();
        int count = 0;
        for (Delivery delivery : map.keySet()) {
            if (delivery != null) {
                List<Sample> value = map.get(delivery);
                Map temp = new HashMap();
                int project_id = delivery.get("project_id");
                Monitor_Project project = Monitor_Project.monitor_projectDao.findById(project_id);
                temp.put("id", project.get("id"));
                temp.put("name", project.get("name"));
                temp.put("category", Monitor_Category.monitorCategoryDao.findById(project.getInt("category_id")));
                temp.put("inspection", InspectionTemplate.inspectionTemplateDao.findById(Monitor_Category.monitorCategoryDao.findById(project.getInt("category_id")).get("inspection_template")));
                temp.put("samples", value);
                temp.put("character", delivery.get("character"));
                temp.put("storage", delivery.get("storage"));

                temp.put("state", project.get("state"));
                temp.put("analyst", delivery.get("analyst") != null ? User.userDao.findById(delivery.get("analyst")) : null);
                temp.put("assessor", delivery.get("assessor") != null ? User.userDao.findById(delivery.get("assessor")) : null);
                temp.put("checker", delivery.get("checker") != null ? User.userDao.findById(delivery.get("checker")) : null);

                temp.put("analyst_time", delivery.get("analyst_time"));
                temp.put("assessor_time", delivery.get("assessor_time"));
                temp.put("checker_time", delivery.get("checker_time"));
                count += value.size();
                result.add(temp);
            }
        }
        Map returnTemp = new HashMap();
        returnTemp.put("results", result);
        returnTemp.put("sampleCount", count);
        return returnTemp;
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
                Prop p = PropKit.use("monitorPlan.properties");
                String pre = p.get(task.get("monitor_type").toString());//编号前缀
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
                properties.update();
            }
            while (identify != "" && Sample.sampleDao.find("SELECT * FROM `db_sample` WHERE identify='" + identify + "'").size() != 0);
            return identify;

        } catch (Exception e) {
            return null;
        }
    }

    public void receive() {
        try {
            int id = getParaToInt("id");
            int receive = getParaToInt("receive");
            Sample sample = Sample.sampleDao.findById(id);
            if (sample != null) {
                Boolean result = sample.set("receive", receive).update();
                renderJson(result ? RenderUtils.CODE_SUCCESS : RenderUtils.CODE_ERROR);
            } else {
                renderJson(RenderUtils.CODE_EMPTY);
            }
        } catch (Exception e) {
            renderError(500);
        }
    }
}
