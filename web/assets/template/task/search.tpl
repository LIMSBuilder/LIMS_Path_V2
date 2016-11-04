<div class="row">
    <div class="col-sm-4 col-md-3">
        <h4 class="subtitle mb5">任务书(合同)编号</h4>
        <input type="text" value="" v-model="identify" placeholder="请输入任务书编号或者合同编号" class="form-control"/>
        <div class="mb20"></div>
        <h4 class="subtitle mb5">项目名称</h4>
        <input type="text" value="" v-model="project_name" placeholder="请输入项目关键字" class="form-control"/>
        <div class="mb20"></div>
        <h4 class="subtitle mb5">客户单位</h4>
        <input type="text" value="" v-model="client_unit" placeholder="请输入客户单位关键字" class="form-control"/>
        <div class="mb20"></div>
        <h4 class="subtitle mb5">采样方式</h4>
        <div class="ckbox ckbox-primary">
            <input type="checkbox" value="0" name="sample_type" v-model="sample_type" id="self" checked="checked"/>
            <label for="self">自送样（接收部门：{{self_depart.name}})</label>
        </div>
        <div class="ckbox ckbox-primary">
            <input type="checkbox" value="1" name="sample_type" v-model="sample_type" id="spot" checked="checked"/>
            <label for="spot">现场采样（接收部门：{{scene_depart.name}}）</label>
        </div>

        <div class="mb20"></div>
        <h4 class="subtitle mb5">任务书创建起始时间</h4>
        <div class="input-group">
            <input type="text" v-model="search_createTime_start" class="form-control" placeholder="mm/dd/yyyy"
                   id="date_start">
            <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
        </div>

        <h4 class="subtitle mb5">任务书创建结束时间</h4>
        <div class="input-group">
            <input type="text" v-model="search_createTime_end" class="form-control" placeholder="mm/dd/yyyy"
                   id="date_end">
            <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
        </div>

        <div class="mb20"></div>
        <div class="input-group ">
            <a class="btn btn-primary" @click="search_btn">搜 索</a>
        </div>

        <br/>

    </div><!-- col-sm-4 -->
    <div class="col-sm-8 col-md-9">
        <div class="panel panel-default">
            <div class="panel-heading">
                <div class="paging nomargin pull-right"></div>
                <h4 class="panel-title" v-if="searchCondition.length == 0">任务书列表</h4>
                <h4 class="panel-title" v-else>“
                    <template v-for="search in searchCondition">
                        {{ search }}
                    </template>
                    ”的搜索结果
                </h4>
                <p>共有 {{totalRowCount}} 个结果。</p>
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
                                    <a class="btn btn-default-alt" data-toggle="modal"
                                       data-target=".bs-example-modal-lg" @click="view_info(result)">查看详情</a>
                                    <a class="btn btn-info-alt" data-toggle="modal"
                                       data-target=".bs-example-modal-lg" @click="view_process(result)">流程查询</a>
                                </div>
                                <h4 class="filename text-primary">{{result.project_name}}</h4>
                                <small class="text-muted">合同编号: {{result.identify}}</small>
                                <br/>
                                <small class="text-muted">监测类型: {{result.monitor_type}}</small>
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
</div><!-- row -->

<script src="/assets/js/jquery-ui-1.10.3.min.js"></script>
<!--<script src="/assets/js/select2.min.js"></script>-->

<script>
    jQuery(document).ready(function () {
        "use strict";
        var vue = new Vue({
            el: '#contentpanel',
            data: function () {
                return {
                    identify: "",
                    monitor_type: [],//监测类别
                    project_name: "",//项目名称
                    client_unit: [],//客户单位
                    monitor_type_selected: [],//
                    search_createTime_start: '',//创建开始时间
                    search_createTime_end: '',//创建结束时间
                    sample_type: [],
                    customer_list: [],//客户单位列表
                    result_list: [],//结果集
                    totalRowCount: '',//总共有的结果数
                    searchCondition: [],//搜索条件

                    "self_depart": "",
                    "scene_depart": "",
                    "self_role": "",
                    "scene_role": ""

                }
            },
            methods: {
                search_btn: function () {
                    var me = this;
                    var condition = "identify=" + me.identify + "&&project_name=" + encodeURI(me.project_name) + "&&client_unit=" + encodeURI(me.client_unit) + "&&search_createTime_start=" + me.search_createTime_start + "&&search_createTime_end=" + me.search_createTime_end + "&&sample_type=" + me.sample_type;
                    me.load_list(condition, 1);
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
                        Vue.component('contract_view' + id, {
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
                        LIMS.dialog_lg.currentView = 'contract_view' + id;
                    }, function (response) {
                        jQuery.fn.error_msg("任务书数据请求异常,请刷新后重新尝试。");
                    });
                },
                view_process: function (task) {
                    var id = task.id;
                    jQuery.fn.alert_msg("查看流程功能即将上线");
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
                        me.$set("totalRowCount", data.totalRowCount);
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
                                    me.$set("totalRowCount", data.totalRowCount);
                                }, function (response) {
                                    jQuery.fn.error_msg("无法获取合同列表信息,请尝试刷新操作。");
                                });
                            }
                        });
                        jQuery.validator.setDefaults({
                            submitHandler: function () {
                            }
                        });
                    }, function (response) {
                        jQuery.fn.error_msg("无法获取用户列表信息,请尝试刷新操作。");
                    });
                }
            },
            ready: function () {
                var me = this;
                jQuery('#slider').slider({
                    range: "min",
                    max: 100,
                    value: 50
                });

                // Date Picker
                jQuery('#date_start').datepicker();
                jQuery('#date_end').datepicker();

                me.$http.get("/constarct/monitorType").then(function (response) {
                    var data = response.data;
                    var arr = [];
                    for (var key in data) {
                        arr.push(key);
                    }
                    me.$set('monitor_type', arr);
                }, function (response) {
                    jQuery.fn.error_msg("获取监测类型列表失败！");
                });

                me.$http.get("/properties/getReceiveInfo").then(function (response) {
                    var data = response.data;
                    me.$set("self_depart", data.sample_self ? data.sample_self : {name: "尚未设置"});
                    me.$set("scene_depart", data.sample_scene ? data.sample_scene : {name: "尚未设置"});
                    me.$set("self_role", data.sample_self_role ? data.sample_self_role : {name: "尚未设置"});
                    me.$set("scene_role", data.sample_scene_role ? data.sample_scene_role : {name: "尚未设置"});
                }, function (response) {
                    jQuery.fn.error_msg("无法获取承接科室信息!");
                });
                me.load_list("", 1);
            }
        });
    });
</script>