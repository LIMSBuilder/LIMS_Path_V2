<div class="row">
    <div class="col-md-12">
        <div class="panel panel-default">
            <div class="panel-body">
                <div class="row">
                    <div class="col-md-9">
                        <div class="btn-demo" id="toolbar">
                            <a class="btn btn-info-alt" data-toggle="modal"
                               data-target=".bs-example-modal-static" @click="add_depart">新
                                增</a>
                            <a class="btn btn-primary-alt" @click="select_all">全 选</a>
                            <a class="btn btn-default-alt select_no" @click="convert_all">反 选</a>
                            <a class="btn btn-success-alt " @click="run_depart">启 用</a>
                            <a class="btn btn-warning-alt stop_all_select" @click="stop_depart">禁 用</a>
                            <a class="btn btn-danger-alt del_all_select" @click="del_depart">删 除</a>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <input type="text" @keyup.enter="search" v-model="search_key" placeholder="搜索内容..." id="serach"
                               class="form-control">
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="table-responsive">
                            <table class="table table-info table-hover mb30 text-center">
                                <thead>
                                <tr>
                                <tr>
                                    <th class="text-center"></th>
                                    <th class="text-center">编号</th>
                                    <th class="text-center">部门名称</th>
                                    <th class="text-center">当前状态</th>
                                    <th></th>
                                </tr>
                                </tr>
                                </thead>
                                <tbody>
                                <template v-for="item in results">
                                    <tr>
                                        <td class="text-center">
                                            <input type="checkbox" value="{{item.id}}"
                                                   name="depart_check"></td>
                                        <td class="text-center">{{item.id}}</td>
                                        <td class="text-center">{{item.name}}</td>
                                        <td class="text-center" v-if="item.state==0"><span class="label label-success">正常</span>
                                        </td>
                                        <td class="text-center" v-if="item.state==1"><span
                                                class="label label-warning">禁用</span></td>
                                        <td class="table-action text-center">
                                            <a href="javascript:;" data-toggle="modal"
                                               data-target=".bs-example-modal-static"
                                               @click="edit_item(item)"><i
                                                    class="fa fa-pencil"></i></a>
                                            <a href="javascript:;" v-if="item.state==1" @click="run_item(item)"><i
                                                    class="fa fa-eye "></i></a>
                                            <a href="javascript:;" v-if="item.state==0" @click="stop_item(item)"><i
                                                    class="fa fa-eye-slash "></i></a>
                                            <a href="javascript:;" class="delete-row" @click="del_item(item)"><i
                                                    class="fa fa-trash-o "></i></a>
                                        </td>
                                    </tr>
                                </template>
                                </tbody>
                            </table>
                        </div><!-- table-responsive -->
                    </div><!-- col-md-12 -->
                    <div class="paging nomargin pull-right"></div>
                </div>
            </div>
        </div>
    </div>
</div>


