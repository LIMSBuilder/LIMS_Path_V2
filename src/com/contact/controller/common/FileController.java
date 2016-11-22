package com.contact.controller.common;

import com.contact.utils.RenderUtils;
import com.jfinal.core.Controller;
import com.jfinal.kit.PathKit;
import com.jfinal.upload.UploadFile;

import java.io.File;
import java.util.Date;
import java.util.Map;
import java.util.UUID;

/**
 * 文件Controller,与上传下载有关
 */
public class FileController extends Controller {
    //文件上传
    public void upload() {
        try {

            UploadFile uploadFile = getFile();
            //String saveDir = "/upload/"+UUID.randomUUID().toString().replace("-","").substring(0,10)+uploadFile.getFileName().substring(uploadFile.getFileName().lastIndexOf("."));
            //uploadFile.getFile().renameTo(new File(saveDir));
            Map result = RenderUtils.codeFactory(200);

            //result.put("path", saveDir);
            //将地址保存成绝对路径，通过磁盘访问的方式使用PageOffice调用，由于中文路径只支持绝对访问，因此只能通过调用硬盘的方式进行访问。
            result.put("path", uploadFile.getUploadPath()+"\\"+uploadFile.getFileName());
            renderJson(result);
        } catch (Exception e) {
            renderError(500);
        }
    }
}
