package com.contact.controller.task;

import com.contact.model.Experience_FirstReview;
import com.contact.model.Experience_SecondReview;
import com.contact.model.Task;
import com.contact.model.User;
import com.contact.utils.ParaUtils;
import com.contact.utils.RenderUtils;
import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.IAtom;

import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * 审核控制
 * 检测结果审核:专家一审 / 专家二审
 */
public class ReviewController extends Controller {
    SimpleDateFormat sdfMore = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

    /**
     * 获取一审信息
     */
    public void getFirstReviewInfo() {
        try {
            int task_id = getParaToInt("task_id");
            Task task = Task.taskDao.findById(task_id);
            if (task != null) {
                //获取一审记录
                Experience_FirstReview experienceFirstReview = Experience_FirstReview.experienceFirstReviewDao.findById(task.getInt("experience_firstReview_record"));
                if (experienceFirstReview != null) renderJson(toFirstJSON(experienceFirstReview));
                else renderNull();
            } else renderJson(RenderUtils.CODE_EMPTY);
        } catch (Exception e) {
            renderError(500);
        }
    }

    /**
     * 一审信息转换成JSON形式
     */
    public static Map toFirstJSON(Experience_FirstReview experienceFirstReview) {
        Map result = new HashMap();
        for (String key : experienceFirstReview._getAttrNames()) {
            if (key.equals("result_user")) {
                result.put("result_user", User.userDao.findById(experienceFirstReview.get("result_user")).getUserInfo());
            } else {
                result.put(key, experienceFirstReview.get(key));
            }
        }
        return result;
    }

    /**
     * 将多个一审记录转换成JSON形式
     *
     * @return
     */
    public static Map toFirstsJSON(List<Experience_FirstReview> experience_firstReviewList, Experience_FirstReview now) {
        Map result = new HashMap();
        List temp = new ArrayList();
        for (Experience_FirstReview experienceFirstReview : experience_firstReviewList) {
            temp.add(toFirstJSON(experienceFirstReview));
        }
        result.put("nowResult", now);
        result.put("results", temp);
        return result;
    }


    /**
     * 新增一审信息
     */
    public void addFirstReview() {
        try {
            final Boolean result = Db.tx(new IAtom() {
                @Override
                public boolean run() throws SQLException {
                    int task_id = getParaToInt("task_id");//获取Task的id
                    Task task = Task.taskDao.findById(task_id);
                    Map results = getParaMap();
                    Boolean result = true;
                    if (task.get("experience_firstReview_record") != null) {
                        //修改当前原始记录审核
                        Experience_FirstReview experienceFirstReview = Experience_FirstReview.experienceFirstReviewDao.findById(task.getInt("experience_firstReview_record"));
                        for (Object key : results.keySet()) {
                            if (!key.equals("task_id")) {
                                String value = ((String[]) results.get(key))[0];
                                experienceFirstReview.set(key.toString(), value);
                            }
                        }
                        experienceFirstReview.set("result_user", ParaUtils.getCurrentUser(getRequest()).get("id")).set("result_time", sdfMore.format(new Date())).set("task_id", task_id);
                        result = experienceFirstReview.update();
                    } else {
                        //新增一条原始记录审核
                        Experience_FirstReview experienceFirstReview = new Experience_FirstReview();
                        for (Object key : results.keySet()) {
                            if (!key.equals("task_id")) {
                                String value = ((String[]) results.get(key))[0];
                                experienceFirstReview.set(key.toString(), value);
                            }
                        }
                        experienceFirstReview.set("result_user", ParaUtils.getCurrentUser(getRequest()).get("id")).set("result_time", sdfMore.format(new Date())).set("task_id", task_id);
                        result = experienceFirstReview.save();
                        result = result && task.set("experience_firstReview_record", experienceFirstReview.get("id")).update();
                    }
                    return result;
                }
            });
            renderJson(result ? RenderUtils.CODE_SUCCESS : RenderUtils.CODE_ERROR);
        } catch (Exception e) {
            renderError(500);
        }
    }

    /**
     * 检查一审原始记录是否完成
     */
    public void checkFirstOriginReview() {
        try {
            int task_id = getParaToInt("task_id");
            Task task = Task.taskDao.findById(task_id);
            renderJson(task.get("experience_firstReview_record") != null ? RenderUtils.CODE_SUCCESS : RenderUtils.CODE_EMPTY);
        } catch (Exception e) {
            renderError(500);
        }
    }


    /**
     * 获取所有原始记录一审记录列表
     */
    public void getFirstList() {
        try {
            int task_id = getParaToInt("task_id");
            Task task = Task.taskDao.findById(task_id);
            if (task != null) {
                List<Experience_FirstReview> experienceFirstReviewList = Experience_FirstReview.experienceFirstReviewDao.find("SELECT * FROM `db_experience_first` WHERE task_id=" + task_id);
                Experience_FirstReview experienceFirstReview = Experience_FirstReview.experienceFirstReviewDao.findById(task.getInt("experience_firstReview_record"));
                renderJson(toFirstsJSON(experienceFirstReviewList, experienceFirstReview));
            } else {
                renderJson(RenderUtils.CODE_EMPTY);
            }
        } catch (Exception e) {
            renderError(500);
        }
    }


