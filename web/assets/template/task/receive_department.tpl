<div class="panel panel-default">
    <div class="panel-body">
        <div class="alert alert-warning">
            <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
            <strong>❗️请正确设置任务书的承接科室,系统根据设置进行项目流转。</strong>
        </div>
        <form class="form-horizontal">
            <h3 class="text-center">自送样</h3>
            <div class="form-group">
                <label class="col-sm-3 control-label">承接科室</label>
                <div class="col-sm-6">
                    <select class="select2" id="self_depart" data-placeholder="请选择部门...">
                        <option value=""></option>
                        <template v-for="item in department_list">
                            <option value="{{item.id}}">{{item.name}}</option>
                        </template>
                    </select>
                </div>
                <div class="col-sm-3">
                    <label class="text-warning">当前:{{sample_self}}</label><br/>
                </div>
            </div>

            <div class="form-group">
                <label class="col-sm-3 control-label">负责岗位</label>
                <div class="col-sm-6">

                    <select class="select2" id="self_role" data-placeholder="请选择角色...">
                        <option value=""></option>
                        <template v-for="item in self_role_list">
                            <option value="{{item.id}}">{{item.name}}</option>
                        </template>
                    </select>
                </div>
                <div class="col-sm-3">
                    <label class="text-warning">当前:{{sample_self_role}}</label><br/>
                </div>
            </div>
            <div class="form-group">
                <div class="text-center">
                    <a class="btn btn-primary" @click="save_self">保存设置</a>
                </div>
            </div>
            <hr>
            <h3 class="text-center">现场采样</h3>
            <hr>
            <div class="form-group">
                <label class="col-sm-3 control-label">承接科室</label>
                <div class="col-sm-6">
                    <select class="select2" id="scene_depart" data-placeholder="请选择部门...">
                        <option value=""></option>
                        <template v-for="item in department_list">
                            <option value="{{item.id}}">{{item.name}}</option>
                        </template>
                    </select>
                </div>
                <div class="col-sm-3">
                    <label class="text-warning">当前:{{sample_scene}}</label><br/>
                </div>
            </div>

            <div class="form-group">
                <label class="col-sm-3 control-label">负责岗位</label>
                <div class="col-sm-6">

                    <select class="select2" id="scene_role" data-placeholder="请选择角色...">
                        <option value=""></option>
                        <template v-for="item in scene_role_list">
                            <option value="{{item.id}}">{{item.name}}</option>
                        </template>
                    </select>
                </div>
                <div class="col-sm-3">
                    <label class="text-warning">当前:{{sample_scene_role}}</label><br/>
                </div>
            </div>
            <div class="form-group">
                <div class="text-center">
                    <a class="btn btn-primary" @click="save_scene">保存设置</a>
                </div>
            </div>
        </form>
    </div>
</div>
<script type="text/javascript">
    var vue = new Vue({
        el: "#contentpanel",
        data: {
            "sample_self": "",
            "sample_scene": "",
            "sample_self_role": "",
            "sample_scene_role": "",
            "department_list": [],
            "self_role_list": [],
            "scene_role_list": []
        },
        methods: {
            save_self: function () {
                var me = this;
                var data = {
                    sample_receive_self: jQuery('#self_depart').val(),
                    sample_receive_self_role: jQuery('#self_role').val()
                };
                if ((!data.sample_receive_self) || (!data.sample_receive_self_role)) {
                    jQuery.fn.error_msg("您尚未设置完整承接科室和负责岗位!");
                    return;
                }
                jQuery.fn.check_msg({
                    msg: "是否保存自送样承接科室和岗位的设置?",
                    success: function () {
                        me.$http.post("/properties/setReceiveInfo", data).then(function (response) {
                            var data = response.data;
                            jQuery.fn.codeState(data.code, {
                                200: function () {
                                    jQuery.fn.alert_msg("承接科室设置成功!");
                                    me.load_prop();
                                }
                            })
                        }, function (response) {
                            jQuery.fn.error_msg("数据异常,请刷新后重新尝试!");
                        });
                    }
                })
            },
            save_scene: function () {
                var me = this;
                var data = {
                    sample_receive_scene: jQuery('#scene_depart').val(),
                    sample_receive_scene_role: jQuery('#scene_role').val()
                };
                if ((!data.sample_receive_scene) || (!data.sample_receive_scene_role)) {
                    jQuery.fn.error_msg("您尚未设置完整承接科室和负责岗位!");
                    return;
                }
                jQuery.fn.check_msg({
                    msg: "是否保存现场采样承接科室和岗位的设置?",
                    success: function () {
                        me.$http.post("/properties/setReceiveInfo", data).then(function (response) {
                            var data = response.data;
                            jQuery.fn.codeState(data.code, {
                                200: function () {
                                    jQuery.fn.alert_msg("承接科室设置成功!");
                                    me.load_prop();
                                }
                            })
                        }, function (response) {
                            jQuery.fn.error_msg("数据异常,请刷新后重新尝试!");
                        });
                    }
                })
            },
            load_prop: function () {
                var me = this;
                me.$http.get("/properties/getReceiveInfo").then(function (response) {
                    var data = response.data;
                    me.$set("sample_self", data.sample_self ? data.sample_self.name : "尚未设置");
                    me.$set("sample_scene", data.sample_scene ? data.sample_scene.name : "尚未设置");
                    me.$set("sample_self_role", data.sample_self_role ? data.sample_self_role.name : "尚未设置");
                    me.$set("sample_scene_role", data.sample_scene_role ? data.sample_scene_role.name : "尚未设置");
                }, function (response) {
                    jQuery.fn.error_msg("服务器异常,无法获取已设置信息,请刷新后重新尝试!");
                });
            }
        },
        ready: function () {
            var me = this;
            jQuery('#self_depart').select2({
                width: '100%',
                minimumResultsForSearch: -1
            }).on("change", function (event) {
                var id = event.val;
                me.$http.get("/role/getRoleByDepartment", {
                    params: {
                        id: id
                    }
                }).then(function (response) {
                    var data = response.data;
                    me.$set("self_role_list", data.results);
                }, function (response) {
                    jQuery.fn.error_msg("服务器异常,无法获取岗位列表信息,请刷新后重新尝试!");
                })
            });
            jQuery('#self_role').select2({
                width: '100%',
                minimumResultsForSearch: -1
            });
            jQuery('#scene_depart').select2({
                width: '100%',
                minimumResultsForSearch: -1
            }).on("change", function (event) {
                var id = event.val;
                me.$http.get("/role/getRoleByDepartment", {
                    params: {
                        id: id
                    }
                }).then(function (response) {
                    var data = response.data;
                    me.$set("scene_role_list", data.results);
                }, function (response) {
                    jQuery.fn.error_msg("服务器异常,无法获取岗位列表信息,请刷新后重新尝试!");
                })
            });
            jQuery('#scene_role').select2({
                width: '100%',
                minimumResultsForSearch: -1
            });

            me.$http.get("/department/getList").then(function (response) {
                var data = response.data;
                me.$set("department_list", data.results);
            }, function (response) {
                jQuery.fn.error_msg("服务器异常,无法获取部门列表信息,请刷新后重新尝试!");
            });
            me.load_prop();

        }
    });

</script>