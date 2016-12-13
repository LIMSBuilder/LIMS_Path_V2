package com.contact.model;

import com.jfinal.plugin.activerecord.Model;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by qulongjun on 2016/12/11.
 */
public class Experience_SecondReview extends Model<Experience_SecondReview> {
    public static Experience_SecondReview experienceSecondReviewDao = new Experience_SecondReview();

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
