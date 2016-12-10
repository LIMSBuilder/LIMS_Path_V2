package com.contact.controller.task;

import com.contact.model.Experience_FirstReview;
import com.contact.model.Task;
import com.contact.utils.ParaUtils;
import com.contact.utils.RenderUtils;
import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.IAtom;

import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

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
                renderJson(experienceFirstReview);
            } else renderJson(RenderUtils.CODE_EMPTY);
        } catch (Exception e) {
            renderError(500);
        }
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
                    // int result_process = getParaToInt("result_process");//决定审核通过还是审核不通过
                    Task task = Task.taskDao.findById(task_id);
                    Map results = getParaMap();
                    Experience_FirstReview experienceFirstReview = new Experience_FirstReview();
                    for (Object key : results.keySet()) {
                        if (!key.equals("task_id") && !key.equals("result_process")) {
                            String value = ((String[]) results.get(key))[0];
                            experienceFirstReview.set(key.toString(), value);
                        }
                    }
                    experienceFirstReview.set("result_user", ParaUtils.getCurrentUser(getRequest()).get("id")).set("result_time", sdfMore.format(new Date()));
                    Boolean result = experienceFirstReview.save();
                    result = result && task.set("experience_firstReview_record", experienceFirstReview.get("id")).update();
                    return result;
                }
            });
            renderJson(result ? RenderUtils.CODE_SUCCESS : RenderUtils.CODE_ERROR);
        } catch (Exception e) {
            renderError(500);
        }
    }
}
