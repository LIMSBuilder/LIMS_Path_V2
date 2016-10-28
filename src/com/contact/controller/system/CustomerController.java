package com.contact.controller.system;

import com.contact.model.Customer;
import com.contact.model.Role;
import com.contact.utils.ParaUtils;
import com.contact.utils.RenderUtils;
import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Page;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class CustomerController extends Controller {

    /**
     * 列表展示
     */
    public void list() {
        int rowCount = getParaToInt("rowCount");
        int currentPage = getParaToInt("currentPage");
        String condition_temp = getPara("condition");
        Map condition = ParaUtils.getSplitCondition(condition_temp);
        if (rowCount == 0) {
            rowCount = ParaUtils.getRowCount();
        }
        String paras = "";
        Object[] keys = condition.keySet().toArray();
        for (int i = 0; i < keys.length; i++) {
            if (i == 0) {
                paras += " WHERE ";
            }
            String key = (String) keys[i];
            Object value = condition.get(key);
            if (i != keys.length - 1) {
                paras += (key + " like \"%" + value + "%\" AND ");
            } else {
                paras += (key + " like \"%" + value + "%\"");
            }

        }
        Page<Customer> customerPage = Customer.customerDao.paginate(currentPage, rowCount, "SELECT *", " FROM `db_customer`" + paras);
        List<Customer> customerList = customerPage.getList();
        Map results = toJson(customerList);
        results.put("currentPage", currentPage);
        results.put("totalPage", customerPage.getTotalPage());
        results.put("rowCount", rowCount);
        results.put("condition", condition_temp);
        renderJson(results);
    }


    /**
     * 将查询结果生成JSON
     *
     * @param entityList
     * @return
     */
    public Map toJson(List<Customer> entityList) {
        Map<String, Object> json = new HashMap<>();
        List results = new ArrayList();
        for (Customer customer : entityList) {
            Map<String, Object> customerList = new HashMap<>();
            customerList.put("id", customer.getInt("id"));
            customerList.put("client_unit", customer.get("client_unit"));
            customerList.put("client_code", customer.get("client_code"));
            customerList.put("client_address", customer.get("client_address"));
            customerList.put("client_tel", customer.get("client_tel"));
            customerList.put("client", customer.get("client"));
            customerList.put("client_fax", customer.get("client_fax"));
            results.add(customerList);
        }
        json.put("results", results);
        return json;
    }


    public void add() {
        try {
            Boolean result = new Customer()
                    .set("client_unit", getPara("client_unit"))
                    .set("client_code", getPara("client_code"))
                    .set("client_address", getPara("client_address"))
                    .set("client_tel", getPara("client_tel"))
                    .set("client", getPara("client"))
                    .set("client_fax", getPara("client_fax"))
                    .save();
            renderJson(result ? RenderUtils.CODE_SUCCESS : RenderUtils.CODE_ERROR);
        } catch (Exception e) {
            System.out.println(e.toString());
            renderError(500);
        }
    }
}
