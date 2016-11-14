package com.contact.controller.office;

import com.contact.utils.DocumentHandler;
import com.jfinal.core.Controller;

import java.util.Map;
import java.util.HashMap;

/**
 * 导出类
 */
public class ExportController extends Controller {
    /**
     * 导出合同
     */
    public void exportContract(){
        
        Map<String, Object> dataMap = new HashMap<String, Object>();
        dataMap.put("identify","001");
        DocumentHandler documentHandler = new DocumentHandler();
        documentHandler.createDoc(dataMap,"aaa.xml","G:\\a.doc");
    }
}
