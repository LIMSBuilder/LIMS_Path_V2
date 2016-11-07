package com.contact.controller.common;

import com.contact.utils.RenderUtils;
import com.jfinal.core.Controller;
import com.jfinal.upload.UploadFile;

import java.io.File;
import java.util.Map;

/**
 * 文件Controller,与上传下载有关
 */
public class FileController extends Controller {
    //文件上传
    public void upload() {
        try {
            UploadFile uploadFile = getFile();
            Map result = RenderUtils.codeFactory(200);
            result.put("path", uploadFile.getUploadPath());
            renderJson(result);
        } catch (Exception e) {
            renderError(500);
        }
    }
}
