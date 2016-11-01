<div class="row">
    <div class="col-sm-12 col-md-12">
        <div class="panel panel-default">
            <div class="panel-heading">
                <div class="paging nomargin pull-right"></div>
                <h4 class="panel-title">待审核合同</h4>
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
                                <a class="btn btn-success-alt pull-right" data-toggle="modal"
                                   data-target=".bs-example-modal-lg" @click="view_info(result)">合同审核</a>
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
<script>
    jQuery(document).ready(function () {
        "use strict";
        var vue = new Vue({
            el: '#contentpanel',
            data: function () {
                return {
                    result_list: [],//结果集
                    totalRowCount: ''//总共有的结果数
                }
            },
            methods: {
                view_info: function (contract) {
                    var me = this;
                    var id = contract.id;
                    me.$http.get("/constarct/getById", {
                        params: {
                            id: id
                        }
                    }).then(function (response) {
                        var data = response.data;
                        var template = jQuery.fn.loadTemplate("/assets/template/subject/contract_view.tpl");
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
                                    client_fax: "",
                                    trustee_unit: "",
                                    trustee_code: "",
                                    trustee_address: "",
                                    trustee_tel: "",
                                    trustee: "",
                                    trustee_fax: "",
                                    project_name: "",
                                    monitor_aim: "",
                                    monitor_type: "",
                                    monitor_way: "",
                                    monitor_way_desp: "",
                                    subpackage: "",
                                    subpackage_project: "",
                                    item_arr: [],
                                    payment_way: "",
                                    finish_date: "",
                                    payment_count: "",
                                    in_room: "",
                                    keep_secret: "",
                                    other: ""
                                };
                            },
                            methods: {
                                pass: function (data) {
                                    var that = this;
                                    jQuery("#custom_lg_modal").modal("hide");
                                    jQuery.fn.check_msg({
                                        msg: "是否将编号为<span style='font-weight: bolder'>" + that.identify + "</span>的合同标记为<span class='text-success'>【审核通过】</span>?",
                                        success: function () {
                                            me.$http.post("/constarct/review", {
                                                id: id,
                                                state: 1
                                            }).then(function (response) {
                                                var data = response.data;
                                                jQuery.fn.codeState(data.code, {
                                                    200: function () {
                                                        jQuery.fn.alert_msg("合同审核完成!");
                                                        var currentPage = parseInt(jQuery('.paging span').html());
                                                        me.load_list("state=0", currentPage);
                                                    }
                                                });
                                            }, function (response) {
                                                jQuery.fn.error_msg("合同数据请求异常,请刷新后重新尝试。");
                                            });
                                        }
                                    });
                                },
                                reject: function () {
                                    var that = this;
                                    jQuery("#custom_lg_modal").modal("hide");
                                    jQuery.fn.check_msg({
                                        msg: "是否将编号为<span style='font-weight: bolder'>" + that.identify + "</span>的合同标记为<span class='text-danger'>【审核拒绝】</span>?",
                                        success: function () {
                                            me.$http.post("/constarct/review", {
                                                id: id,
                                                state: -4
                                            }).then(function (response) {
                                                var data = response.data;
                                                jQuery.fn.codeState(data.code, {
                                                    200: function () {
                                                        jQuery.fn.alert_msg("合同审核完成!");
                                                        var currentPage = parseInt(jQuery('.paging span').html());
                                                        me.load_list("state=0", currentPage);
                                                    }
                                                });
                                            }, function (response) {
                                                jQuery.fn.error_msg("合同数据请求异常,请刷新后重新尝试。");
                                            });
                                        }
                                    });
                                }
                            },
                            ready: function () {
                                var me = this;
                                var result = data.results[0];
                                var items = data.items;
                                for (var key in result) {
                                    if (me[key] != undefined) {
                                        me.$set(key, result[key]);
                                    }
                                }
                                me.$set("item_arr", items);
                                me.$set("trustee", data.trustee.name);
                            }
                        });
                        LIMS.dialog_lg.$set('title', '查看合同详情');
                        LIMS.dialog_lg.currentView = 'contract_view' + id;
                    }, function (response) {
                        jQuery.fn.error_msg("合同数据请求异常,请刷新后重新尝试。");
                    });
                },
                load_list: function (condition, currentPage) {
                    var me = this;
                    var dom = jQuery(me.$el);
                    var rowCount = localStorage.getItem("rowCount") || 0;
                    me.$http.get("/constarct/list", {
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
                                me.$http.get("/constarct/list", {
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
                me.load_list("state=0", 1);
            }
        });
    });
</script>