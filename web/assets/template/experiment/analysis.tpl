<div class="panel panel-default">
    <div class="panel-body">
        <ul class="nav nav-tabs">
            <li id="tab_task_list" class="active"><a href="#home" data-toggle="tab"><strong>待分析</strong></a></li>
            <li><a href="#profile" data-toggle="tab"><strong>审核中</strong></a></li>
            <li id="tab-task"><a href="#task" data-toggle="tab"><strong>项目清单</strong></a></li>
        </ul>

        <!-- Tab panes -->
        <div class="tab-content mb30">
            <div class="tab-pane active" id="home">
                <div class="row">
                    <div class="results-list">
                        <template v-for="result in result_list">
                            <div class="media">
                                <a href="javascript:;" class="pull-left">
                                    <img alt="" src="/assets/images/photos/contract.png" class="media-object">
                                </a>
                                <div class="media-body">
                                    <div class="btn-demo pull-right">
                                        <a class="btn btn-info-alt"
                                           @click="task_experience(result)">实验分析</a>
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
                </div>
            </div>
            <div class="tab-pane" id="profile">
                <div class="row">

                </div>
            </div>
            <div class="tab-pane" id="task">
                <div class="row">
                    <div class="col-sm-12">
                        <div class="btn-demo">
                            <a class="btn btn-danger-alt" @click="flowItem">业务流转</a>
                        </div>
                        <div class="table-responsive">
                            <table class="table table-info mb30">
                                <thead>
                                <tr>
                                    <th class="text-center">编号</th>
                                    <th class="text-center">样品类别</th>
                                    <th class="text-center">分析项目</th>
                                    <th class="text-center">原始记录</th>
                                    <th class="text-center">送检单</th>
                                    <th class="text-center">样品件数</th>
                                    <th class="text-center">当前状态</th>
                                    <th class="text-center">操作</th>
                                </tr>
                                </thead>
                                <tbody>
                                <template v-for="(index,project) in projectList">
                                    <tr class="text-center">
                                        <td>{{index+1}}</td>
                                        <td>{{project.category.name}}</td>
                                        <td>{{project.name}}</td>
                                        <td>
                                            <a href="javascript:;" data-toggle="modal"
                                               data-target=".bs-example-modal-lg"><i class="fa fa-edit"
                                                                                     @click="originRecord(project)"></i></a>
                                        </td>
                                        <td>
                                            <a href="/distribute/createInspection?delivery_id={{project.delivery.id}}" target="_blank" ><i class="fa fa-edit"></i></a>
                                        </td>
                                        <td>{{project.samples.length}}</td>
                                        <td>{{project.state==0?"待分析":"待审核"}}</td>
                                        <td class="table-action">
                                            <a class="btn btn-sm btn-success-alt" @click="save(project)">完成</a>
                                            <a class="btn btn-sm btn-danger-alt"
                                               @click="showInfo(project.samples)">清单</a>
                                        </td>
                                    </tr>
                                </template>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="col-sm-12">
                        <div class="table-responsive" v-if="isShow">
                            <div class="col-sm-4 mb10">
                                <h4>样品详情</h4>
                            </div>
                            <table class="table table-success mb30">
                                <thead>
                                <tr>
                                    <th class="text-center">编号</th>
                                    <th class="text-center">样品编号</th>
                                    <th class="text-center">样品名称</th>
                                    <th class="text-center">样品状态</th>
                                    <th class="text-center">颜色</th>
                                    <th class="text-center">是否完好</th>
                                    <th class="text-center">当前状态</th>
                                </tr>
                                </thead>
                                <tbody>
                                <template v-for="(index,item) in sample_list">
                                    <tr class="text-center">
                                        <td>{{index+1}}</td>
                                        <td>{{item.identify}}</td>
                                        <td>{{item.name}}</td>
                                        <td v-if="item.feature=='G'">气态</td>
                                        <td v-if="item.feature=='L'">液态</td>
                                        <td v-if="item.feature=='S'">固态</td>
                                        <td>{{item.color}}</td>
                                        <td v-if="item.condition=='+'">完好</td>
                                        <td v-if="item.condition=='-'">瑕疵</td>
                                        <td v-if="item.receive==0">
                                            <span class="label label-danger">未接收</span>
                                        </td>
                                        <td v-if="item.receive==1">
                                            <span class="label label-success">已接收</span>
                                        </td>
                                    </tr>
                                </template>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="modal fade originRecord" id="create_originRecord" tabindex="-1" role="dialog"
     aria-labelledby="myLargeModalLabel"
     aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button aria-hidden="true" data-dismiss="modal" class="close" type="button">&times;</button>
                <h4 class="modal-title">请选择使用的原始记录模板</h4>
            </div>
            <div class="modal-body">
                <div class="panel-body panel-body-nopadding">
                    <form class="form-horizontal form-bordered">
                        <div class="form-group">
                            <label class="col-sm-3 control-label">选择模板</label>
                            <div class="col-sm-6">
                                <select class="select2" id="originRecord_template"
                                        data-placeholder="选择原始记录模板">
                                    <option value=""></option>
                                    <template v-for="item in originRecordTemplate">
                                        <option value="{{item.id}}">{{item.name}}</option>
                                    </template>
                                </select>
                            </div>
                        </div>
                    </form>
                    <div class="text-center col-md-12 btn-demo">
                        <a class="btn btn-primary-alt clear-float" @click="choose_template">选 择</a>
                        <a class="btn btn-default-alt clear-float" data-dismiss="modal">取 消</a>
                    </div>
                </div><!-- panel-body -->
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
                    id: "",
                    delivery_id: "",
                    identify: "",
                    isShow: false,
                    projectList: [],
                    sample_list: [],
                    originRecordTemplate: []
                }
            },
            methods: {
                task_experience: function (task) {
                    var me = this;
                    var id = task.id;
                    me.isShow = false;
                    me.$set("id", id);
                    me.$set("identify", task.identify);
                    me.load_projectlist(id);
                    jQuery("#tab-task a").tab("show");//显示详情页
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
                    me.$http.get("/task/experienceList", {
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
                load_projectlist: function (id) {
                    var me = this;
                    me.$http.get("/sample/getProjectListByDeliveryExperience", {
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
                },
                showInfo: function (samples) {
                    var me = this;
                    me.isShow = true;
                    me.$set("sample_list", samples);
                },
                originRecord: function (project) {
                    //填写原始记录表格
                    var me = this;
                    var template = jQuery.fn.loadTemplate("/assets/template/subject/create_originRecord.tpl");
                    Vue.component('originRecord' + project.id, {
                        template: template,
                        data: function () {
                            return {
                                originRecordList: []
                            };
                        },
                        methods: {
                            load_list: function () {
                                var that = this;
                                me.$http.get("/distribute/getInspectionList", {
                                    params: {
                                        task_id: me.id,
                                        project_id: project.id
                                    }
                                }).then(function (response) {
                                    var data = response.data;
                                    that.$set("originRecordList", data.results);
                                }, function (response) {
                                    jQuery.fn.error_msg("原始记录数据请求异常,请刷新后重新尝试。");
                                });
                            },
                            add_record: function () {
                                //新增原始记录
                                jQuery("#custom_lg_modal").modal("hide");
                                jQuery("#create_originRecord").modal("show");

                                me.$http.get("/template/getOriginRecord").then(function (response) {
                                    var data = response.data;
                                    me.$set("originRecordTemplate", data.results);
                                }, function (response) {
                                    jQuery.fn.error_msg("服务器异常,无法获取原始记录模板列表!");
                                });
                                me.delivery_id = project.delivery.id;
                            },
                            select_all: function () {
                                //全选操作
                                jQuery.fn.select_all('record_select', 'revert');
                            },
                            del_record: function (item) {
                                //删除原始记录
                                var me = this;
                                var oChecked = jQuery('input[name=record_select]:checked');
                                var selected = [];
                                var values = [];
                                if (item) {
                                    selected.push(item.id);
                                    values.push(item.name);
                                } else {
                                    for (var i = 0; i < oChecked.length; i++) {
                                        selected.push(oChecked[i].value);
                                        values.push(jQuery(oChecked[i]).data("value"));
                                    }
                                    if (selected.length == 0) {
                                        jQuery.fn.error_msg("至少选择一个原始记录!");
                                        return;
                                    }
                                }
                                jQuery('#custom_lg_modal').modal("hide");
                                jQuery.fn.check_msg({
                                    msg: "是否删除名称为【" + values + "】的原始记录表格?",
                                    success: function () {
                                        me.$http.get("/distribute/deleteOrignRecord", {
                                            params: {
                                                ids: selected
                                            }
                                        }).then(function (response) {
                                            var data = response.data;
                                            jQuery.fn.codeState(data.code, {
                                                200: function () {
                                                    jQuery.fn.alert_msg("原始记录删除成功!");
                                                    me.load_list();
                                                    jQuery('#custom_lg_modal').modal("show");
                                                }
                                            })
                                        }, function (response) {
                                            jQuery.fn.error_msg("数据异常,无法删除原始记录");
                                        });
                                    },
                                    cancel: function () {
                                        jQuery('#custom_lg_modal').modal("show");
                                    }
                                })

                            },
                            changeItem: function (item) {
                                //变更当前原始记录
                            },
                            delItem: function (item) {
                                //删除当前原始记录


                            }

                        },
                        ready: function () {
                            var that = this;
                            that.load_list();
                        }
                    });
                    LIMS.dialog_lg.$set('title', project.name + '原始记录列表');
                    LIMS.dialog_lg.currentView = 'originRecord' + project.id;


                },
//                inspection: function (project) {
//                    //填写送检单
//                    //alert("填写送检单");
//                },
                save: function (project) {
                    var me = this;
                    jQuery.fn.check_msg({
                        msg: "是否保存当前【" + project.name + "】的实验分析结果？",
                        success: function () {
                            me.$http.post("/distribute/analystSave", {
                                project_id: project.id,
                                task_id: me.id
                            }).then(function (response) {
                                var data = response.data;
                                jQuery.fn.codeState(data.code, {
                                    200: function () {
                                        jQuery.fn.alert_msg(project.name + "检测结果保存成功!");
                                    },
                                    505: function () {
                                        jQuery.fn.error_msg("您尚未填写送检单,无法保存检测结果!");
                                    }
                                });
                            }, function (response) {
                                jQuery.fn.error_msg("数据异常,无法保存当前分析结果!");
                            });
                        }
                    })
                },
                choose_template: function () {
                    //选择原始记录模板
                    var me = this;
                    var id = jQuery('#originRecord_template').val();
                    window.open("/distribute/createOriginRecord?template_id=" + id + "&&delivery_id=" + me.delivery_id);
                },
                flow: function (task) {
                    var me = this;
                    jQuery.fn.check_msg({
                        msg: "您即将进行任务编号为【" + task.identify + "】的进度流转,是否继续?",
                        success: function () {
                            var data = {
                                task_id: task.id
                            };
                            me.$http.post("/distribute/checkUser", data).then(function (response) {
                                var data = response.data;
                                jQuery.fn.codeState(data.code, {
                                    200: function () {
                                        me.$http.post("/flow/distributeFlow", {id: task.id}).then(function (response) {
                                            var data = response.data;
                                            jQuery.fn.codeState(data.code, {
                                                200: function () {
                                                    jQuery.fn.alert_msg("任务流转成功!");
                                                    me.projectList = [];
                                                    me.sample_list = [];
                                                    me.load_list("state=receive_delivery", 1);

                                                }
                                            })
                                        }, function (response) {
                                            jQuery.fn.error_msg("数据异常,无法流转任务,请刷新后重新尝试!");
                                        });
                                    },
                                    504: function () {
                                        jQuery.fn.error_msg("当前任务书尚有未分配监测项目,任务无法流转!");
                                    }
                                })
                            }, function (response) {
                                jQuery.fn.error_msg("数据异常,无法进行项目流转!");
                            });
                        }
                    })
                },
                flowItem: function (task) {
                    var me = this;
                    jQuery.fn.check_msg({
                        msg: "您即将进行任务编号为【" + me.identify + "】的进度流转,是否继续?",
                        success: function () {
                            var data = {
                                task_id: me.id
                            };
                            me.$http.post("/distribute/checkUser", data).then(function (response) {
                                var data = response.data;
                                jQuery.fn.codeState(data.code, {
                                    200: function () {
                                        me.$http.post("/flow/distributeFlow", {id: me.id}).then(function (response) {
                                            var data = response.data;
                                            jQuery.fn.codeState(data.code, {
                                                200: function () {
                                                    jQuery.fn.alert_msg("任务流转成功!");
                                                    me.load_list("state=receive_delivery", 1);
                                                    me.projectList = [];
                                                    me.sample_list = [];
                                                    jQuery("#tab_task_list a").tab("show");
                                                }
                                            })
                                        }, function (response) {
                                            jQuery.fn.error_msg("数据异常,无法流转任务,请刷新后重新尝试!");
                                        });
                                    },
                                    504: function () {
                                        jQuery.fn.error_msg("当前任务书尚有未分配监测项目,任务无法流转!");
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
                var me = this;
                me.load_list("", 1);
                jQuery("#originRecord_template").select2({
                    width: '100%'
                });
            }
        });
    });
</script>