<div class="panel panel-default">
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
                               data-target=".bs-example-modal-lg" @click="review_item(result)">实验审核</a>
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
                    me.$http.get("/task/assessList", {
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
                review_item: function (item) {
                    var task_id = item.id;
                    var that = this;
                    var template = jQuery.fn.loadTemplate("/assets/template/subject/review_experiment.tpl");
                    Vue.component('review_experience' + task_id, {
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
                                me.$http.get("/sample/getProjectListByDeliveryAssess", {
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
                                            jQuery.fn.alert_msg("审核结果保存成功!");
                                            //me.load_list();
                                            project.delivery.state = state;
                                        }
                                    });
                                }, function (response) {
                                    jQuery.fn.error_msg("审核数据异常,无法完成审核!");
                                });
                            },
                            review_all: function (state) {
                                var me = this;
                                me.$http.post("/distribute/reviewStateAll", {
                                    task_id: task_id,
                                    state: state
                                }).then(function (response) {
                                    var data = response.data;
                                    jQuery.fn.codeState(data.code, {
                                        200: function () {
                                            jQuery.fn.alert_msg("实验分析纪录全部审核完成！");
                                            me.load_list();
                                        }
                                    });
                                }, function (response) {
                                    jQuery.fn.error_msg("数据异常,无法完成实验分析记录审核!");
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
                                                    me.$http.post("/flow/assessorFlow", {id: task_id}).then(function (response) {
                                                        var data = response.data;
                                                        jQuery.fn.codeState(data.code, {
                                                            200: function () {
                                                                jQuery.fn.alert_msg("任务流转成功!");
                                                                that.load_list("", 1);
                                                            }
                                                        })
                                                    }, function (response) {
                                                        jQuery.fn.error_msg("数据异常,无法流转任务,请刷新后重新尝试!");
                                                    });
                                                },
                                                504: function () {
                                                    jQuery.fn.error_msg("当前任务书尚有未审核的实验分析结果,任务无法流转!");
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
                    LIMS.dialog_lg.currentView = 'review_experience' + task_id;
                }
            },
            ready: function () {
                var me = this;
                me.load_list("", 1);
            }
        });
    });
</script>