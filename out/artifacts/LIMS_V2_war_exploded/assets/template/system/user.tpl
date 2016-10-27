<div class="row">
    <div class="col-md-12">
        <ul class="nav nav-tabs">
            <li class="active"><a href="#home" data-toggle="tab"><strong>搜索用户</strong></a></li>
            <li><a href="#add" data-toggle="tab"><strong>添加用户</strong></a></li>
            <li><a href="#about" data-toggle="tab"><strong>用户列表</strong></a></li>
            <li><a href="#basic" data-toggle="tab"><strong>基础设置</strong></a></li>
        </ul>
        <!-- Tab panes -->
        <div class="tab-content mb30">
            <div class="tab-pane active" id="home">

                <div class="row">
                    <div class="mb40"></div>
                    <div class="col-md-2"></div>
                    <div class="col-md-8 mb40">
                        <div class="input-group">
                            <input type="text" v-model="search_info" placeholder="请输入检索信息" class="form-control">
                            <div class="input-group-btn">
                                <button data-toggle="dropdown"
                                        class="btn btn-default dropdown-toggle"
                                        type="button">搜 索 <span class="caret"></span></button>
                                <ul class="dropdown-menu pull-right">
                                    <li><a href="javascript:;" @click="search('name')">姓名搜索</a></li>
                                    <li><a href="javascript:;" @click="search('username')">用户名搜索</a></li>
                                    <li><a href="javascript:;" @click="search('idCard')">证件号搜索</a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
            <div class="tab-pane " id="add">
                <div class="row">
                    <div class="col-md-12">
                        <form id="userAdd" class="form-horizontal">
                            <div class="form-group">
                                <label class="col-sm-2 control-label">用户名 <span
                                        class="asterisk">*</span></label>
                                <div class="col-sm-8">
                                    <input type="text" v-model="username" placeholder="用户名为用户的唯一登录凭证，由字母或数字组成。"
                                           class="form-control" name="username" required>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-2 control-label">姓名 <span
                                        class="asterisk">*</span></label>
                                <div class="col-sm-8">
                                    <input type="text" v-model="name" class="form-control" name="name" required>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">性别</label>
                                <div class="col-sm-8">
                                    <div class="rdio rdio-primary">
                                        <input type="radio" v-model="gender" name="radio" value="0" id="man" checked/>
                                        <label for="man">男</label>
                                    </div>
                                    <div class="rdio rdio-primary">
                                        <input type="radio" v-model="gender" name="radio" value="1" id="female"/>
                                        <label for="female">女</label>
                                    </div>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-2 control-label">证件号 <span
                                        class="asterisk">*</span></label>
                                <div class="col-sm-8">
                                    <input type="text" v-model="idCard" class="form-control" name="idCard" required>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">联系电话 <span
                                        class="asterisk">*</span></label>
                                <div class="col-sm-8">
                                    <input type="text" v-model="tel" class="form-control" name="tel" required>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">所属部门<span
                                        class="asterisk">*</span></label>
                                <div class="col-sm-8">
                                    <select class="select2" v-model="belong_department" id="depart_user_change"
                                            name="department_id" data-placeholder="请选择部门..." required>
                                        <option value=""></option>
                                        <template v-for="item in departments">
                                            <option value="{{item.id}}">{{item.name}}</option>
                                        </template>
                                    </select>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-2 control-label">所属角色<span
                                        class="asterisk">*</span></label>
                                <div class="col-sm-8">
                                    <select class="select2" v-model="belong_role" name="role_id" id="role_select"
                                            data-placeholder="请选择角色..." required>
                                        <option value=""></option>
                                        <template v-for="item in roles_add">
                                            <option value="{{item.id}}">{{item.name}}</option>
                                        </template>
                                    </select>

                                </div>
                            </div>


                            <div class="row">
                                <div class="col-sm-9 col-sm-offset-3">
                                    <a class="btn btn-primary" @click="add_user">保 存</a>
                                    <button type="reset" class="btn btn-default">清 空</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>

            </div>
            <div class="tab-pane" id="about">

                <div class="row">
                    <div class="col-md-9">
                        <div class="btn-demo" id="toolbar">
                            <div class="col-md-5">
                                <a class="btn btn-primary-alt select_all">全 选</a>
                                <a class="btn btn-default-alt select_no">反 选</a>
                                <a class="btn btn-warning-alt " @click="init_pwd">初始密码</a>
                                <a class="btn btn-danger-alt del_all_select" @click="del_user">删 除</a>
                            </div>
                            <div class="col-md-7 pull-right">
                                <div class="col-md-6">
                                    <select class="select2 depart_change" data-placeholder="请选择部门...">
                                        <option value=""></option>
                                        <template v-for="item in departments">
                                            <option value="{{item.id}}">{{item.name}}</option>
                                        </template>
                                    </select>
                                </div>
                                <div class="col-md-6">
                                    <select class="select2" id="role_change" data-placeholder="请选择角色...">
                                        <option value=""></option>
                                        <template v-for="item in roles">
                                            <option value="{{item.id}}">{{item.name}}</option>
                                        </template>
                                    </select>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="table-responsive">
                            <table class="table table-info  mb30 text-center">
                                <thead>
                                <tr>
                                    <th></th>
                                    <th class="text-center">编号</th>
                                    <th class="text-center">用户名</th>
                                    <th class="text-center">姓名</th>
                                    <th class="text-center">性别</th>
                                    <th class="text-center">联系电话</th>
                                    <th class="text-center">所属部门</th>
                                    <th class="text-center">所属角色</th>
                                    <th></th>
                                </tr>
                                </thead>
                                <tbody>
                                <template v-for="(index,item) in  user_list">
                                    <tr>
                                        <td class="text-center">
                                            <input type="checkbox" name="check"></td>
                                        <td>{{index+1}}</td>
                                        <td>{{item.username}}</td>
                                        <td>{{item.name}}</td>
                                        <td v-if="item.gender == 0">男</td>
                                        <td v-if="item.gender == 1">女</td>
                                        <td>{{item.tel}}</td>
                                        <td>{{item.role.department.name}}</td>
                                        <td>{{item.role.name}}</td>
                                        <td class="table-action text-center">
                                            <a href="javascript:;" data-toggle="modal"
                                               data-target=".bs-example-modal-static"
                                               @click="edit_user(item)"><i
                                                    class="fa fa-pencil"></i></a>
                                            <a href="javascript:;" class="delete-row"
                                               @click="del_item(roles)"><i
                                                    class="fa fa-trash-o "></i></a>
                                        </td>
                                    </tr>
                                </template>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <div class="paging nomargin pull-right"></div>
            </div>
            <div class="tab-pane" id="basic">

                <div class="row">
                    <div class="mb40"></div>
                    <div class="col-md-2"></div>
                    <div class="col-md-8 mb40">
                        <div class="input-group">
                            <input type="text" v-model="search_info" placeholder="请输入检索信息" class="form-control">
                            <div class="input-group-btn">
                                <button data-toggle="dropdown"
                                        class="btn btn-default dropdown-toggle"
                                        type="button">搜 索 <span class="caret"></span></button>
                                <ul class="dropdown-menu pull-right">
                                    <li><a href="javascript:;" @click="search('name')">姓名搜索</a></li>
                                    <li><a href="javascript:;" @click="search('username')">用户名搜索</a></li>
                                    <li><a href="javascript:;" @click="search('idCard')">证件号搜索</a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
