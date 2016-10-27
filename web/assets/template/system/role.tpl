<div class="row">
    <div class="col-md-12">
        <div class="panel panel-default">
            <div class="panel-body">
                <div class="row">
                    <div class="col-md-12">
                        <div class="btn-demo">
                            <a class="btn btn-info-alt" data-toggle="modal"
                               data-target=".bs-example-modal-static" @click="add_role">新
                                增</a>
                            <a class="btn btn-primary-alt" @click="select_all">全 选</a>
                            <a class="btn btn-default-alt select_no" @click="convert_all">反 选</a>
                            <a class="btn btn-success-alt" data-toggle="modal"
                               data-target=".bs-example-modal-static" @click="power_role">权限控制</a>
                            <a class="btn btn-danger-alt del_all_select" @click="del_role">删 除</a>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="form-group">
                            <select class="select2" id="depart_change" data-placeholder="请选择部门...">
                                <option value=""></option>
                                <option value="0">全部</option>
                                <template v-for="item in departments">
                                    <option value="{{item.id}}">{{item.name}}</option>
                                </template>
                            </select>
                        </div>

                    </div>

                    <div class="col-md-3 pull-right">
                        <div class="form-group">
                            <input type="text" @keyup.enter="search" placeholder="搜索角色..." v-model="search_key"
                                   id="serach"
                                   class="form-control">
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="table-responsive">
                            <table class="table table-info  mb30 text-center">
                                <thead>
                                <tr>
                                    <th class="text-center"></th>
                                    <th class="text-center">角色名称</th>
                                    <th class="text-center">所属部门</th>
                                    <th></th>
                                </tr>
                                </thead>
                                <tbody>
                                <template v-for="item in  results">
                                    <tr>
                                        <td><input value="{{item.id}}" name="role_check" type="checkbox"></td>
                                        <td>{{item.name}}</td>
                                        <td>{{item.department.name}}</td>
                                        <td class="table-action text-center">
                                            <a href="javascript:;" data-toggle="modal"
                                               data-target=".bs-example-modal-static"
                                               @click="edit_item(item)"><i
                                                    class="fa fa-pencil"></i></a>
                                            <a href="javascript:;" data-toggle="modal"
                                               data-target=".bs-example-modal-lg"
                                               @click="power_item(roles)"><i
                                                    class="fa fa-sign-in"></i></a>
                                            <a href="javascript:;" class="delete-row" @click="del_item(item)"><i
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
<script type="text/javascript">

    var vue = new Vue({
        el: "#contentpanel",
        data: {
            results: [],
            departments: [],
            search_key: ""
        },
        methods: {
            add_role: function () {
                var me = this;
                var template = jQuery.fn.loadTemplate("/assets/template/subject/role_addItem.tpl");
                Vue.component('depart_add_item', {
                    template: template,
                    data: function () {
                        return {
                            depart_list: me.departments,
                            name: "",
                            belong_depart: 0
                        };
                    },
                    methods: {
                        save: function () {
                            var outer = this;
                            var data = {
                                department_id: jQuery('#choose_depart').val(),
                                name: outer.name
                            };
                            me.$http.post("/role/add", data).then(function (response) {
                                var data = response.data;
                                jQuery.fn.codeState(data.code, {
                                    200: function () {
                                        var currentPage = parseInt(jQuery('.paging span').html());
                                        var condition = me.search_key == "" ? "" : "name=" + encodeURI(outer.search_key);
                                        me.load_list(condition, currentPage);
                                        jQuery.fn.alert_msg("岗位创建成功!");
                                        outer.$set("name", "");
                                    }
                                });
                            }, function (response) {
                                jQuery.fn.error_msg("服务器数据异常!无法保存岗位信息,请刷新后重新尝试。");
                            });
                        }
                    },
                    ready: function () {
                        var dom = jQuery(this.$el);
                        dom.find('#choose_depart').select2({
                            width: '100%',
                            minimumResultsForSearch: -1
                        });
                    }
                });
                LIMS.dialog.$set('title', '创建岗位');
                LIMS.dialog.currentView = 'depart_add_item';
            },
            power_role: function () {

            },
            del_role: function (data) {
                var me = this;
                var selected = [];
                var oCheck = jQuery('input[name=role_check]:checked');
                if (oCheck.length == 0) {
                    jQuery.fn.error_msg('至少需要选择一个岗位！');
                    return;
                }
                oCheck.each(function (index, item) {
                    selected.push(item.value);
                });
                jQuery.fn.check_msg({
                    msg: '是否<span style="color: red;">删除</span>所有选中的岗位？',
                    success: function () {
                        me.$http.post("/role/changeStateAll", {
                            selected: selected,
                            type: 1
                        }).then(function (response) {
                            var data = response.data;
                            if (data.code == "200") {
                                var currentPage = parseInt(jQuery('.paging span').html());
                                var condition = me.search_key == "" ? "" : "name=" + encodeURI(me.search_key);
                                me.load_list(condition, currentPage);
                                jQuery.fn.alert_msg('所选岗位删除成功！');
                            }
                            if (data.code == "503") {
                                var results = data.results;
                                var error_msg = "";
                                for (var i = 0; i < results.length; i++) {
                                    error_msg += results[i].name + ",";
                                }
                                jQuery.fn.error_msg("数据异常,岗位" + error_msg.substr(0, error_msg.length - 1) + "删除失败!");
                            }
                        }, function (response) {
                            jQuery.fn.error_msg("无法获取岗位列表信息,请尝试刷新操作。");
                        });
                    }
                });
            },
            del_item: function (data) {
                var me = this;
                jQuery.fn.check_msg({
                    msg: '是否删除【<span style="color: red;">' + data.name + '</span>】？，删除角色将清空该部门的员工信息！',
                    success: function () {
                        me.$http.post("/role/chagneState", {
                            id: data.id,
                            type: 1
                        }).then(function (response) {
                            var data = response.data;
                            jQuery.fn.codeState(data.code, {
                                200: function () {
                                    var currentPage = parseInt(jQuery('.paging span').html());
                                    var condition = me.search_key == "" ? "" : "name=" + encodeURI(me.search_key);
                                    me.load_list(condition, currentPage);
                                    jQuery.fn.alert_msg('岗位删除成功！');
                                }
                            })
                        }, function (response) {
                            jQuery.fn.error_msg("无法获取岗位列表信息,请尝试刷新操作。");
                        });
                    }
                });
            },
            edit_item: function (data) {
                var me = this;
                var index = data.id;
                var template = jQuery.fn.loadTemplate("/assets/template/subject/role_addItem.tpl");

                Vue.component('depart_change_item' + index, {
                    template: template,
                    data: function () {
                        return {
                            name: data.name,
                            depart_list: me.departments,
                            belong_depart: data.department.id
                        };
                    },
                    methods: {
                        save: function () {
                            var data = {
                                id: index,
                                name: this.name,
                                department_id: jQuery('#choose_depart').val()
                            };

                            me.$http.post("/role/change", data).then(function (response) {
                                var data = response.data;
                                jQuery.fn.codeState(data.code, {
                                    200: function () {
                                        var currentPage = parseInt(jQuery('.paging span').html());
                                        var condition = me.search_key == "" ? "" : "name=" + encodeURI(me.search_key);
                                        me.load_list(condition, currentPage);
                                        jQuery.fn.alert_msg("岗位修改成功!");
                                        jQuery("#custom_modal").modal("hide");
                                    }
                                });
                            }, function (response) {
                                jQuery.fn.error_msg("服务器数据异常!无法保存岗位信息,请刷新后重新尝试。");
                            });

                        }
                    },
                    ready: function () {
                        var dom = jQuery(this.$el);
                        dom.find('#choose_depart').select2({
                            width: '100%',
                            minimumResultsForSearch: -1
                        });


                    }
                });
                LIMS.dialog.$set('title', '修改部门信息');
                LIMS.dialog.currentView = 'depart_change_item' + index;
            },
            power_item: function (data) {
                var me = this, index = data.id;
                me.$http.get("/assets/json/power.json").then(function (response) {
                    var results = response.data;
                    var template = jQuery.fn.loadTemplate("/assets/template/subject/power.tpl");
                    Vue.component('power' + index, {
                        template: template,
                        data: function () {
                            return {
                                power_list: results.results,
                                checked_power: []
                            };
                        },
                        methods: {
                            save: function () {
                                var me = this;
                                var data = JSON.parse(JSON.stringify(this._data));
                                //此处发送一个请求给后端,返回之后处理下方代码
                                console.log(data);
                                jQuery.fn.alert_msg("权限设置成功!");
                                me.checked_power = [];
                                jQuery("#custom_lg_modal").modal("hide");
                            },
                            clear: function () {
                                var me = this;
                                me.checked_power = [];
                                jQuery('input[name=select_all]').prop("checked", false);
                            },
                            choose_all: function () {
                                var me = this;
                                if (event.target.checked) {
                                    jQuery(event.target).parents('tr').siblings('tr').find('input[type=checkbox]').each(function (index, item) {
                                        var index = item.value;
                                        me.checked_power.push(index);
                                    })
                                }
                            }
                        },
                        ready: function () {
                        }
                    });
                    LIMS.dialog_lg.$set('title', '为“' + data.name + "”设置权限");
                    LIMS.dialog_lg.currentView = 'power' + index;
                }, function (response) {

                });


            },

            search: function (data) {
                var value = data.target.value;
                this.load_list("name=" + encodeURI(value), 1);
            },
            load_list: function (condition, currentPage) {
                var me = this;
                var dom = jQuery(me.$el);
                var rowCount = localStorage.getItem("rowCount") || 0;
                me.$http.get("/role/list", {
                    params: {
                        rowCount: rowCount,
                        currentPage: currentPage,
                        condition: condition
                    }
                }).then(function (response) {
                    var data = response.data;
                    me.$set("results", data.results);

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
                                me.$set("results", data.results);
                            }, function (response) {
                                jQuery.fn.error_msg("无法获取岗位列表信息,请尝试刷新操作。");
                            });
                        }
                    });
                    jQuery.validator.setDefaults({
                        submitHandler: function () {
                        }
                    });
                }, function (response) {
                    jQuery.fn.error_msg("无法获取岗位列表信息,请尝试刷新操作。");
                });
            }, convert_all: function () {
                //反选操作
                jQuery.fn.select_all("role_check", "other");
            },
            select_all: function () {
                //全选操作
                jQuery.fn.select_all("role_check", "all");
            }
        },
        ready: function () {
            var me = this;
            var dom = jQuery(me.$el);
            me.$http.get("/department/getList").then(function (response) {
                var data = response.data;
                me.$set("departments", data.results);
            }, function (response) {
                jQuery.fn.error_msg("无法获取部门列表信息,请尝试刷新操作。");
            });
            this.load_list("", 1);
            dom.find('.select2').select2({
                width: '100%',
                minimumResultsForSearch: -1
            });

            dom.find("#depart_change").on("change", function (data) {
                var id = data.val;
                if (id == 0) {
                    me.load_list("", 1);
                } else {
                    me.load_list("department_id=" + encodeURI(id), 1);
                }

            })
        }

    });
</script>