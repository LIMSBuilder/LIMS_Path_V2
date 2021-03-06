<div class="panel panel-default">
    <div class="panel-body">
        <ul class="nav nav-tabs">
            <li id="tab_task_list" class="active"><a href="#home" data-toggle="tab"><strong>待我分析</strong></a></li>
            <li id="tab-task"><a href="#task" data-toggle="tab"><strong>{{identify==""?"任务详情":'当前:'+identify}}</strong></a>
        </ul>

        <!-- Tab panes -->
        <div class="tab-content mb30">
            <div class="tab-pane active" id="home">
                <div class="row">
                    <p v-if="result_list.length==0">暂无待分析任务。</p>
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
                    <div class="paging nomargin pull-right" id="currentPage"></div>
                </div>
            </div>
            <div class="tab-pane" id="task">
                <div class="row" v-if="showTab">
                    <div class="col-sm-12">
                        <div class="btn-demo">
                            <a class="btn btn-warning-alt" @click="flow(id,identify)">业务流转</a>
                            <a class="btn btn-info-alt" data-toggle="modal"
                               data-target=".bs-example-modal-lg"
                               @click="view_record_review(id)">主任审核记录</a>
                            <a class="btn btn-primary-alt" data-toggle="modal"
                               data-target=".bs-example-modal-lg"
                               @click="view_recordSecond_review(id)">质控审核记录</a>
                            <a class="btn btn-default-alt" @click="frash">刷 新</a>
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
                                            记录数:{{project.originRecond_count}}个&nbsp;
                                            <a data-toggle="modal"
                                               data-target=".bs-example-modal-lg" class="btn btn-sm btn-primary-alt"
                                               @click="originRecord(project)">列 表</a>
                                        </td>
                                        <td>

                                            <a v-if="project.inspection_path == null"
                                               href="/distribute/createInspection?delivery_id={{project.delivery.id}}"
                                               target="_blank" class="btn btn-sm btn-info-alt">填 写</a>
                                            <a v-if="project.inspection_path == null" class="btn btn-sm btn-info-alt"
                                               @click="upload_inspection(project)">上 传</a>
                                            <a v-if="project.inspection_path != null"
                                               href="/distribute/viewInspection?delivery_id={{project.delivery.id}}"
                                               target="_blank" class="btn btn-sm btn-success-alt">查 看</a>
                                            <a v-if="project.inspection_path != null && (project.delivery.state==0||project.delivery.state==-3)"
                                               href="/distribute/changeInspection?delivery_id={{project.delivery.id}}"
                                               target="_blank" class="btn btn-sm btn-primary-alt">修 改</a>
                                            <a v-if="project.inspection_path != null && (project.delivery.state==0||project.delivery.state==-3)"
                                               class="btn btn-sm btn-danger-alt" @click="deleteInspection(project)">删
                                                除</a>
                                        </td>
                                        <td>{{project.samples.length}}</td>
                                        <td v-show="project.state==-3">
                                            <span class="label label-warning">待完善</span>
                                        </td>
                                        <td v-show="project.state==0">
                                            <span class="label label-info">待分析</span>
                                        </td>
                                        <td v-show="project.state==1">
                                            <span class="label label-success">已分析</span>
                                        </td>
                                        <td class="table-action">
                                            <a v-show="project.state==0||project.delivery.state==-3"
                                               class="btn btn-sm btn-success-alt"
                                               @click="save(project)">完成</a>
                                            <a class="btn btn-sm btn-info-alt"
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
                <div class="row" v-else>
                    <p>请先选择一个任务。</p>
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
<script type="text/javascript" src="/assets/js/toggles.min.js"></script>
<script type="text/javascript" src="/assets/js/dropzone.min.js"></script>
<script>
    jQuery(document).ready(function () {
        "use strict";
        var vue = new Vue({
            el: '#contentpanel',
            data: function () {
                return {
                    showTab: false,
                    result_list: [],//结果集
                    id: "",
                    delivery_id: "",
                    identify: "",
                    isShow: false,
                    projectList: [],
                    sample_list: [],
                    originRecordTemplate: [],
                    history_list: []
                }
            },
            methods: {
                task_experience: function (task) {
                    var me = this;
                    var id = task.id;
                    me.isShow = false;
                    me.showTab = true;
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
                        dom.find('#currentPage').pagination({
                            pageCount: data.totalPage != 0 ? data.totalPage : 1,
                            coping: true,
                            homePage: '首页',
                            endPage: '末页',
                            prevContent: '上页',
                            nextContent: '下页',
                            current: data.currentPage,
                            callback: function (page) {
                                var currentPage = page.getCurrent();
                                me.$http.get("/task/experienceList", {
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
                                assess_reject: []
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
                                me.$set("assess_reject", project.assess_reject);
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
                frash: function () {
                    var me = this;
                    me.load_projectlist(me.id);
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
                    var delivery_id = project.delivery.id;
                    var template = jQuery.fn.loadTemplate("/assets/template/subject/create_originRecord.tpl");
                    Vue.component('originRecord' + project.delivery.id + project.delivery.state, {
                        template: template,
                        data: function () {
                            return {
                                originRecordList: [],
                                delivery: null
                            };
                        },
                        methods: {
                            load_list: function () {
                                var that = this;
                                me.$http.get("/distribute/getOriginRecordList", {
                                    params: {
                                        task_id: me.id,
                                        project_id: project.id,
                                        delivery_id: project.delivery.id
                                    }
                                }).then(function (response) {
                                    var data = response.data;
                                    that.$set("originRecordList", data.results);
                                    that.$set("delivery", data.delivery);
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
                                var that = this;
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
                                                    that.load_list();
                                                    me.load_projectlist(me.id);
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
                            add_record_upload: function () {
                                var add_upload = this;
                                jQuery("#custom_lg_modal").modal("hide");
                                jQuery("#custom_modal").modal("show");
                                var template = jQuery.fn.loadTemplate("/assets/template/subject/upload_originRecord.tpl");
                                Vue.component('upload_self_originRecord' + delivery_id, {
                                    template: template,
                                    data: function () {
                                        return {
                                            name: ""
                                        };
                                    },
                                    methods: {},
                                    ready: function () {
                                        var that = this;
                                        jQuery("#dropz").dropzone({
                                            url: "/file/upload",
                                            maxFilesize: 2,
                                            method: "post",
                                            maxFiles: 1,
                                            paramName: 'inspection_template',
                                            addRemoveLinks: true,//添加移除文,
                                            autoProcessQueue: false,//不自动上传
                                            dictMaxFilesExceeded: "您一次最多只能上传{{maxFiles}}个文件",
                                            dictResponseError: '文件上传失败!',
                                            dictInvalidFileType: "你不能上传该类型文件,文件类型只能是Word文档。",
                                            dictCancelUpload: "取消上传",
                                            dictCancelUploadConfirmation: "你确定要取消上传吗?",
                                            dictRemoveFile: "移除文件",
                                            uploadMultiple: false,
                                            init: function () {
                                                var dropObj = this;
                                                dropObj.on("success", function (file) {
                                                    if (file.xhr.status != 200) {
                                                        jQuery.fn.error_msg("服务器异常,无法上传文件!");
                                                        return;
                                                    }
                                                    var data = JSON.parse(file.xhr.responseText);
                                                    if (data.code == 200) {
                                                        me.$http.post("/distribute/uploadOriginRecord", {
                                                            name: that.name,
                                                            path: data.path,
                                                            delivery_id: project.delivery.id
                                                        }).then(function (response) {
                                                            var data = response.data;
                                                            jQuery.fn.codeState(data.code, {
                                                                200: function () {
                                                                    jQuery.fn.alert_msg("原始记录保存成功!");
                                                                    me.load_projectlist(me.id);
                                                                    add_upload.load_list();
                                                                }
                                                            })
                                                        }, function (response) {
                                                            jQuery.fn.error_msg("原始记录模板保存失败,请刷新后重新尝试!");
                                                        });
                                                    }
                                                });

                                                jQuery("#save_originRecord").off("click").on("click", function () {
                                                    jQuery("#custom_modal").modal("hide");
                                                    jQuery.fn.check_msg({
                                                        msg: "是否保存当前原始记录?",
                                                        success: function () {
                                                            var data = dropObj.processQueue();
                                                            dropObj.removeAllFiles();
                                                        }
                                                    });
                                                });
                                            }
                                        });
                                    }
                                });
                                LIMS.dialog.$set('title', "上传自定义原始记录");
                                LIMS.dialog.currentView = 'upload_self_originRecord' + delivery_id;
                            }
                        },
                        ready: function () {
                            var that = this;
                            that.load_list();
                        }
                    });
                    LIMS.dialog_lg.$set('title', project.name + '原始记录列表');
                    LIMS.dialog_lg.currentView = 'originRecord' + project.delivery.id + project.delivery.state;
                },
                deleteInspection: function (project) {
                    var me = this;
                    var delivery_id = project.delivery.id;
                    jQuery.fn.check_msg({
                        msg: "是否删除【" + project.name + "】的送检单?",
                        success: function () {
                            me.$http.post("/distribute/deleteInspection", {delivery_id: delivery_id}).then(function (response) {
                                var data = response.data;
                                jQuery.fn.codeState(data.code, {
                                    200: function () {
                                        jQuery.fn.alert_msg("当前送检单删除成功！");
                                        me.frash();
                                    }
                                });

                            }, function () {
                                jQuery.fn.error_msg("服务器异常，无法删除送检单！");
                            })
                        }
                    });
                },
                upload_inspection: function (project) {
                    console.log(project.delivery.id);
                    //上传送检单
                    var me = this;
                    var delivery_id = project.delivery.id;
                    console.log(delivery_id);
                    var template = jQuery.fn.loadTemplate("/assets/template/subject/upload_inspection.tpl");
                    jQuery("#custom_modal").modal("show");

                    Vue.component('upload_inspection' + delivery_id, {
                        template: template,
                        data: function () {
                            return {};
                        },
                        methods: {},
                        ready: function () {
                            var that = this;
                            jQuery("#dropz").dropzone({
                                url: "/file/upload",
                                maxFilesize: 2,
                                method: "post",
                                maxFiles: 1,
                                paramName: 'inspection_template',
                                addRemoveLinks: true,//添加移除文,
                                autoProcessQueue: false,//不自动上传
                                dictMaxFilesExceeded: "您一次最多只能上传{{maxFiles}}个文件",
                                dictResponseError: '文件上传失败!',
                                dictInvalidFileType: "你不能上传该类型文件,文件类型只能是Word文档。",
                                dictCancelUpload: "取消上传",
                                dictCancelUploadConfirmation: "你确定要取消上传吗?",
                                dictRemoveFile: "移除文件",
                                uploadMultiple: false,
                                init: function () {
                                    var dropObj = this;
                                    dropObj.on("success", function (file) {
                                        if (file.xhr.status != 200) {
                                            jQuery.fn.error_msg("服务器异常,无法上传文件!");
                                            return;
                                        }
                                        var data = JSON.parse(file.xhr.responseText);
                                        if (data.code == 200) {
                                            me.$http.post("/distribute/uploadInspection", {
                                                path: data.path,
                                                delivery_id: delivery_id
                                            }).then(function (response) {
                                                var data = response.data;
                                                jQuery.fn.codeState(data.code, {
                                                    200: function () {
                                                        jQuery.fn.alert_msg("送检单保存成功!");
                                                        me.load_projectlist(me.id);
                                                    }
                                                })
                                            }, function (response) {
                                                jQuery.fn.error_msg("送检单保存失败,请刷新后重新尝试!");
                                            });
                                        }
                                    });

                                    jQuery("#save_originRecord").off("click").on("click", function () {
                                        jQuery("#custom_modal").modal("hide");
                                        jQuery.fn.check_msg({
                                            msg: "是否保存当前自定义送检单?",
                                            success: function () {
                                                var data = dropObj.processQueue();
                                                dropObj.removeAllFiles();
                                            }
                                        });
                                    });
                                }
                            });
                        }
                    });
                    LIMS.dialog.$set('title', "上传自定义送检单");
                    LIMS.dialog.currentView = 'upload_inspection' + delivery_id;
                },
                save: function (project) {
                    var me = this;
                    jQuery.fn.check_msg({
                        msg: "是否保存当前【" + project.name + "】的实验分析结果？",
                        success: function () {
                            me.$http.post("/distribute/analystSave", {
                                delivery_id: project.delivery.id
                            }).then(function (response) {
                                var data = response.data;
                                jQuery.fn.codeState(data.code, {
                                    200: function () {
                                        jQuery.fn.alert_msg(project.name + "检测结果保存成功!");
                                        me.load_list("", 1);
                                        me.load_projectlist(me.id);
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
                flow: function (task_id, identify) {
                    var me = this;
                    jQuery.fn.check_msg({
                        msg: "您即将进行任务编号为【" + identify + "】的进度流转,是否继续?",
                        success: function () {
                            var data = {
                                task_id: task_id
                            };
                            me.$http.post("/distribute/checkAnalyst", data).then(function (response) {
                                var data = response.data;
                                jQuery.fn.codeState(data.code, {
                                    200: function () {
                                        me.$http.post("/flow/experienceFlow", {id: task_id}).then(function (response) {
                                            var data = response.data;
                                            jQuery.fn.codeState(data.code, {
                                                200: function () {
                                                    jQuery.fn.alert_msg("任务流转成功!");
                                                    me.identify = "";
                                                    me.showTab = false;
                                                    me.load_list("", 1);
                                                }
                                            })
                                        }, function (response) {
                                            jQuery.fn.error_msg("数据异常,无法流转任务,请刷新后重新尝试!");
                                        });
                                    },
                                    504: function () {
                                        jQuery.fn.error_msg("当前任务书尚有未完成的监测项目,任务无法流转!");
                                    }
                                })
                            }, function (response) {
                                jQuery.fn.error_msg("数据异常,无法进行项目流转!");
                            });


                        }
                    })
                },
                view_record_review: function (task_id) {
                    var me = this;
                    var template = jQuery.fn.loadTemplate("/assets/template/subject/originRecord_review_list.tpl");
                    Vue.component('originRecord_review_list' + task_id, {
                        template: template,
                        data: function () {
                            return {
                                result_list: [],
                                nowResult: {},
                                isShow: false,
                                record: {}
                            };
                        },
                        methods: {
                            showInfo: function (record) {
                                var me = this;
                                me.$set("isShow", true);
                                me.$set("record", record);
                            }
                        },
                        ready: function () {
                            var that = this;
                            that.$http.get("/review/getFirstList", {
                                params: {
                                    task_id: task_id
                                }
                            }).then(function (response) {
                                var data = response.data;
                                that.$set("result_list", data.results);
                                that.$set("nowResult", data.nowResult);
                            }, function (response) {
                                jQuery.fn.error_msg("数据异常,无法获取原始记录审核列表!");
                            });
                        }
                    });
                    LIMS.dialog_lg.$set('title', '查看审核记录列表');
                    LIMS.dialog_lg.currentView = 'originRecord_review_list' + task_id;
                },
                view_recordSecond_review: function (task_id) {
                    var me = this;
                    var template = jQuery.fn.loadTemplate("/assets/template/subject/originRecord_secondReview_list.tpl");
                    Vue.component('originRecord_secondReview_list' + task_id, {
                        template: template,
                        data: function () {
                            return {
                                result_list: [],
                                nowResult: {},
                                isShow: false,
                                record: {}
                            };
                        },
                        methods: {
                            showInfo: function (record) {
                                var me = this;
                                me.$set("isShow", true);
                                me.$set("record", record);
                            }
                        },
                        ready: function () {
                            var that = this;
                            that.$http.get("/review/getSecondList", {
                                params: {
                                    task_id: task_id
                                }
                            }).then(function (response) {
                                var data = response.data;
                                that.$set("result_list", data.results);
                                that.$set("nowResult", data.nowResult);
                            }, function (response) {
                                jQuery.fn.error_msg("数据异常,无法获取原始记录审核列表!");
                            });
                        }
                    });
                    LIMS.dialog_lg.$set('title', '查看审核记录列表');
                    LIMS.dialog_lg.currentView = 'originRecord_secondReview_list' + task_id;
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
