package com.contact.controller.office;

import com.contact.model.Contract;
import com.contact.model.MonitorItem;
import com.contact.model.User;
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
        render("template/savefile.jsp");
    }
}
