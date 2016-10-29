<div class="row">
    <div class="col-md-12">
        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title">乙方预设信息</h3>
            </div>
            <div class="panel-body">
                <form class="form-horizontal form-bordered" id="default_info">
                    <div class="form-group">
                        <label class="col-sm-2 text-center  control-label">受托单位</label>
                        <div class="col-sm-9">
                            <input type="text" placeholder="请输入单位名称" v-model="trustee_unit" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 text-center  control-label">邮政编码</label>
                        <div class="col-sm-9">
                            <input type="text" placeholder="请输入邮政编码" v-model="trustee_code" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 text-center  control-label">联系地址</label>
                        <div class="col-sm-9">
                            <input type="text" placeholder="请输入联系地址" v-model="trustee_address" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 text-center  control-label">联系电话</label>
                        <div class="col-sm-9">
                            <input type="text" placeholder="请输入联系电话" v-model="trustee_tel" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 text-center  control-label">承办人</label>
                        <div class="col-sm-9">
                            <!--<input type="text" placeholder="请输入承办人姓名" v-model="trustee.name" class="form-control">-->
                            <select class="select2" id="user_select" v-model="trustee.name"
                                    data-placeholder="请选择承办人...">
                                <option value=""></option>
                                <template v-for="item in users">
                                    <option value="{{item.id}}">{{item.name}}</option>
                                </template>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 text-center  control-label">传真电话</label>
                        <div class="col-sm-9">
                            <input type="text" placeholder="请输入传真" v-model="trustee_fax" class="form-control">
                        </div>
                    </div>
                    <div class="form-group text-center">
                        <a class="btn btn-primary" @click="save">保存设置</a>
                        <a class="btn btn-default" @click="clear">清 空 </a>
                    </div>

                </form>
            </div>
        </div><!-- panel -->

    </div>

</div>


<script type="text/javascript">
    var vue = new Vue({
        el: '#contentpanel',
        data: {
            "trustee_unit": "",
            "trustee_code": "",
            "trustee_address": "",
            "trustee_tel": "",
            "trustee": "",
            "trustee_fax": "",
            "users": []
        },
        methods: {
            save: function () {
                var me = this;
                console.log(JSON.parse(JSON.stringify(this._data)));
                var data = {
                    "trustee_unit": me.trustee_unit,
                    "trustee_code": me.trustee_code,
                    "trustee_address": me.trustee_address,
                    "trustee_tel": me.trustee_tel,
                    "trustee": me.trustee,
                    "trustee_fax": me.trustee_fax
                }

                me.$http.post("/default/setDefault", data).then(function (response) {
                    var data = response.data;
                    jQuery.fn.codeState(data.code, {
                        200: "预设信息修改成功!"
                    })
                }, function () {
                    jQuery.fn.error_msg("数据异常,无法设置预设信息,请尝试刷新操作。");
                })
            },
            clear: function () {
                var me = this;
                var data = this._data;
                for (var key in data) {
                    me.$set(key, "");
                }
            }
        },
        ready: function () {
            var me = this;
            var dom = jQuery(me.$el);
            me.$http.get("/user/getList").then(function (response) {
                var data = response.data;
                me.$set("users", data.results);
            }, function (response) {
                jQuery.fn.error_msg("无法获取用户列表信息,请尝试刷新操作。");
            });

            dom.find('.select2').select2({
                width: '100%',
                minimumResultsForSearch: -1
            });
            dom.find('#user_select').on("change", function (event) {
                me.$set("trustee", event.val);
            });
            me.$http.get("/default/getDefault").then(function (response) {
                var data = response.data;
                for (var key in data) {
                    me.$set(key, data[key]);
                    if (key == "trustee") {
                        jQuery("#user_select").val(data[key].id);
                        jQuery("#user_select").trigger("change");
                    }
                }
            }, function (response) {
                jQuery.fn.error_msg("无法获取预设信息,请尝试刷新操作。");
            });


        }
    });

</script>