</div>

<script type="text/javascript">

    var vue = new Vue({
        el: "#contentpanel",
        data: {
            search_info: "",
            departments: [],
            user_list: [],
            roles: [],
            roles_add: [],
            username: "",
            name: "",
            gender: "",
            idCard: "",
            tel: ""
        },
        methods: {
            search: function (type) {
                console.log(this.search_info);
                console.log(type);
                jQuery('a[href="#about"]').tab('show');
                this.search_info = "";

            },
            add_user: function () {
                var me = this;
                if (!jQuery('#userAdd').valid()) return;
                var data = {
                    username: me.username,
                    name: me.name,
                    gender: me.gender,
                    idCard: me.idCard,
                    tel: me.tel,
                    role_id: jQuery('#role_select').val()
                };
                console.log(data);

                me.$http.post("/user/add", data).then(function (response) {
                    var data = response.data;
                    jQuery.fn.codeState(data.code, {
                        200: function () {
                            jQuery.fn.alert_msg("用户新增成功!");
                        },
                        503: "当前用户名已经被使用！",
                        505: "当前证件号已经被使用,请使用用户名登录"
                    });
                }, function (response) {

                });
            },
            del_user: function () {

            },
            edit_user: function (data) {
                var template = jQuery.fn.loadTemplate("/assets/template/subject/user_addItem.tpl");
                Vue.component('edit_user_component' + data.id, {
                    template: template,
                    data: function () {
                        return {
                            departments: [],
                            roles: [],
                            username: data.username,
                            name: data.name,
                            sex: data.sex,
                            idCard: data.idCard,
                            tel: data.tel,
                            belong_role: data.belong_role,
                            belong_department: data.belong_department
                        };
                    },
                    methods: {
                        save: function () {
                            var me = this;
                            var data = JSON.parse(JSON.stringify(this._data));
                            console.log(data);
                            jQuery.fn.alert_msg("用户新增成功!");
                            me.checked_power = [];
                            jQuery("#custom_lg_modal").modal("hide");
                        },
                        clear: function () {
                            var me = this;
                            me.checked_power = [];
                            jQuery('input[name=select_all]').prop("checked", false);
                        }
                    },
                    ready: function () {
                        var dom = jQuery(this.$el);
                        dom.find('.select2').select2({
                            width: '100%',
                            minimumResultsForSearch: -1
                        });
                    }
                });
                LIMS.dialog.$set("title", "修改用户资料");
                LIMS.dialog.currentView = 'edit_user_component' + data.id;
            },
            init_pwd: function () {
                jQuery.fn.check_msg({
                    msg: "是否初始化选中用户的密码?",
                    success: function () {
                        jQuery.fn.alert_msg("密码初始化成功!");
                    }
                })
            },
            load_list: function (condition, currentPage) {
                var me = this;
                var dom = jQuery(me.$el);
                var rowCount = localStorage.getItem("rowCount") || 0;
                me.$http.get("/user/list", {
                    params: {
                        rowCount: rowCount,
                        currentPage: currentPage,
                        condition: condition
                    }
                }).then(function (response) {
                    var data = response.data;
                    me.$set("user_list", data.results);

                    //页码事件
                    dom.find('.paging').pagination({
                        pageCount: data.totalPage,
                        coping: true,
                        homePage: '首页',
                        endPage: '末页',
                        prevContent: '上页',
                        nextContent: '下页',
                        current: data.currentPage,
                        callback: function (page) {
                            var currentPage = page.getCurrent();
                            me.$http.get("/role/list", {
                                params: {
                                    rowCount: rowCount,
                                    currentPage: currentPage,
                                    condition: data.condition
                                }
                            }).then(function (response) {
                                var data = response.data;
                                me.$set("user_list", data.results);
                            }, function (response) {
                                jQuery.fn.error_msg("无法获取用户列表信息,请尝试刷新操作。");
                            });
                        }
                    });
                    jQuery.validator.setDefaults({
                        submitHandler: function () {
                        }
                    });
                }, function (response) {
                    jQuery.fn.error_msg("无法获取用户列表信息,请尝试刷新操作。");
                });
            }
        },
        ready: function () {
            var me = this;
            var dom = jQuery(this.$el);
            dom.find('.select2').select2({
                width: '100%',
                minimumResultsForSearch: -1
            });
            me.$http.get("/department/getList").then(function (response) {
                var data = response.data;
                me.$set("departments", data.results);
            }, function (response) {
                jQuery.fn.error_msg("无法获取部门列表信息,请尝试刷新操作。");
            });

            dom.find('.depart_change').on("change", function () {
                var id = this.value;
                me.$http.get("/role/getListByDepartment", {
                    params: {
                        department_id: id
                    }
                }).then(function (response) {
                    var data = response.data;
                    me.$set("roles", data.results);
                }, function (response) {
                    jQuery.fn.error_msg("无法获取岗位列表信息,请尝试刷新操作。");
                });
            });


            dom.find('#depart_user_change').on("change", function () {
                var id = this.value;
                me.$http.get("/role/getListByDepartment", {
                    params: {
                        department_id: id
                    }
                }).then(function (response) {
                    var data = response.data;
                    me.$set("roles_add", data.results);
                }, function (response) {
                    jQuery.fn.error_msg("无法获取岗位列表信息,请尝试刷新操作。");
                });
            });


            jQuery("#userAdd").validate({
                highlight: function (element) {
                    jQuery(element).closest('.form-group').removeClass('has-success').addClass('has-error');
                },
                success: function (element) {
                    jQuery(element).closest('.form-group').removeClass('has-error');
                }
            });



            me.load_list("",1);

//            me.$http.get("/assets/json/user_list.json").then(function (response) {
//                var data = response.data;
//                me.$set("user_list", data.results);
//                //页码事件
//                jQuery('.paging').pagination({
//                    pageCount: data.totalPage,
//                    coping: true,
//                    homePage: '首页',
//                    endPage: '末页',
//                    prevContent: '上页',
//                    nextContent: '下页',
//                    current: data.currentPage,
//                    callback: function (page) {
//                        console.log(page.getCurrent());
//                    }
//                });
//            }, function (response) {
//
//            });


        }
    });

</script>

