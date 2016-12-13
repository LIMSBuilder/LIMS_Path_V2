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
        <h4 class="subtitle mb5">任务类型</h4>
        <div class="rdio rdio-danger">
            <input type="radio" value="0" name="delivery_type" v-model="delivery_type" id="distribute"
                   checked="checked"/>
            <label for="distribute">&nbsp;全部</label>
        </div>
        <div class="rdio rdio-danger">
            <input type="radio" value="1" name="delivery_type" v-model="delivery_type" id="analyst"/>
            <label for="analyst">&nbsp;由我分析</label>
        </div>
        <div class="rdio rdio-danger">
            <input type="radio" value="2" name="delivery_type" v-model="delivery_type" id="assess"/>
            <label for="assess">&nbsp;由我审核</label>
        </div>
        <div class="rdio rdio-danger">
            <input type="radio" value="3" name="delivery_type" v-model="delivery_type" id="review"/>
            <label for="review">&nbsp;由我复核</label>
        </div>
        <div class="rdio rdio-danger">
            <input type="radio" value="4" name="delivery_type" v-model="delivery_type" id="master_review"/>
            <label for="master_review">&nbsp;主任审核</label>
        </div>
        <div class="rdio rdio-danger">
            <input type="radio" value="5" name="delivery_type" v-model="delivery_type" id="quality_review"/>
            <label for="quality_review">&nbsp;质控审核</label>
        </div>
        <div class="mb20"></div>
        <h4 class="subtitle mb5">当前状态</h4>
        <div class="rdio rdio-warning">
            <input type="radio" value="0" name="task_type" v-model="task_type" id="in_process" checked="checked"/>
            <label for="in_process">&nbsp;流程中</label>
        </div>
        <div class="rdio rdio-warning">
            <input type="radio" value="1" name="task_type" v-model="task_type" id="after_process"/>
            <label for="after_process">&nbsp;已结束</label>
        </div>
        <div class="rdio rdio-warning">
            <input type="radio" value="2" name="task_type" v-model="task_type" id="stop_process"/>
            <label for="stop_process">&nbsp;已中止</label>
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
                    project_name: "",//项目名称
                    client_unit: [],//客户单位
                    delivery_type: [],//当前流程
                    task_type: [],//是在实验流程中还是在流程结束了
                    customer_list: [],//客户单位列表
                    result_list: [],//结果集
                    totalRowCount: '',//总共有的结果数
                    searchCondition: []//搜索条件
                }
            },
            methods: {
                search_btn: function () {
                    var me = this;
                    var condition = "identify=" + me.identify + "&&project_name=" + encodeURI(me.project_name) + "&&client_unit=" + encodeURI(me.client_unit) + "&&delivery_type=" + me.delivery_type + "&&task_type=" + me.task_type;
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
                    var me = this;
                    var id = task.id;
                    me.$http.get("/task/getById", {
                        params: {
                            id: id
                        }
                    }).then(function (response) {
                        var data = response.data;
                        var template = jQuery.fn.loadTemplate("/assets/template/subject/process_view.tpl");
                        Vue.component('process_view' + id, {
                            template: template,
                            data: function () {
                                return {
                                    task: data,
                                    state: data.state
                                };
                            },
                            methods: {
                                state: function (process) {
                                    alert(process);
                                }
                            },
                            ready: function () {
                                var me = this;
                            }
                        });
                        LIMS.dialog_lg.$set('title', '项目进度一览表');
                        LIMS.dialog_lg.currentView = 'process_view' + id;
                    }, function (response) {
                        jQuery.fn.error_msg("任务书数据请求异常,请刷新后重新尝试。");
                    });


                },
                load_list: function (condition, currentPage) {
                    var me = this;
                    var dom = jQuery(me.$el);
                    var rowCount = localStorage.getItem("rowCount") || 0;
                    me.$http.get("/task/taskDelvieryList", {
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
                                me.$http.get("/task/taskDelvieryList", {
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
                                    jQuery.fn.error_msg("无法获取任务列表信息,请尝试刷新操作。");
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
                me.load_list("task_type=0", 1);
            }
        });
    });
</script>