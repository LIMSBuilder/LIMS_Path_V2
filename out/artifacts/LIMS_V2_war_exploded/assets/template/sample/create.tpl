<div class="panel panel-default">
    <div class="panel-body">
        <div class="row">
            <div class="col-sm-12 col-md-12">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <div class="paging nomargin pull-right"></div>
                        <h4 class="panel-title">待登记任务书</h4>
                    </div><!-- panel-heading -->
                    <div class="panel-body">
                        <div class="results-list">
                            <template v-for="result in result_list">
                                <div class="media">
                                    <a href="javascript:;" class="pull-left">
                                        <img alt="" src="/assets/images/photos/contract.png" class="media-object">
                                    </a>
                                    <div class="media-body">
                                        <div class="btn-demo pull-right">
                                            <a class="btn btn-info-alt" data-toggle="modal"
                                               data-target=".bs-example-modal-lg"
                                               @click="create_sample(result)">样品登记</a>
                                            <a class="btn btn-default-alt" data-toggle="modal"
                                               data-target=".bs-example-modal-lg" @click="view_info(result)">查看详情</a>
                                        </div>
                                        <h4 class="filename text-primary">{{result.project_name}}</h4>
                                        <small class="text-muted">合同编号: {{result.identify}}</small>
                                        <br/>
                                        <small class="text-muted">承接科室: {{result.receive_deparment.name}}</small>
                                        <br/>
                                        <small class="text-muted">创建时间: {{result.create_time}}</small>
                                        <br/>
                                        <small class="text-muted">客户单位: {{result.client_unit}}</small>
                                    </div>
                                </div>

                            </template>

                        </div><!-- results-list -->
                    </div><!-- panel-body -->
                </div><!-- panel -->
            </div><!-- col-sm-8 -->
        </div>
    </div>
