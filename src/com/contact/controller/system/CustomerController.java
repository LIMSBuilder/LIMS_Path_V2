package com.contact.controller.system;

import com.contact.model.Customer;
import com.contact.utils.RenderUtils;
import com.jfinal.core.Controller;

public class CustomerController extends Controller {

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
