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
                            <a class="btn btn-primary-alt select_all">全 选</a>
                            <a class="btn btn-default-alt select_no">反 选</a>
                            <a class="btn btn-success-alt " @click="run_depart">启 用</a>
                            <a class="btn btn-warning-alt stop_all_select" @click="stop_depart">禁 用</a>
                            <a class="btn btn-danger-alt del_all_select" @click="del_depart">删 除</a>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <input type="text" placeholder="搜索内容..." id="serach" class="form-control">
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
                                            <input type="checkbox" name="check"></td>
                                        <td class="text-center">{{item.id}}</td>
                                        <td class="text-center">{{item.name}}</td>
                                        <td class="text-center" v-if="item.state==0"><span class="label label-success">正常</span>
                                        </td>
                                        <td class="text-center" v-if="item.state==1"><span
                                                class="label label-danger">禁用</span></td>
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
            "results": []
        },
        methods: {
            add_depart: function () {
                var me = this;
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
                            var data = JSON.parse(JSON.stringify(this._data));
                            jQuery.fn.alert_msg("部门信息保存成功!");
                        }
                    }
                });
                LIMS.dialog.$set('title', '创建部门');
                LIMS.dialog.currentView = 'depart_add_item';
            },
            run_depart: function () {
                jQuery.fn.check_msg({
                    msg: '是否<span style="color: #1CAF9A;">启用</span>所有选中的部门？',
                    success: function () {
                        jQuery.fn.alert_msg('所选部门启用成功！');
                    }
                });
            },
            stop_depart: function () {
                jQuery.fn.check_msg({
                    msg: '是否<span style="color: #f0ad4e;">禁用</span>所有选中的部门？',
                    success: function () {
                        jQuery.fn.alert_msg('所选部门禁用成功！');
                    }
                });
            },
            del_depart: function () {
                jQuery.fn.check_msg({
                    msg: '是否<span style="color: red;">删除</span>所有选中的部门？',
                    success: function () {
                        jQuery.fn.alert_msg('所选部门删除成功！');
                    }
                });
            },
            run_item: function (data) {
                jQuery.fn.check_msg({
                    msg: '是否<span style="color: #1CAF9A;">启用</span>该部门？',
                    success: function () {
                        jQuery.fn.alert_msg('部门启用成功！');
                    }
                });
            },
            stop_item: function (data) {
                jQuery.fn.check_msg({
                    msg: '是否禁用【<span style="color: #f0ad4e;">' + data.name + '</span>】？，该部门的员工将无法登陆！',
                    success: function () {
                        jQuery.fn.alert_msg('部门禁用成功！');
                    }
                });
            },
            del_item: function (data) {
                jQuery.fn.check_msg({
                    msg: '是否删除【<span style="color: red;">' + data.name + '</span>】？，删除部门将清空该部门的员工信息！',
                    success: function () {
                        jQuery.fn.alert_msg('该部门删除成功！');
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
                            var data = JSON.parse(JSON.stringify(this._data));
                            for (var i = 0; i < me.results.length; i++) {
                                var item = me.results[i];
                                if (item.id == index) {
                                    item.name = data.name;
                                }
                            }
                            jQuery.fn.alert_msg("部门信息修改成功!");
                            jQuery("#custom_modal").modal("hide");
                        }
                    }
                });
                LIMS.dialog.$set('title', '修改部门信息');
                LIMS.dialog.currentView = 'depart_change_item' + index;
            }
        },
        ready: function () {
            var me = this;
            var dom = jQuery(me.$el);
            var rowCount = localStorage.getItem("rowCount") || 0;

            //获取department列表
            me.$http.get("/department/list", {
                params: {
                    rowCount: rowCount,
                    currentPage: 1,
                    condition: ""
                }
            }).then(function (response) {
                var data = response.data;
                for (var key in data) {
                    if (me[key] != undefined) {
                        me.$set(key, data[key]);
                    }
                }
                //搜索框事件
                dom.find("#serach").keyup(function () {
                    if (event.keyCode == 13) {
                        var data = jQuery(this).val();
                        me.$http.get("/department/list", {
                            params: {
                                rowCount: rowCount,
                                currentPage: 1,
                                condition: "name=" + encodeURI(data)
                            }
                        }).then(function (response) {
                            var data = response.data;
                            me.$set("results", data.results);
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
                        }, function (response) {
                            jQuery.fn.error_msg("无法获取部门列表信息,请尝试刷新操作。");
                        });
                    }
                });
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
        }
    })

</script>


