<div class="row">
    <div class="col-md-12">
        <div class="panel panel-default">
            <div class="panel-body">
                <ul class="nav nav-tabs">
                    <li class="active"><a href="#home" data-toggle="tab"><strong>搜索用户</strong></a></li>
                    <li><a href="#about" data-toggle="tab"><strong>用户列表</strong></a></li>
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
                    <div class="tab-pane" id="about">

                        <div class="row">
                            <div class="col-md-9">
                                <div class="btn-demo" id="toolbar">
                                    <div class="col-md-5">
                                        <a class="btn btn-info-alt" data-toggle="modal"
                                           data-target=".bs-example-modal-static" @click="add_user">新
                                            增</a>
                                        <a class="btn btn-primary-alt select_all">全 选</a>
                                        <a class="btn btn-default-alt select_no">反 选</a>
                                        <a class="btn btn-warning-alt " @click="init_pwd">初始密码</a>
                                        <a class="btn btn-danger-alt del_all_select" @click="del_user">删 除</a>
                                    </div>
                                    <div class="col-md-7 pull-right">
                                        <div class="col-md-6">
                                            <select class="select2" id="depart_change" data-placeholder="请选择部门...">
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
                                                <td>{{item.sex}}</td>
                                                <td>{{item.tel}}</td>
                                                <td>{{item.department_name}}</td>
                                                <td>{{item.role_name}}</td>
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
                </div>


            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    //新增用户信息的组件


    var vue = new Vue({
        el: "#contentpanel",
        data: {
            search_info: "",
            departments: [],
            user_list: [],
            roles: []
        },
        methods: {
            search: function (type) {
                console.log(this.search_info);
                console.log(type);
                jQuery('a[href="#about"]').tab('show');
                this.search_info = "";

            },
            add_user: function () {

                var template = jQuery.fn.loadTemplate("/assets/template/subject/user_addItem.tpl");
                var add_component = Vue.component('add_user_component', {
                    template: template,
                    data: function () {
                        return {
                            departments: [],
                            roles: [],
                            username: "",
                            name: "",
                            sex: "",
                            idCard: "",
                            tel: "",
                            belong_role: 0,
                            belong_department: 0
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
                LIMS.dialog.$set("title", "添加用户资料");
                LIMS.dialog.currentView = 'add_user_component';
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
            }
        },
        ready: function () {
            var me = this;
            var dom = jQuery(this.$el);
            me.$http.get("/assets/json/department_list.json").then(function (response) {
                var data = response.data;
                me.$set("departments", data.results);

            }, function (response) {

            });


            me.$http.get("/assets/json/user_list.json").then(function (response) {
                var data = response.data;
                me.$set("user_list", data.results);
                //页码事件
                jQuery('.paging').pagination({
                    pageCount: data.totalPage,
                    coping: true,
                    homePage: '首页',
                    endPage: '末页',
                    prevContent: '上页',
                    nextContent: '下页',
                    current: data.currentPage,
                    callback: function (page) {
                        console.log(page.getCurrent());
                    }
                });
            }, function (response) {

            })

            jQuery('.select2').select2({
                width: '100%',
                minimumResultsForSearch: -1
            });


            jQuery('#depart_change').on("change", function () {
                var id = this.value;
                me.$http.get("/assets/json/role_result.json").then(function (response) {
                    var data = response.data;
                    me.$set("roles", data.role);

                }, function (response) {

                })
            });


        }
    });

</script>

