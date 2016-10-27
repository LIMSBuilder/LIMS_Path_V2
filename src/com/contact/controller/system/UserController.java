package com.contact.controller.system;

import com.contact.utils.RenderUtils;
import com.jfinal.core.Controller;

/**
 * Created by qulongjun on 2016/10/27.
 */
public class UserController extends Controller {
    public void add() {
        renderJson(RenderUtils.CODE_SUCCESS);

    }
}