    /**
     * 获取一审信息
     */
    public void getSecondReviewInfo() {
        try {
            int task_id = getParaToInt("task_id");
            Task task = Task.taskDao.findById(task_id);
            if (task != null) {
                //获取二审记录
                Experience_SecondReview experienceSecondReview = Experience_SecondReview.experienceSecondReviewDao.findById(task.getInt("experience_secondReview_record"));
                if (experienceSecondReview != null) renderJson(toSecondJSON(experienceSecondReview));
                else renderNull();
            } else renderJson(RenderUtils.CODE_EMPTY);
        } catch (Exception e) {
            renderError(500);
        }
    }

    /**
     * 二审信息转换成JSON形式
     */
    public static Map toSecondJSON(Experience_SecondReview experienceSecondReview) {
        Map result = new HashMap();
        for (String key : experienceSecondReview._getAttrNames()) {
            if (key.equals("result_user")) {
                result.put("result_user", User.userDao.findById(experienceSecondReview.get("result_user")).getUserInfo());
            } else {
                result.put(key, experienceSecondReview.get(key));
            }
        }
        return result;
    }


    /**
     * 新增二审信息
     */
    public void addSecondReview() {
        try {
            final Boolean result = Db.tx(new IAtom() {
                @Override
                public boolean run() throws SQLException {
                    int task_id = getParaToInt("task_id");//获取Task的id
                    Task task = Task.taskDao.findById(task_id);
                    Map results = getParaMap();
                    Boolean result = true;
                    if (task.get("experience_secondReview_record") != null) {
                        //修改当前原始记录审核
                        Experience_SecondReview experience_secondReview = Experience_SecondReview.experienceSecondReviewDao.findById(task.getInt("experience_secondReview_record"));
                        for (Object key : results.keySet()) {
                            if (!key.equals("task_id")) {
                                String value = ((String[]) results.get(key))[0];
                                experience_secondReview.set(key.toString(), value);
                            }
                        }
                        experience_secondReview.set("result_user", ParaUtils.getCurrentUser(getRequest()).get("id")).set("result_time", sdfMore.format(new Date())).set("task_id", task_id);
                        result = experience_secondReview.update();
                    } else {
                        //新增一条原始记录审核
                        Experience_SecondReview experienceSecondReview = new Experience_SecondReview();
                        for (Object key : results.keySet()) {
                            if (!key.equals("task_id")) {
                                String value = ((String[]) results.get(key))[0];
                                experienceSecondReview.set(key.toString(), value);
                            }
                        }
                        experienceSecondReview.set("result_user", ParaUtils.getCurrentUser(getRequest()).get("id")).set("result_time", sdfMore.format(new Date())).set("task_id", task_id);
                        result = experienceSecondReview.save();
                        result = result && task.set("experience_secondReview_record", experienceSecondReview.get("id")).update();
                    }
                    return result;
                }
            });
            renderJson(result ? RenderUtils.CODE_SUCCESS : RenderUtils.CODE_ERROR);
        } catch (Exception e) {
            renderError(500);
        }
    }

    /**
     * 获取所有原始记录一审记录列表
     */
    public void getSecondList() {
        try {
            int task_id = getParaToInt("task_id");
            Task task = Task.taskDao.findById(task_id);
            if (task != null) {
                List<Experience_SecondReview> experienceSecondReviewList = Experience_SecondReview.experienceSecondReviewDao.find("SELECT * FROM `db_experience_second` WHERE task_id=" + task_id);
                Experience_SecondReview experienceSecondReview = Experience_SecondReview.experienceSecondReviewDao.findById(task.getInt("experience_secondReview_record"));
                renderJson(toSecondJSON(experienceSecondReviewList, experienceSecondReview));
            } else {
                renderJson(RenderUtils.CODE_EMPTY);
            }
        } catch (Exception e) {
            renderError(500);
        }
    }

    /**
     * 将多个二审记录转换成JSON形式
     *
     * @return
     */
    public static Map toSecondJSON(List<Experience_SecondReview> experience_secondReviews, Experience_SecondReview now) {
        Map result = new HashMap();
        List temp = new ArrayList();
        for (Experience_SecondReview experienceSecondReview : experience_secondReviews) {
            temp.add(toSecondJSON(experienceSecondReview));
        }
        result.put("nowResult", now);
        result.put("results", temp);
        return result;
    }

    /**
     * 检查一审原始记录是否完成
     */
    public void checkSecondOriginReview() {
        try {
            int task_id = getParaToInt("task_id");
            Task task = Task.taskDao.findById(task_id);
            renderJson(task.get("experience_secondReview_record") != null ? RenderUtils.CODE_SUCCESS : RenderUtils.CODE_EMPTY);
        } catch (Exception e) {
            renderError(500);
        }
    }
}