<script type="text/javascript">

    var vue = new Vue({
        el: "#contentpanel",
        data: {
            "results": [],
            search_key: ""
        },
        methods: {
            load_list: function (condition, currentPage) {
                var me = this;
                var dom = jQuery(me.$el);
                var rowCount = localStorage.getItem("rowCount") || 0;
                //获取department列表
                me.$http.get("/department/list", {
                    params: {
                        rowCount: rowCount,
                        currentPage: currentPage,
                        condition: condition
                    }
                }).then(function (response) {
                    var data = response.data;
                    for (var key in data) {
                        if (me[key] != undefined) {
                            me.$set(key, data[key]);
                        }
                    }
                    //页码事件
                    dom.find('.paging').pagination({
                        pageCount: data.totalPage != 0 ? data.totalPage : 1,
                        coping: true,
                        homePage: '首页',
                        endPage: '末页',
                        prevContent: '上页',
                        nextContent: '下页',
                        current: data.currentPage,
                        callback: function (page) {
                            var currentPage = page.getCurrent();
                            me.$http.get("/department/list", {
                                params: {
                                    rowCount: rowCount,
                                    currentPage: currentPage,
                                    condition: data.condition
                                }
                            }).then(function (response) {
                                var data = response.data;
                                me.$set("results", data.results);
                            }, function (response) {
                                jQuery.fn.error_msg("无法获取部门列表信息,请尝试刷新操作。");
                            });
                        }
                    });
                    jQuery.validator.setDefaults({
                        submitHandler: function () {
                        }
                    });
                }, function (response) {
                    jQuery.fn.error_msg("无法获取部门列表信息,请尝试刷新操作。");
                });

            },
            search: function (data) {
                var value = data.target.value;
                this.load_list("name=" + encodeURI(value), 1);
            },
            add_depart: function () {
                var outer = this;
                var template = jQuery.fn.loadTemplate("/assets/template/subject/department_addItem.tpl");
                Vue.component('depart_add_item', {
                    template: template,
                    data: function () {
                        return {
                            name: ""
                        };
                    },
                    methods: {
                        save: function () {
                            var me = this;
                            if (me.$get("name") == "") {
                                jQuery.fn.error_msg("部门名称不能为空!");
                                return;
                            }

                            me.$http.post("/department/add", me._data).then(function (response) {
                                var data = response.data;
                                if (data.code == "200") {
                                    var currentPage = parseInt(jQuery('.paging span').html());
                                    var condition = outer.search_key == "" ? "" : "name=" + encodeURI(outer.search_key);
                                    outer.load_list(condition, currentPage);
                                    jQuery.fn.alert_msg("新部门创建成功!");
                                    me.$set("name", "");

                                }
                                if (data.code == "502") {
                                    jQuery.fn.error_msg("服务器数据异常!无法保存部门信息,请刷新后重新尝试。");
                                }
                                if (data.code == "503") {
                                    jQuery.fn.error_msg("当前已经存在同名部门,请修改部门名称。");
                                }
                            }, function (response) {
                                jQuery.fn.error_msg("服务器数据异常!无法保存部门信息,请刷新后重新尝试。");
                            });
                        }
                    }
                });
                LIMS.dialog.$set('title', '创建部门');
                LIMS.dialog.currentView = 'depart_add_item';
            },
            run_depart: function () {
                var me = this;
                var selected = [];
                var oCheck = jQuery('input[name=depart_check]:checked');
                if (oCheck.length == 0) {
                    jQuery.fn.error_msg('至少需要选择一个部门！');
                    return;
                }
                oCheck.each(function (index, item) {
                    selected.push(item.value);
                });
                jQuery.fn.check_msg({
                    msg: '是否<span style="color: #1CAF9A;">启用</span>所有选中的部门？',
                    success: function () {
                        me.$http.post("/department/changeStateAll", {
                            selected: selected,
                            type: 0
                        }).then(function (response) {
                            var data = response.data;
                            if (data.code == "200") {
                                var currentPage = parseInt(jQuery('.paging span').html());
                                var condition = me.search_key == "" ? "" : "name=" + encodeURI(me.search_key);
                                me.load_list(condition, currentPage);
                                jQuery.fn.alert_msg('所选部门启用成功！');
                            }
                            if (data.code == "503") {
                                var results = data.results;
                                var error_msg = "";
                                for (var i = 0; i < results.length; i++) {
                                    error_msg += results[i].name + ",";
                                }
                                jQuery.fn.error_msg("数据异常,部门" + error_msg.substr(0, error_msg.length - 1) + "启用失败!");
                            }
                        }, function (response) {
                            jQuery.fn.error_msg("无法获取部门列表信息,请尝试刷新操作。");
                        });
                    }
                });
            },
            stop_depart: function () {
                var me = this;
                var selected = [];
                var oCheck = jQuery('input[name=depart_check]:checked');
                if (oCheck.length == 0) {
                    jQuery.fn.error_msg('至少需要选择一个部门！');
                    return;
                }
                oCheck.each(function (index, item) {
                    selected.push(item.value);
                });
                jQuery.fn.check_msg({
                    msg: '是否<span style="color: #f0ad4e;">禁用</span>所有选中的部门？',
                    success: function () {
                        me.$http.post("/department/changeStateAll", {
                            selected: selected,
                            type: 1
                        }).then(function (response) {
                            var data = response.data;
                            if (data.code == "200") {
                                var currentPage = parseInt(jQuery('.paging span').html());
                                var condition = me.search_key == "" ? "" : "name=" + encodeURI(me.search_key);
                                me.load_list(condition, currentPage);
                                jQuery.fn.alert_msg('所选部门禁用成功！');
                            }
                            if (data.code == "503") {
                                var results = data.results;
                                var error_msg = "";
                                for (var i = 0; i < results.length; i++) {
                                    error_msg += results[i].name + ",";
                                }
                                jQuery.fn.error_msg("数据异常,部门" + error_msg.substr(0, error_msg.length - 1) + "禁用失败!");
                            }
                        }, function (response) {
                            jQuery.fn.error_msg("无法获取部门列表信息,请尝试刷新操作。");
                        });
                    }
                });
            },
            del_depart: function () {
                var me = this;
                var selected = [];
                var oCheck = jQuery('input[name=depart_check]:checked');
                if (oCheck.length == 0) {
                    jQuery.fn.error_msg('至少需要选择一个部门！');
                    return;
                }
                oCheck.each(function (index, item) {
                    selected.push(item.value);
                });
                jQuery.fn.check_msg({
                    msg: '是否<span style="color: red;">删除</span>所有选中的部门？',
                    success: function () {
                        me.$http.post("/department/changeStateAll", {
                            selected: selected,
                            type: 2
                        }).then(function (response) {
                            var data = response.data;
                            if (data.code == "200") {
                                var currentPage = parseInt(jQuery('.paging span').html());
                                var condition = me.search_key == "" ? "" : "name=" + encodeURI(me.search_key);
                                me.load_list(condition, currentPage);
                                jQuery.fn.alert_msg('所选部门删除成功！');
                            }
                            if (data.code == "503") {
                                var results = data.results;
                                var error_msg = "";
                                for (var i = 0; i < results.length; i++) {
                                    error_msg += results[i].name + ",";
                                }
                                jQuery.fn.error_msg("数据异常,部门" + error_msg.substr(0, error_msg.length - 1) + "删除失败!");
                            }
                        }, function (response) {
                            jQuery.fn.error_msg("无法获取部门列表信息,请尝试刷新操作。");
                        });
                    }
                });
            },
            run_item: function (data) {
                var me = this;
                jQuery.fn.check_msg({
                    msg: '是否<span style="color: #1CAF9A;">启用</span>该部门？',
                    success: function () {
                        me.$http.post("/department/chagneState", {
                            id: data.id,
                            type: 0
                        }).then(function (response) {
                            var data = response.data;
                            jQuery.fn.codeState(data.code, {
                                200: function () {
                                    var currentPage = parseInt(jQuery('.paging span').html());
                                    var condition = me.search_key == "" ? "" : "name=" + encodeURI(me.search_key);
                                    me.load_list(condition, currentPage);
                                    jQuery.fn.alert_msg('部门启用成功！');
                                }
                            })
                        }, function (response) {
                            jQuery.fn.error_msg("无法获取部门列表信息,请尝试刷新操作。");
                        });
                    }
                });
            },
            stop_item: function (data) {
                var me = this;
                jQuery.fn.check_msg({
                    msg: '是否禁用【<span style="color: #f0ad4e;">' + data.name + '</span>】？，该部门的员工将无法登陆！',
                    success: function () {
                        me.$http.post("/department/chagneState", {
                            id: data.id,
                            type: 1
                        }).then(function (response) {
                            var data = response.data;
                            jQuery.fn.codeState(data.code, {
                                200: function () {
                                    var currentPage = parseInt(jQuery('.paging span').html());
                                    var condition = me.search_key == "" ? "" : "name=" + encodeURI(me.search_key);
                                    me.load_list(condition, currentPage);
                                    jQuery.fn.alert_msg('部门禁用成功！');
                                }
                            })
                        }, function (response) {
                            jQuery.fn.error_msg("无法获取部门列表信息,请尝试刷新操作。");
                        });
                    }
                });
            },
            del_item: function (data) {
                var me = this;
                jQuery.fn.check_msg({
                    msg: '是否删除【<span style="color: red;">' + data.name + '</span>】？，删除部门将清空该部门的员工信息！',
                    success: function () {
                        me.$http.post("/department/chagneState", {
                            id: data.id,
                            type: 2
                        }).then(function (response) {
                            var data = response.data;
                            jQuery.fn.codeState(data.code, {
                                200: function () {
                                    var currentPage = parseInt(jQuery('.paging span').html());
                                    var condition = me.search_key == "" ? "" : "name=" + encodeURI(me.search_key);
                                    me.load_list(condition, currentPage);
                                    jQuery.fn.alert_msg('部门删除成功！');
                                }
                            })
                        }, function (response) {
                            jQuery.fn.error_msg("无法获取部门列表信息,请尝试刷新操作。");
                        });
                    }
                });
            },
            edit_item: function (data) {
                var me = this;
                var index = data.id;
                var template = jQuery.fn.loadTemplate("/assets/template/subject/department_addItem.tpl");
                Vue.component('depart_change_item' + index, {
                    template: template,
                    data: function () {
                        return {
                            name: data.name
                        };
                    },
                    methods: {
                        save: function () {
                            var that = this;
                            var data = JSON.parse(JSON.stringify(this._data));
                            for (var i = 0; i < me.results.length; i++) {
                                var item = me.results[i];
                                if (item.id == index) {
                                    item.name = data.name;
                                }
                            }
                            me.$http.post("/department/change", {
                                id: index,
                                name: that.name
                            }).then(function (response) {
                                var data = response.data;
                                jQuery.fn.codeState(data.code, {
                                    200: function () {
                                        jQuery.fn.alert_msg("部门信息修改成功!");
                                        jQuery("#custom_modal").modal("hide");
                                    }
                                });
                            }, function (response) {
                                jQuery.fn.error_msg("无法获取部门列表信息,请尝试刷新操作。");
                            });


                        }
                    }
                });
                LIMS.dialog.$set('title', '修改部门信息');
                LIMS.dialog.currentView = 'depart_change_item' + index;
            },
            convert_all: function () {
                //反选操作
                jQuery.fn.select_all("depart_check", "other");
            },
            select_all: function () {
                //全选操作
                jQuery.fn.select_all("depart_check", "all");
            }
        },
        ready: function () {
            this.load_list("", 1);
        }
    })

</script>


