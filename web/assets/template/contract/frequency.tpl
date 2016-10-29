<div class="row">
    <div class="col-md-12">
        <div class="panel panel-default">
            <div class="panel-body">
                <div class="row">
                    <div class="col-md-9">
                        <div class="btn-demo" id="toolbar">
                            <a class="btn btn-info-alt" data-toggle="modal"
                               data-target=".bs-example-modal-static" @click="add_frequency">新
                                增</a>
                            <a class="btn btn-primary-alt" @click="select_all">全 选</a>
                            <a class="btn btn-default-alt select_no" @click="convert_all">反 选</a>
                            <a class="btn btn-danger-alt del_all_select" @click="del_frequency">删 除</a>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <input type="text" @keyup.enter="search" v-model="search_key" placeholder="搜索监测频次..."
                               id="serach"
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
                                    <th class="text-center">监测频次</th>
                                    <th class="text-center">操作</th>
                                </tr>
                                </tr>
                                </thead>
                                <tbody>
                                <template v-for="item in results">
                                    <tr>
                                        <td class="text-center">
                                            <input type="checkbox" value="{{item.id}}"
                                                   name="depart_check"></td>
                                        <td class="text-center">{{item.name}}</td>
                                        <td class="table-action text-center">
                                            <a href="javascript:;" data-toggle="modal"
                                               data-target=".bs-example-modal-static"
                                               @click="edit_item(item)"><i
                                                    class="fa fa-edit"></i></a>
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
                me.$http.get("/frequency/list", {
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
                        pageCount: data.totalPage != 0 ? data.totalPage : 1,
                        coping: true,
                        homePage: '首页',
                        endPage: '末页',
                        prevContent: '上页',
                        nextContent: '下页',
                        current: data.currentPage,
                        callback: function (page) {
                            var currentPage = page.getCurrent();
                            me.$http.get("/frequency/list", {
                                params: {
                                    rowCount: rowCount,
                                    currentPage: currentPage,
                                    condition: data.condition
                                }
                            }).then(function (response) {
                                var data = response.data;
                                me.$set("results", data.results);
                            }, function (response) {
                                jQuery.fn.error_msg("无法获取监测频次列表信息,请尝试刷新操作。");
                            });
                        }
                    });
                    jQuery.validator.setDefaults({
                        submitHandler: function () {
                        }
                    });
                }, function (response) {
                    jQuery.fn.error_msg("无法获取监测频次列表信息,请尝试刷新操作。");
                });

            },
            search: function (data) {
                var value = data.target.value;
                this.load_list("name=" + encodeURI(value), 1);
            },
            add_frequency: function () {
                var outer = this;
                var template = jQuery.fn.loadTemplate("/assets/template/subject/frequency_addItem.tpl");
                Vue.component('frequency_add_item', {
                    template: template,
                    data: function () {
                        return {
                            name: ""
                        };
                    },
                    methods: {
                        save: function () {
                            var me = this;
                            if (jQuery("#frequency_form").valid()) {
                                me.$http.post("/frequency/add", me._data).then(function (response) {
                                    var data = response.data;
                                    jQuery.fn.codeState(data.code, {
                                        200: function () {
                                            var currentPage = parseInt(jQuery('.paging span').html());
                                            var condition = outer.search_key == "" ? "" : "name=" + encodeURI(outer.search_key);
                                            outer.load_list(condition, currentPage);

                                            jQuery.fn.alert_msg("监测频次保存成功!");
                                            me.name = "";//清空表单
                                            jQuery("#custom_modal").modal("hide");
                                        }
                                    })
                                }, function (response) {
                                    jQuery.fn.error_msg("服务器数据异常!无法保存监测频次信息,请刷新后重新尝试。");
                                });
                            }
                        }
                    },
                    ready: function () {
                        var me = this;
                        var dom = jQuery(this.$el);
                        dom.find("#frequency_form").validate({
                            highlight: function (element) {
                                jQuery(element).closest('.form-group').removeClass('has-success').addClass('has-error');
                            },
                            success: function (element) {
                                jQuery(element).closest('.form-group').removeClass('has-error');
                            }
                        });
                    }
                });
                LIMS.dialog.$set('title', '新增监测频次');
                LIMS.dialog.currentView = 'frequency_add_item';
            },
            del_frequency: function () {
                var me = this;
                var selected = [];
                var oCheck = jQuery('input[name=depart_check]:checked');
                if (oCheck.length == 0) {
                    jQuery.fn.error_msg('至少需要选择一个监测频次！');
                    return;
                }
                oCheck.each(function (index, item) {
                    selected.push(item.value);
                });
                jQuery.fn.check_msg({
                    msg: '是否<span style="color: red;">删除</span>所有选中的监测频次？',
                    success: function () {
                        me.$http.post("/frequency/deleteAll", {
                            selected: selected
                        }).then(function (response) {
                            var data = response.data;
                            if (data.code == "200") {
                                var currentPage = parseInt(jQuery('.paging span').html());
                                var condition = me.search_key == "" ? "" : "name=" + encodeURI(me.search_key);
                                me.load_list(condition, currentPage);
                                jQuery.fn.alert_msg('所选监测频次删除成功！');
                            }
                            if (data.code == "503") {
                                var results = data.results;
                                var error_msg = "";
                                for (var i = 0; i < results.length; i++) {
                                    error_msg += results[i].client_unit + ",";
                                }
                                jQuery.fn.error_msg("数据异常,监测频次" + error_msg.substr(0, error_msg.length - 1) + "删除失败!");
                            }
                        }, function (response) {
                            jQuery.fn.error_msg("无法获取监测频次列表信息,请尝试刷新操作。");
                        });
                    }
                });
            },
            del_item: function (data) {
                var me = this;
                jQuery.fn.check_msg({
                    msg: '是否删除【<span style="color: red;">' + data.name + '</span>】？',
                    success: function () {
                        me.$http.post("/frequency/delete", {
                            id: data.id
                        }).then(function (response) {
                            var data = response.data;
                            jQuery.fn.codeState(data.code, {
                                200: function () {
                                    var currentPage = parseInt(jQuery('.paging span').html());
                                    var condition = me.search_key == "" ? "" : "name=" + encodeURI(me.search_key);
                                    me.load_list(condition, currentPage);
                                    jQuery.fn.alert_msg('监测频次删除成功！');
                                }
                            })
                        }, function (response) {
                            jQuery.fn.error_msg("无法获取监测频次列表信息,请尝试刷新操作。");
                        });
                    }
                });
            },
            edit_item: function (data) {
                var me = this;
                var index = data.id;
                var template = jQuery.fn.loadTemplate("/assets/template/subject/frequency_addItem.tpl");
                Vue.component('frequency_change_item' + index, {
                    template: template,
                    data: function () {
                        return {
                            id: data.id,
                            name: data.name
                        };
                    },
                    methods: {
                        save: function () {
                            var that = this;
                            var data = JSON.parse(JSON.stringify(that._data));
                            me.$http.post("/frequency/change", data).then(function (response) {
                                var data = response.data;
                                jQuery.fn.codeState(data.code, {
                                    200: function () {
                                        var currentPage = parseInt(jQuery('.paging span').html());
                                        var condition = me.search_key == "" ? "" : "name=" + encodeURI(me.search_key);
                                        me.load_list(condition, currentPage);
                                        jQuery.fn.alert_msg("监测频次修改成功!");
                                        jQuery("#custom_modal").modal("hide");
                                    }
                                });
                            }, function (response) {
                                jQuery.fn.error_msg("无法获取监测频次列表信息,请尝试刷新操作。");
                            });


                        }
                    }
                });
                LIMS.dialog.$set('title', '修改监测频次');
                LIMS.dialog.currentView = 'frequency_change_item' + index;
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


