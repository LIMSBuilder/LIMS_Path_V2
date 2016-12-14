<div class="panel panel-default">
    <div class="panel-body">
        <div class="row">
            <div class="col-sm-12 col-md-12">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <div class="paging nomargin pull-right"></div>
                        <h4 class="panel-title">待接收样品</h4>
                    </div><!-- panel-heading -->
                    <div class="panel-body">
                        <p v-if="result_list.length==0">暂无待接收的任务。</p>
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
                                               @click="connect_sample(result)">样品接收</a>
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
                connect_sample: function (task) {
                    var me = this;
                    var id = task.id;
                    me.$http.get("/task/getById", {
                        params: {
                            id: id
                        }
                    }).then(function (response) {
                        var data = response.data;
                        var template = jQuery.fn.loadTemplate("/assets/template/subject/receive_sample.tpl");
                        Vue.component('sample_receive' + id, {
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
                                    sampleFlag: "",//样品标识
                                    additive: "",//固体添加剂情况
                                    package: ""//样品包装情况
                                };
                            },
                            methods: {
                                showInfo: function (samples) {
                                    var me = this;
                                    me.isShow = true;
                                    me.$set("sample_list", samples);
                                },
                                receive: function (item, type) {
                                    var me = this;
                                    var data = {
                                        id: item.id,
                                        receive: type
                                    };
                                    me.$http.post("/sample/receive", data).then(function (response) {
                                        var data = response.data;
                                        jQuery.fn.codeState(data.code, {
                                            200: function () {
                                                jQuery.fn.alert_msg("该样品接收成功!");
                                                item.receive = type;
                                                me.load_list();
                                            }
                                        })
                                    }, function (response) {
                                        jQuery.fn.error_msg("数据异常,无法接收当前样品!");
                                    });

                                },
                                save: function (project) {
                                    var me = this;
                                    //增加对每个样品的验证
                                    var samples = project.samples;
                                    for (var i = 0; i < samples.length; i++) {
                                        if (samples[i].receive != 1) {
                                            //当前有项目尚未被接收,无法保存
                                            jQuery.fn.error_msg("当前分析项目存在样品尚未接收,请先确认样品接收之后保存!");
                                            return;
                                        }
                                    }
                                    var data = {
                                        id: project.id,
                                        task_id: id,
                                        character: project.character,
                                        storage: project.storage
                                    };
                                    me.$http.post("/delivery/receiveItem", data).then(function (response) {
                                        var data = response.data;
                                        jQuery.fn.codeState(data.code, {
                                            200: function () {
                                                jQuery.fn.alert_msg("当前分析项目保存成功!!");
                                            }
                                        });
                                    }, function (response) {
                                        jQuery.fn.error_msg("数据异常,无法保存当前接收样品信息!");
                                    });
                                },
                                export: function () {
                                    jQuery.fn.export_delivery(id);
                                },
                                flow: function () {
                                    var that = this;
                                    jQuery("#custom_lg_modal").modal("hide");
                                    jQuery.fn.check_msg({
                                        msg: "您即将进行任务编号为【" + task.identify + "】的进度流转,是否继续?",
                                        success: function () {
                                            var data = {
                                                task_id: id,
                                                sampleFlag: that.sampleFlag,//样品标识
                                                additive: that.additive,//固体添加剂情况
                                                package: that.package//样品包装情况
                                            };
                                            me.$http.post("/delivery/receiveInfo", data).then(function (response) {
                                                var data = response.data;
                                                jQuery.fn.codeState(data.code, {
                                                    200: function () {
                                                        me.$http.post("/flow/deliveryFlow", {id: id}).then(function (response) {
                                                            var data = response.data;
                                                            jQuery.fn.codeState(data.code, {
                                                                200: function () {
                                                                    jQuery.fn.alert_msg("任务流转成功!");
                                                                    me.load_list("state=create_quality", 1);
                                                                }
                                                            })
                                                        }, function (response) {
                                                            jQuery.fn.error_msg("数据异常,无法流转任务,请刷新后重新尝试!");
                                                        });
                                                    }
                                                })
                                            }, function (response) {
                                                jQuery.fn.error_msg("数据异常,无法保存交联清单信息!");
                                            });
                                        }
                                    })
                                },
                                load_list: function () {
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
                                }
                            },
                            ready: function () {
                                var me = this;
                                me.load_list();
                                jQuery('#package').select2({
                                    width: '100%'
                                }).on("change", function (event) {
                                    var id = event.val;
                                    me.$set("package", id);
                                });
                            }
                        });
                        LIMS.dialog_lg.$set('title', '样品接收');
                        LIMS.dialog_lg.currentView = 'sample_receive' + id;
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
                me.load_list("state=create_quality", 1);
            }
        });
    });
</script>