package com.contact.controller.system;

import com.contact.utils.RenderUtils;
import com.jfinal.core.Controller;

import com.contact.model.Feedback;

/**
 * Created by qulongjun on 2016/11/1.
 */
public class FeedbackController extends Controller {

    public void add() {
        try {
            String type = getPara("type");
            String content = getPara("content");
            Boolean result = new Feedback().set("type", type).set("content", content).save();
            renderJson(result ? RenderUtils.CODE_SUCCESS : RenderUtils.CODE_ERROR);
        } catch (Exception e) {
            renderError(500);
        }
    }
}