</div>
<script>
    jQuery(document).ready(function () {
        "use strict";
        var vue = new Vue({
            el: '#contentpanel',
            data: function () {
                return {
                    result_list: []//结果集
                }
            },
            methods: {
                create_sample: function (task) {
                    var me = this;
                    var id = task.id;
                    me.$http.get("/task/getById", {
                        params: {
                            id: id
                        }
                    }).then(function (response) {
                        var data = response.data;
                        var template = jQuery.fn.loadTemplate("/assets/template/subject/create_sample.tpl");
                        Vue.component('create_sample' + id, {
                            template: template,
                            data: function () {
                                return {
                                    id: "",
                                    identify: "",
                                    isChange: false,//是否修改
                                    name: "",
                                    feature: "",
                                    condition: "",
                                    color: "",
                                    projects: "",
                                    sample_list: [],
                                    projectList: []
                                };
                            },
                            methods: {
                                add: function () {
                                    var me = this;
                                    var data = {
                                        id: id,
                                        name: me.name,
                                        feature: me.feature,
                                        condition: me.condition,
                                        color: me.color,
                                        projects: me.projects
                                    };


                                    me.$http.post("/sample/addItem", data).then(function (response) {
                                        var data = response.data;
                                        jQuery.fn.codeState(data.code, {
                                            200: function () {
                                                jQuery.fn.alert_msg("样品保存成功!");

                                                jQuery("#feature").val(null).trigger("change");
                                                jQuery("#condition").val(null).trigger("change");
                                                jQuery("#projectList").val(null).trigger("change");
                                                me.name = "";
                                                me.color = "";

                                                me.load_list();
                                            }
                                        });
                                    }, function (response) {
                                        jQuery.fn.error_msg("数据异常,样品保存失败,请刷新后重新尝试!");
                                    })
                                },
                                deleteBtn: function (item) {
                                    var me = this;
                                    var id = item.id;
                                    jQuery("#custom_lg_modal").modal("hide");
                                    jQuery.fn.check_msg({
                                        msg: "是否删除样品【" + item.name + "】？删除该样品会导致无法复用样品编号" + item.identify + "。",
                                        success: function () {
                                            me.$http.get("/sample/delete", {
                                                params: {
                                                    id: id
                                                }
                                            }).then(function (response) {
                                                var data = response.data;
                                                jQuery.fn.codeState(data.code, {
                                                    200: function () {
                                                        jQuery.fn.alert_msg("样品删除成功!");
                                                        me.sample_list.$remove(item);
                                                        jQuery("#custom_lg_modal").modal("show");
                                                    },
                                                    502: function () {
                                                        jQuery.fn.error_msg('请求异常,请重新尝试操作！');
                                                        jQuery("#custom_lg_modal").modal("show");
                                                    }
                                                });
                                            }, function (response) {
                                                jQuery.fn.error_msg("数据异常,无法删除样品,请刷新后重新尝试!");
                                            });

                                        },
                                        cancel: function () {
                                            jQuery("#custom_lg_modal").modal("show");
                                        }
                                    })
                                },
                                change: function (item) {
                                    var me = this;
                                    me.id = item.id;
                                    var projects = [];
                                    for (var i = 0; i < item.project.length; i++) {
                                        projects.push(item.project[i].id);
                                    }
                                    me.identify = item.identify;
                                    me.isChange = true;
                                    me.name = item.name;
                                    me.color = item.color;
                                    me.feature = item.feature;
                                    me.condition = item.condition;
                                    me.projects = projects;
                                    jQuery('#name').val(me.name);
                                    jQuery('#color').val(me.color);
                                    jQuery("#feature").select2("val", me.feature);
                                    jQuery("#condition").select2("val", me.condition);
                                    jQuery("#projectList").select2("val", me.projects);
                                },
                                cancelBtn: function () {
                                    var me = this;
                                    me.id = "";
                                    me.identify = "";
                                    me.isChange = false;
                                    debugger
                                    me.clear();
                                },
                                changeBtn: function () {
                                    var me = this;
                                    var id = me.id;
                                    debugger
                                    var data = {
                                        id: id,
                                        name: me.name,
                                        feature: me.feature,
                                        condition: me.condition,
                                        color: me.color,
                                        projects: me.projects
                                    };
                                    me.$http.post("/sample/changeItem", data).then(function (response) {
                                        var data = response.data;
                                        jQuery.fn.codeState(data.code, {
                                            200: function () {
                                                jQuery.fn.alert_msg("样品修改成功!");
//                                                jQuery("#feature").val(null).trigger("change");
//                                                jQuery("#condition").val(null).trigger("change");
//                                                jQuery("#projectList").val(null).trigger("change");
//                                                me.name = "";
//                                                me.color = "";
                                                me.cancelBtn();
                                                me.load_list();
                                            }
                                        });
                                    }, function (response) {
                                        jQuery.fn.error_msg("数据异常,样品保存失败,请刷新后重新尝试!");
                                    })

                                },
                                clear: function () {
                                    jQuery("#sample_form")[0].reset();
                                    jQuery('.select2').trigger("change");
                                },
                                load_list: function () {
                                    var me = this;
                                    me.$http.get("/sample/getSignleSample", {
                                        params: {
                                            id: id
                                        }
                                    }).then(function (response) {
                                        var data = response.data;
                                        me.$set("sample_list", data.results);
                                        me.$set("projectList", data.projects);
                                    }, function (response) {

                                    });
                                }
                            },
                            ready: function () {
                                var me = this;
                                me.load_list();
                                jQuery("#feature").select2({
                                    width: '100%'
                                }).on("change", function (event) {
                                    me.$set("feature", event.val)
                                });
                                jQuery("#condition").select2({
                                    width: '100%'
                                }).on("change", function (event) {
                                    me.$set("condition", event.val)
                                });
                                jQuery("#projectList").select2({
                                    width: '100%'
                                }).on("change", function (event) {
                                    me.$set("projects", event.val)
                                });

                            }
                        });
                        LIMS.dialog_lg.$set('title', '样品登记');
                        LIMS.dialog_lg.currentView = 'create_sample' + id;
                    }, function (response) {
                        jQuery.fn.error_msg("任务书数据请求异常,请刷新后重新尝试。");
                    });
                },
                view_info: function (contract) {
                    var me = this;
                    var id = contract.id;
                    me.$http.get("/task/getById", {
                        params: {
                            id: id
                        }
                    }).then(function (response) {
                        var data = response.data;
                        var template = jQuery.fn.loadTemplate("/assets/template/subject/task_view.tpl");
                        Vue.component('task_view' + id, {
                            template: template,
                            data: function () {
                                return {
                                    identify: "",
                                    client_unit: "",
                                    client_code: "",
                                    client_address: "",
                                    client_tel: "",
                                    client: "",
                                    project_name: "",
                                    monitor_aim: "",
                                    monitor_way: "",
                                    monitor_way_desp: "",
                                    item_arr: [],
                                    create_time: "",
                                    receive_deparment: "",
                                    create_user: "",
                                    other: ""
                                };
                            },
                            methods: {
                                print: function () {
                                    jQuery.fn.export_task(id);
                                }
                            },
                            ready: function () {
                                var me = this;
                                //var items = data.items;
                                for (var key in data) {
                                    if (me[key] != undefined) {
                                        me.$set(key, data[key]);
                                    }
                                }
                            }
                        });
                        LIMS.dialog_lg.$set('title', '查看任务书详情');
                        LIMS.dialog_lg.currentView = 'task_view' + id;
                    }, function (response) {
                        jQuery.fn.error_msg("任务书数据请求异常,请刷新后重新尝试。");
                    });
                },
                load_list: function (condition, currentPage) {
                    var me = this;
                    var dom = jQuery(me.$el);
                    var rowCount = localStorage.getItem("rowCount") || 0;
                    me.$http.get("/task/list", {
                        params: {
                            rowCount: rowCount,
                            currentPage: currentPage,
                            condition: condition
                        }
                    }).then(function (response) {
                        var data = response.data;
                        me.$set("result_list", data.results);
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
                                me.$http.get("/task/list", {
                                    params: {
                                        rowCount: rowCount,
                                        currentPage: currentPage,
                                        condition: data.condition
                                    }
                                }).then(function (response) {
                                    var data = response.data;
                                    me.$set("result_list", data.results);
                                }, function (response) {
                                    jQuery.fn.error_msg("无法获取任务书列表信息,请尝试刷新操作。");
                                });
                            }
                        });
                        jQuery.validator.setDefaults({
                            submitHandler: function () {
                            }
                        });
                    }, function (response) {
                        jQuery.fn.error_msg("无法获取任务书列表信息,请尝试刷新操作。");
                    });
                }
            },
            ready: function () {
                var me = this;
                me.load_list("", 1);
            }
        });
    });
</script>