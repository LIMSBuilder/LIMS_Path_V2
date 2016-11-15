package com.contact.controller.office;

import com.contact.utils.RenderUtils;
import com.jfinal.core.Controller;


/**
 * 导出类
 */
public class ExportController extends Controller {
    /**
     * 导出合同
     */
    public void exportContract(){
        int id =getParaToInt(0);
        getRequest().setAttribute("id","1");
        render("template/contract.jsp");
    }

    public void save(){
        System.out.println("执行了save");
        System.out.println( getPara("id"));
        System.out.println(getRequest().getAttribute("filename"));
       renderJson(RenderUtils.CODE_SUCCESS);
    }
}
