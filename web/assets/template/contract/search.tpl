<div class="row">
    <div class="col-sm-4 col-md-3">
        <h4 class="subtitle mb5">项目名称</h4>
        <input type="text" value="" v-model="search_projectName" placeholder="请输入项目关键字" class="form-control"/>

        <div class="mb20"></div>

        <h4 class="subtitle mb5">客户单位</h4>
        <select class="select2" v-model="search_customer" name="search_customer" multiple
                data-placeholder="选择一个或多个客户单位...">
            <template v-for="item in customer_list">
                <option value="{{item.id}}">{{item.client_unit}}</option>
            </template>

        </select>

        <div class="mb20"></div>

        <h4 class="subtitle mb5">监测类型</h4>
        <ul class="nav nav-sr">
            <li v-for="type in monitor_type">
                <div class="ckbox ckbox-success">
                    <input type="checkbox" name="monitor_type" value="{{type.id}}" id="checkbox_{{type.id}}">
                    <label for="checkbox_{{type.id}}">{{type.name}}</label>
                </div>
            </li>
        </ul>

        <div class="mb20"></div>

        <h4 class="subtitle mb5">合同创建起始时间</h4>
        <div class="input-group">
            <input type="text" v-model="search_createTime_start" class="form-control" placeholder="mm/dd/yyyy"
                   id="date_start">
            <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
        </div>

        <h4 class="subtitle mb5">合同创建结束时间</h4>
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
                <h4 class="panel-title" v-if="searchCondition.length == 0">全部合同</h4>
                <h4 class="panel-title" v-else>“
                    <template v-for="search in searchCondition">
                        {{ search }}
                    </template>
                    ”的搜索结果
                </h4>
                <p>共有 {{totalRowCount}} 个结果 ({{searchCost}} 秒)</p>
            </div><!-- panel-heading -->
            <div class="panel-body">
                <div class="results-list">
                    <template v-for="result in result_list">
                        <div class="media">
                            <a href="javascript:;" class="pull-left">
                                <img alt="" src="/assets/images/photos/contract.png" class="media-object">
                            </a>
                            <div class="media-body">
                                <a class="btn btn-default-alt pull-right" data-toggle="modal"
                                   data-target=".bs-example-modal-lg" @click="view_info(result)">查看详情</a>
                                <h4 class="filename text-primary">{{result.title}}</h4>
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
<script src="/assets/js/select2.min.js"></script>

<script>
    jQuery(document).ready(function () {
        "use strict";
        var vue = new Vue({
            el: '#contentpanel',
            data: function () {
                return {
                    monitor_type: [],
                    search_projectName: '',
                    search_customer: [],
                    search_type: [],
                    search_createTime_start: '',
                    search_createTime_end: '',
                    customer_list: [],
                    result_list: [],
                    totalRowCount: '',
                    searchCost: '',
                    searchCondition: []

                }
            },
            methods: {
                search_by_type: function (type) {
                    console.log(type);
                },
                search_btn: function () {
                    var me = this;
                    var search_type = [];
                    jQuery('input[name=monitor_type]:checked').each(function (index, item) {
                        me.search_type.push(item.value);
                    });
                    jQuery('select[name=search_customer] option:selected').each(function (index, item) {
                        me.search_customer.push(item.value);
                    });
                    console.log(JSON.parse(JSON.stringify(this._data)));
                },
                view_info: function (data) {
                    var me = this;
                    me.$http.get("/assets/json/contract_create.json").then(function (response) {
                        var data = response.data;
                        var template = jQuery.fn.loadTemplate("/assets/template/subject/contract_view.tpl");
                        Vue.component('contract_view', {
                            template: template,
                            data: function () {
                                return {
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
                            methods: {},
                            ready: function () {
                                for (var key in data) {
                                    this.$set(key, data[key]);
                                }
                            }
                        });
                        LIMS.dialog_lg.$set('title', '查看合同详情');
                        LIMS.dialog_lg.currentView = 'contract_view';
                    }, function (response) {
                        jQuery.fn.error_msg("合同数据请求异常,请刷新后重新尝试。");
                    });


                }
            },
            ready: function () {
                var me = this;
                // Basic Slider
                jQuery('#slider').slider({
                    range: "min",
                    max: 100,
                    value: 50
                });

                jQuery(".select2").select2({
                    width: '100%'
                });

                // Date Picker
                jQuery('#date_start').datepicker();
                jQuery('#date_end').datepicker();

                this.$http.get("/assets/json/contract_monitorType.json").then(function (response) {
                    var data = response.data;
                    me.$set('monitor_type', data.results);
                }, function (response) {
                    jQuery.fn.error_msg("获取监测类型列表失败！");
                });

                this.$http.get("/assets/json/customer_select_total.json").then(function (response) {
                    var data = response.data;
                    me.$set("customer_list", data.results);
                }, function (response) {
                    jQuery.fn.error_msg("获取客户信息列表失败！");
                });

                this.$http.get("/assets/json/contract_search_result.json").then(function (response) {
                    var data = response.data;
                    me.$set("totalRowCount", data.totalRowCount);
                    me.$set("result_list", data.results);
                    me.$set("searchCost", data.searchCost);
                    data.searchCondition.forEach(function (search) {
                        me.searchCondition.push(search);
                    });


                    $('.paging').pagination({
                        pageCount: data.pageCount,
                        coping: true,
                        homePage: '首页',
                        endPage: '末页',
                        prevContent: '上页',
                        nextContent: '下页',
                        current: data.currentPage,
                        callback: function (page) {
                            console.log(page.getCurrent());
                        }
                    });

                }, function (response) {
                    jQuery.fn.error_msg("数据请求异常,请刷新后重新尝试。");
                });
            }
        });
    });
</script>