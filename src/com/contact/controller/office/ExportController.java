package com.contact.controller.office;

import com.contact.model.*;
import com.contact.utils.ParaUtils;
import com.contact.utils.RenderUtils;
import com.jfinal.core.Controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


/**
 * 导出类
 */
public class ExportController extends Controller {
    /**
     * 导出合同
     */
    public void exportContract(){
        try {
            int id =getParaToInt(0);
            String[] keep ={"id","identify","client","client_address","client_code","client_fax","client_tel","client_unit","finish_date","monitor_aim","monitor_type","monitor_way_desp","other","project_name","subpackage","subpackage_project","trustee_address","trustee_code","trustee_fax","trustee_tel","trustee_unit"};
            String[] payment_way = {"客户自取","挂号邮寄","其他方式"};
            Contract contract = Contract.contractDao.findById(id);
            if(contract!=null) {
                Map<String,String> result = new HashMap<>();
                for(String key : contract._getAttrNames()){
                    if(ParaUtils.isInArray(keep,key)){
                        result.put(key,contract.get(key).toString());
                    }
                }
                result.put("trustee", User.userDao.findById(contract.getInt("trustee")).getStr("name"));
                result.put("in_room",contract.getInt("in_room")==1?"是":"否");
                result.put("keep_secret",contract.getInt("keep_secret")==1?"是":"否");
                result.put("monitor_way",contract.getInt("monitor_way")==0?"是":"否");
                result.put("payment_way",payment_way[contract.getInt("payment_way")]);
                result.put("payment_count","￥"+contract.get("payment_count")+" "+ParaUtils.DigitUppercase(contract.get("payment_count").toString()));
                getRequest().setAttribute("entry",result);
            }
            List<Map> items =contract.getMonitorItems();
            getRequest().setAttribute("table",items);
            render("template/contract.jsp");
        }catch (Exception e){
            renderJson(RenderUtils.CODE_ERROR);
        }
    }

    public void save(){
        String type = getPara("type");
        switch (type){
            case "originRecord":
                int delivery_id = getParaToInt("delivery_id");//交联单ID
                int template_id = getParaToInt("template_id");//套用的模板ID
                OriginRecordTemplate originRecordTemplate =  OriginRecordTemplate.originRecordTemplateDao.findById(template_id);
                Delivery delivery = Delivery.deliveryDao.findById(delivery_id);
                if(originRecordTemplate!=null && delivery!=null){
                    Task task = Task.taskDao.findById(delivery.get("task_id"));
                    String name =  originRecordTemplate.get("name");
                    int size = Delivery_OriginRecord.delivery_originRecordDao.find("SELECT * FROM `db_deliveryOriginRecord` WHERE delivery_id="+delivery_id+" AND name like '"+name+"%'").size();
                    if (size!=0)name+=(size+1);
                    String fileName="("+task.get("identify")+")"+name+originRecordTemplate.getStr("path").substring(originRecordTemplate.getStr("path").lastIndexOf("."));
                    getRequest().setAttribute("name",name);
                    getRequest().setAttribute("fileName",fileName);
                    getRequest().setAttribute("delivery_id",delivery_id);
                }
                break;
        }
        render("template/savefile.jsp");
    }
}
