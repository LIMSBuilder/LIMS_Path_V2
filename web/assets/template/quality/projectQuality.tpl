<div class="panel panel-default">
    <div class="panel-body">
        <div class="row">
            <div class="col-sm-12 col-md-12">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <div class="paging nomargin pull-right"></div>
                        <h4 class="panel-title">待质控任务书</h4>
                    </div><!-- panel-heading -->
                    <div class="panel-body">
                        <p v-if="result_list.length==0">暂无待质控的任务。</p>
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
                                               @click="create_quality(result)">质量控制</a>
                                            <a class="btn btn-default-alt" data-toggle="modal"
                                               data-target=".bs-example-modal-lg" @click="view_info(result)">查看详情</a>
                                            <a class="btn btn-danger-alt" @click="flow(result)">业务流转</a>
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
                create_quality: function (task) {
                    var me = this;
                    var id = task.id;
                    me.$http.get("/task/getById", {
                        params: {
                            id: id
                        }
                    }).then(function (response) {
                        var data = response.data;
                        var template = jQuery.fn.loadTemplate("/assets/template/subject/create_quality.tpl");
                        Vue.component('create_quality' + id, {
                            template: template,
                            data: function () {
                                return {
                                    isShow: false,
                                    projectList: [],
                                    sample_list: [],
                                    sampleCount: "",
                                    sampleFrom: "",
                                    sampleTo: "",
                                    sample_create: "",
                                    sample_user: "",
                                    project_id: 0,
                                    blindCount: 0,//盲样个数
                                    sceneList: [],//现场平行样
                                    labList: [],//实验室平行样
                                    markList: [],//加标回收样
                                    qualityList: []
                                };
                            },
                            methods: {
                                showInfo: function (item) {
                                    var me = this;
                                    me.isShow = true;
                                    me.$set("sample_list", item.samples);
                                    me.blindCount = 0;
                                    me.$set("sceneList", []);
                                    me.$set("labList", []);
                                    me.$set("markList", []);
                                    me.$set("project_id", item.id);
                                },
                                save: function () {
                                    var me = this;
                                    var data = {
                                        id: id,
                                        project_id: me.project_id,
                                        sceneList: me.sceneList,
                                        labList: me.labList,
                                        markList: me.markList,
                                        blindCount: me.blindCount
                                    };
                                    me.$http.post("/quality/save", data).then(function (response) {
                                        var data = response.data;
                                        jQuery.fn.codeState(data.code, {
                                            200: function () {
                                                jQuery.fn.alert_msg("当前监测项目质量控制记录已经保存!");
                                                me.load_list();
                                            }
                                        })
                                    }, function (response) {
                                        jQuery.fn.error_msg("服务器异常,无法保存当前监测项目的质控记录!");
                                    });
                                },
                                deleteQuality: function (item) {
                                    var me = this;
                                    var id = item.id;
                                    me.$http.get("/quality/deleteItem", {
                                        params: {
                                            id: id
                                        }
                                    }).then(function (response) {
                                        var data = response.data;
                                        jQuery.fn.codeState(data.code, {
                                            200: function () {
                                                jQuery.fn.alert_msg("当前质控记录删除成功!");
                                                me.load_list();
                                            }
                                        })
                                    }, function (response) {
                                        jQuery.fn.error_msg("服务器异常,无法删除当前质控记录!");
                                    });
                                },
                                export: function () {
                                    jQuery.fn.export_quality(id);
                                },
                                flow: function () {
                                    var that = this;
                                    jQuery("#custom_lg_modal").modal("hide");
                                    jQuery.fn.check_msg({
                                        msg: "您即将进行任务编号为【" + task.identify + "】的进度流转,是否继续?",
                                        success: function () {
                                            me.$http.post("/flow/qualityFlow", {id: id}).then(function (response) {
                                                var data = response.data;
                                                jQuery.fn.codeState(data.code, {
                                                    200: function () {
                                                        jQuery.fn.alert_msg("任务流转成功!");
                                                        me.load_list("state=connect_sample", 1);
                                                    }
                                                })
                                            }, function (response) {
                                                jQuery.fn.error_msg("数据异常,无法流转任务,请刷新后重新尝试!");
                                            });
                                        }
                                    })
                                },
                                load_list: function () {
                                    var me = this;
                                    me.$http.get("/quality/list", {
                                        params: {
                                            id: id
                                        }
                                    }).then(function (response) {
                                        var data = response.data;
                                        me.$set("qualityList", data.results);
                                    }, function (response) {
                                        jQuery.fn.error_msg("无法获取质量控制列表信息,请刷新后重新尝试!");
                                    });
                                }
                            },
                            ready: function () {
                                var me = this;
                                me.$http.get("/sample/getProjectListByDelivery", {
                                    params: {
                                        id: id
                                    }
                                }).then(function (response) {
                                    var data = response.data;
                                    for (var key in data) {
                                        if (me[key] != undefined) {
                                            me.$set(key, data[key]);
                                        }
                                    }
                                    me.$set("projectList", data.results);
                                }, function (response) {
                                    jQuery.fn.error_msg("样品数据请求异常,请刷新后重新尝试。");
                                });
                                me.load_list();
                            }
                        });
                        LIMS.dialog_lg.$set('title', '质量控制');
                        LIMS.dialog_lg.currentView = 'create_quality' + id;
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
                },
                flow: function (item) {
                    var me = this;
                    jQuery.fn.check_msg({
                        msg: "您即将进行任务编号为【" + item.identify + "】的进度流转,是否继续?",
                        success: function () {
                            me.$http.post("/flow/qualityFlow", {id: item.id}).then(function (response) {
                                var data = response.data;
                                jQuery.fn.codeState(data.code, {
                                    200: function () {
                                        jQuery.fn.alert_msg("任务流转成功!");
                                        me.load_list("state=connect_sample", 1);
                                    },
                                    501: "样品数量不能为空,请先进行样品登记！"
                                })
                            }, function (response) {
                                jQuery.fn.error_msg("数据异常,无法流转任务,请刷新后重新尝试!");
                            });
                        }
                    })
                }
            },
            ready: function () {
                var me = this;
                me.load_list("state=connect_sample", 1);
            }
        });
    });
</script>