<div class="panel panel-default">
    <div class="panel-body">
        <div class="alert alert-warning">
            <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
            <strong>❗️请保管好自己的账号密码，每个月修改一次密码可以有效防止密码泄露。</strong>
        </div>
        <form class="form-horizontal">
            <div class="form-group">
                <label class="col-sm-3 control-label" for="username">用户名</label>
                <div class="col-sm-6">
                    <input type="text" id="username" v-model="username" class="form-control"
                           readonly="readonly">
                    <span class="help-block">用户名作为唯一登录凭证，暂不支持自助修改。</span>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label">姓名</label>
                <div class="col-sm-6">
                    <input type="text" v-model="name" class="form-control">
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label">性别</label>
                <div class="col-sm-6">
                    <div class="rdio rdio-primary">
                        <input type="radio" v-model="sex" name="radio" value="男" id="man" checked/>
                        <label for="man">男</label>
                    </div>
                    <div class="rdio rdio-primary">
                        <input type="radio" v-model="sex" name="radio" value="女" id="female"/>
                        <label for="female">女</label>
                    </div>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label">证件号</label>
                <div class="col-sm-6">
                    <input type="text" v-model="idCard" class="form-control">
                    <span class="help-block">证件号是用户找回密码的唯一凭证。</span>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label">联系电话</label>
                <div class="col-sm-6">
                    <input type="text" v-model="tel" class="form-control">
                </div>
            </div>

            <div class="form-group">
                <label class="col-sm-3 control-label">所属部门</label>
                <div class="col-sm-6">
                    <select class="select2" v-model="belong_department" id="depart_select" data-placeholder="请选择部门...">
                        <option value=""></option>
                        <template v-for="item in department_list">
                            <option value="{{item.id}}">{{item.name}}</option>
                        </template>
                    </select>
                </div>
            </div>

            <div class="form-group">
                <label class="col-sm-3 control-label">所属角色</label>
                <div class="col-sm-6">

                    <select class="select2" v-model="belong_role" id="role_select" data-placeholder="请选择角色...">
                        <option value=""></option>
                        <template v-for="item in role_list">
                            <option value="{{item.id}}">{{item.name}}</option>
                        </template>
                    </select>

                </div>
            </div>
            <hr>
            <div class="form-group">
                <div class="text-center">
                    <a class="btn btn-primary" @click="save">保存设置</a>
                </div>
            </div>
        </form>
    </div>
</div>
<script type="text/javascript">
    var vue = new Vue({
        el: "#contentpanel",
        data: {
            "username": "",
            "name": "",
            "sex": "",
            "idCard": "",
            "tel": "",
            "belong_department": "",
            "belong_role": "",
            "department_list": [],
            "role_list": []

        },
        methods: {
            save: function () {
                var me = this;
                jQuery.fn.check_msg({
                    msg: "是否完成个人基本信息的修改?",
                    success: function () {
                        console.log(JSON.parse(JSON.stringify(me._data)));
                        jQuery.fn.alert_msg("个人基本信息保存成功!");
                    }
                })
            }
        },
        ready: function () {
            var me = this;
            me.$http.get("/assets/json/role_list.json").then(function (response) {
                var data = response.data;
                me.$set("department_list", data.results);
                me.$http.get("/assets/json/user_info.json").then(function (response) {
                    var data = response.data;
                    for (var key in data) {
                        if (me[key] != undefined) {
                            me.$set(key, data[key]);
                            if (key == "belong_department") {
                                jQuery("#depart_select option[value=" + data[key] + "]").prop("selected", true);
                                jQuery("#depart_select").trigger("change");
                            }
                        }
                    }
                }, function (response) {

                });
            }, function (response) {

            });


            jQuery('.select2').select2({
                width: '100%',
                minimumResultsForSearch: -1
            });
            jQuery("#depart_select").on("change", function () {
                var id = this.value;
                me.department_list.forEach(function (item) {
                    if (item.id == id) {
                        me.$set("role_list", item.role);
                    }
                });
            });
        }
    });

</script>