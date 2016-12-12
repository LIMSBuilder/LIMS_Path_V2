<div class="panel panel-default">
    <div class="panel-body">
        <ul class="nav nav-tabs">
            <li id="tab_task_list" class="active"><a href="#home" data-toggle="tab"><strong>待复核</strong></a></li>
        </ul>

        <div class="tab-content mb30">
            <div class="tab-pane active" id="home">
                <div class="row">
                    <p v-if="result_list.length==0">暂无待复核任务。</p>
                    <div class="results-list">
                        <template v-for="result in result_list">
                            <div class="media">
                                <a href="javascript:;" class="pull-left">
                                    <img alt="" src="/assets/images/photos/contract.png" class="media-object">
                                </a>
                                <div class="media-body">
                                    <div class="btn-demo pull-right">
                                        <a class="btn btn-info-alt" data-toggle="modal"
                                           data-target=".bs-example-modal-lg" @click="review_item(result)">实验复核</a>
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
                    <div class="paging nomargin pull-right"></div>
                </div>
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
                        result_list: [],//结果集
                        history_list: []
                    }
                },
                methods: {
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
                        me.$http.get("/task/reviewList", {
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
                                    me.$http.get("/task/reviewList", {
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
                    review_item: function (item) {
                        var task_id = item.id;
                        var that = this;
                        var template = jQuery.fn.loadTemplate("/assets/template/subject/check_experiment.tpl");
                        Vue.component('check_experience' + task_id, {
                            template: template,
                            data: function () {
                                return {
                                    isShow: false,
                                    projectList: [],
                                    sample_list: [],
                                    originRecordList: []
                                };
                            },
                            methods: {
                                load_list: function () {
                                    var me = this;
                                    me.$http.get("/sample/getProjectListByDeliveryCheck", {
                                        params: {
                                            id: task_id
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
                                        jQuery.fn.error_msg("任务数据请求异常,请刷新后重新尝试。");
                                    });
                                },
                                showInfo: function (samples, originRecordList) {
                                    var me = this;
                                    me.isShow = true;
                                    me.$set("sample_list", samples);
                                    me.$set("originRecordList", originRecordList);
                                },
                                review: function (project, state) {
                                    var me = this;
                                    me.$http.post("/distribute/reviewState", {
                                        state: state,
                                        delivery_id: project.delivery.id
                                    }).then(function (response) {
                                        var data = response.data;
                                        jQuery.fn.codeState(data.code, {
                                            200: function () {
                                                jQuery.fn.alert_msg("复核结果保存成功!");
                                                //me.load_list();
                                                project.delivery.state = state;
                                            }
                                        });
                                    }, function (response) {
                                        jQuery.fn.error_msg("复核数据异常,无法完成复核!");
                                    });
                                },
                                review_all: function (state) {
                                    var me = this;
                                    me.$http.post("/distribute/reviewCheckStateAll", {
                                        task_id: task_id,
                                        state: state
                                    }).then(function (response) {
                                        var data = response.data;
                                        jQuery.fn.codeState(data.code, {
                                            200: function () {
                                                jQuery.fn.alert_msg("实验分析纪录全部复核完成！");
                                                that.load_list();
                                            }
                                        });
                                    }, function (response) {
                                        jQuery.fn.error_msg("数据异常,无法完成实验分析记录复核!");
                                    });

                                },
                                flow: function () {
                                    var me = this;
                                    jQuery("#custom_lg_modal").modal("hide");
                                    jQuery.fn.check_msg({
                                        msg: "您即将进行任务编号为【" + item.identify + "】的进度流转,是否继续?",
                                        success: function () {
                                            var data = {
                                                task_id: task_id
                                            };
                                            me.$http.post("/distribute/checkAssessor", data).then(function (response) {
                                                var data = response.data;
                                                jQuery.fn.codeState(data.code, {
                                                    200: function () {
                                                        me.$http.post("/flow/reviewFlow", {id: task_id}).then(function (response) {
                                                            var data = response.data;
                                                            jQuery.fn.codeState(data.code, {
                                                                200: function () {
                                                                    jQuery.fn.alert_msg("任务流转成功!");
                                                                    debugger
                                                                    me.load_list("", 1);
                                                                }
                                                            })
                                                        }, function (response) {
                                                            jQuery.fn.error_msg("数据异常,无法流转任务,请刷新后重新尝试!");
                                                        });
                                                    },
                                                    504: function () {
                                                        jQuery.fn.error_msg("当前任务书尚有未复核的实验分析结果,任务无法流转!");
                                                    }
                                                })
                                            }, function (response) {
                                                jQuery.fn.error_msg("数据异常,无法进行项目流转!");
                                            });
                                        }
                                    })
                                }
                            },
                            ready: function () {
                                var that = this;
                                that.load_list();
                            }
                        });
                        LIMS.dialog_lg.$set('title', '查看实验分析记录');
                        LIMS.dialog_lg.currentView = 'check_experience' + task_id;
                    },
                    view_process: function (task) {
                        var task_id = task.id;
                        var that = this;
                        var template = jQuery.fn.loadTemplate("/assets/template/subject/view_experiment_process.tpl");
                        Vue.component('view_experience_process' + task_id, {
                            template: template,
                            data: function () {
                                var alert_info = jQuery.fn.loadTemplate("/assets/template/subject/alert_info.tpl");
                                return {
                                    isShow: false,
                                    projectList: [],
                                    sample_list: [],
                                    originRecordList: [],
                                    alert_info: alert_info,
                                    analyst: {},
                                    analyst_time: "",
                                    assessor: {},
                                    assessor_time: "",
                                    checker: {},
                                    checker_time: "",
                                    state: "",
                                    assess_reject:[]
                                };
                            },
                            methods: {
                                load_list: function () {
                                    var me = this;
                                    me.$http.get("/sample/getProjectListByDeliveryProcess", {
                                        params: {
                                            id: task_id
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
                                        jQuery.fn.error_msg("任务数据请求异常,请刷新后重新尝试。");
                                    });
                                },
                                showInfo: function (project) {
                                    var me = this;
                                    me.isShow = true;
                                    me.$set("sample_list", project.samples);
                                    me.$set("originRecordList", project.originRecordList);
                                    me.$set("analyst", project.analyst);
                                    me.$set("analyst_time", project.analyst_time);
                                    me.$set("assessor", project.assessor);
                                    me.$set("assessor_time", project.assessor_time);
                                    me.$set("checker", project.checker);
                                    me.$set("checker_time", project.checker_time);
                                    me.$set("state", project.delivery.state);
                                    me.$set("assess_reject",project.assess_reject);
                                }
                            },
                            ready: function () {
                                var that = this;
                                that.load_list();
                                jQuery('.popovers').popover({
                                    html: "<h1>Hello World</h1>"
                                });
                            }
                        });
                        LIMS.dialog_lg.$set('title', '查看实验分析记录');
                        LIMS.dialog_lg.currentView = 'view_experience_process' + task_id;
                    },
                },
                ready: function () {
                    var me = this;
                    me.load_list("", 1);
                }
            });
        });
    </script>