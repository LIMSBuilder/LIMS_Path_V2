package com.contact.model;

import com.jfinal.plugin.activerecord.Model;

import java.util.HashMap;
import java.util.Map;

/**
 * 原始记录一审
 */
public class Experience_FirstReview extends Model<Experience_FirstReview> {
    public static Experience_FirstReview experienceFirstReviewDao = new Experience_FirstReview();


    public Map getMoreInfo() {
        Map result = new HashMap();
        for (String key : this._getAttrNames()) {
            if (key.equals("result_user")) {
                result.put(key, User.userDao.findById(this.get(key)).getUserInfo());
            } else
                result.put(key, this.get(key));

        }
        return result;
    }
}
