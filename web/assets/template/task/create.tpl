<div class="row">
    <div class="col-md-12">
        <div class="panel panel-default">
            <div class="panel-body">
                <div class="alert alert-info">
                    <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
                    <strong>推荐操作！</strong> 建议使用"从合同中导入"功能,系统会自动抓取合同中已经设置的信息并自动填充至任务书中。
                </div>
                <div class="col-md-11">
                    <form class="form-horizontal" id="task_form">
                        <div class="form-group ">
                            <label class="col-sm-2 control-label ">委托单位</label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control" name="client_unit" v-model="client_unit"
                                       required>
                            </div>
                            <div class="col-sm-2">
                                <a class="btn btn-sm btn-success-alt pull-right" data-toggle="modal"
                                   data-target=".bs-example-modal-lg" @click="from_contract">从现有合同导入</a>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">项目名称</label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control" name="project_name" v-model="project_name"
                                       required>
                            </div>
                            <div class="col-sm-2">
                                <a class="btn btn-sm btn-success-alt pull-right" data-toggle="modal"
                                   data-target=".bs-example-modal-static" @click="from_customer">从客户资料导入</a>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">监测目的</label>
                            <div class="col-sm-8">
                                <textarea class="form-control" rows="5" v-model="monitor_aim"></textarea>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">联系地址</label>
                            <div class="col-sm-4">
                                <input type="text" class="form-control" name="client_address" v-model="client_address"
                                       required>
                            </div>
                            <label class="col-sm-1 control-label">邮政编码</label>
                            <div class="col-sm-3">
                                <input type="text" class="form-control" name="client_code" v-model="client_code"
                                       required>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">联系人</label>
                            <div class="col-sm-4">
                                <input type="text" class="form-control" name="client" v-model="client" required>
                            </div>
                            <label class="col-sm-1 control-label">联系电话</label>
                            <div class="col-sm-3">
                                <input type="text" class="form-control" name="client_tel" v-model="client_tel"
                                       requireds>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">监测内容</label>
                            <div class="col-sm-8">
                                <div class="table-responsive">
                                    <table class="table table-info mb30">
                                        <thead>
                                        <tr>
                                            <th class="text-center">序号</th>
                                            <th class="text-center">环境要素</th>
                                            <th class="text-center">监测点(个)</th>
                                            <th class="text-center">监测项目</th>
                                            <th class="text-center">监测频次</th>
                                            <th class="text-center">备注</th>
                                            <th class="text-center"></th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <template v-for="(index,item) in item_arr">
                                            <tr>
                                                <td class="text-center">{{index+1}}</td>
                                                <td class="text-center">
                                                    {{item.environment_text}}
                                                </td>
                                                <td class="text-center">{{item.monitor_point}}</td>
                                                <td class="text-center">
                                                    <template v-for="item in item.monitor_item_text">
                                                        {{item.name}}
                                                    </template>
                                                </td>
                                                <td class="text-center">{{item.frequency}}</td>
                                                <td class="text-center">{{item.other}}</td>
                                                <td class="table-action">

                                                    <a v-if="index!=0" href="javascript:;"
                                                       @click="sort_up(index)"><i
                                                            class="fa fa-arrow-up"></i></a>
                                                    <a v-if="index!=item_arr.length-1" href="javascript:;"
                                                       @click="sort_down(index)"><i
                                                            class="fa fa-arrow-down"></i></a>
                                                    <a href="javascript:;" @click="delete_item(item)"><i
                                                            class="fa fa-trash-o"></i></a>
                                                </td>
                                            </tr>
                                        </template>
                                        <tr>
                                            <td class="table-action" colspan="7">
                                                <a href="javascript:;" v-on:click="addItem" data-toggle="modal"
                                                   data-target=".bs-example-modal-static"><i
                                                        class="fa fa-plus"></i> 新增</a>
                                            </td>
                                        </tr>
                                        </tbody>
                                    </table>
                                </div><!-- table-responsive -->
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">监测方法</label>
                            <div class="col-sm-8">
                                <div class="rdio rdio-primary">
                                    <input type="radio" v-model="monitor_way" checked="checked" id="way1" value="0"
                                           name="monitor_way"/>
                                    <label for="way1">以我单位通过计量认证、国家实验室认可的方法进行检测</label>
                                </div>
                                <div class="rdio rdio-primary">
                                    <input type="radio" v-model="monitor_way" value="1" id="way2"
                                           name="monitor_way"/>
                                    <label for="way2">客户指定的方法:</label>
                                    <input type="text" v-model="monitor_way_desp" name="monitor_way_desp"
                                           class="form-control " disabled/>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">采样方式</label>
                            <div class="col-sm-8">
                                <div class="rdio rdio-primary">
                                    <input type="radio" v-model="sample_way" checked="checked" id="self" value="0"
                                           name="sample_way"/>
                                    <label for="self">自送样（接收部门：{{self_depart}}）</label>
                                </div>
                                <div class="rdio rdio-primary">
                                    <input type="radio" v-model="sample_way" value="1" id="spot"
                                           name="sample_way"/>
                                    <label for="spot">现场采样（接收部门：{{scene_depart}}）</label>
                                </div>
                            </div>
                        </div>


                        <div class="form-group">
                            <label class="col-sm-2 control-label">备注信息</label>
                            <div class="col-sm-8">
                                <textarea class="form-control" v-model="other" rows="5"></textarea>
                            </div>
                        </div>
                        <div class="form-group text-center">
                            <a class="btn btn-primary" @click="create_task">创 建</a>
                            <a class="btn btn-default @click=clear_sumbit">清 空</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    jQuery(document).ready(function () {
        var vue = new Vue({
            el: "#contentpanel",
            data: {
                "client_unit": "",
                "project_name": "",
                "monitor_aim": "",
                "client_address": "",
                "client_code": "",
                "client": "",
                "client_tel": "",
                "monitor_way": 0,
                "item_arr": [],
                "monitor_way_desp": "",
                "other": "",
                "sample_way": "",
                "self_depart": "",
                "scene_depart": ""
            },
            methods: {
                from_customer: function () {
                    var me = this;
                    var template = jQuery.fn.loadTemplate("/assets/template/subject/customer_select_list.tpl");
                    Vue.component('child', {
                        template: template,
                        data: function () {
                            return {
                                customers: [],
                                search_key: ""
                            };
                        },
                        methods: {
                            startSearch: function (event) {
                                var me = this;
                                me.load_list("client_unit=" + encodeURI(me.search_key), 1);
                            },
                            choose: function (data) {
                                var customer = data.customer;
                                jQuery("#custom_modal").modal("hide");
                                jQuery.fn.check_msg({
                                    msg: "是否导入【" + customer.client_unit + "】公司的客户资料?",
                                    success: function () {
                                        for (var key in customer) {
                                            me.$set(key, customer[key]);
                                        }

                                    }
                                });
                            },
                            load_list: function (condition, currentPage) {
                                var me = this;
                                var dom = jQuery(me.$el);
                                var rowCount = localStorage.getItem("rowCount") || 0;
                                me.$http.get("/customer/list", {
                                    params: {
                                        rowCount: rowCount,
                                        currentPage: currentPage,
                                        condition: condition
                                    }
                                }).then(function (response) {
                                    var data = response.data;
                                    me.$set("customers", data.results);
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
                                            me.$http.get("/customer/list", {
                                                params: {
                                                    rowCount: rowCount,
                                                    currentPage: currentPage,
                                                    condition: data.condition
                                                }
                                            }).then(function (response) {
                                                var data = response.data;
                                                me.$set("customers", data.results);
                                            }, function (response) {
                                                jQuery.fn.error_msg("无法获取客户列表信息,请尝试刷新操作。");
                                            });
                                        }
                                    });
                                    jQuery.validator.setDefaults({
                                        submitHandler: function () {
                                        }
                                    });
                                }, function (response) {
                                    jQuery.fn.error_msg("无法获取客户列表信息,请尝试刷新操作。");
                                });

                            }
                        },
                        ready: function () {
                            var me = this;
                            me.load_list("", 1);
                        }
                    });
                    LIMS.dialog.$set('title', '从客户管理系统中导入');
                    LIMS.dialog.currentView = 'child';
                },
                from_contract: function () {
                    var me = this;
                    var template = jQuery.fn.loadTemplate("/assets/template/subject/task_fromContract.tpl");
                    Vue.component('child', {
                        template: template,
                        data: function () {
                            return {
                                result_list: [],//结果集
                                totalRowCount: ''//总共有的结果数
                            };
                        },
                        methods: {
                            import_into: function (data) {
                                console.log(data.id);
                                me.$http.get("/assets/json/contract_template.json").then(function (response) {
                                    var data = response.data;
                                    for (var key in data) {
                                        if (me[key] != undefined) {
                                            me.$set(key, data[key]);
                                        }
                                    }
                                    jQuery('#custom_lg_modal').modal("hide");
                                    jQuery.fn.alert_msg("合同导入成功！");

                                }, function (response) {

                                })
                            },
                            view_info: function (contract) {
                                var me = this;
                                var id = contract.id;
                                me.$http.get("/constarct/getById", {
                                    params: {
                                        id: id
                                    }
                                }).then(function (response) {
                                    var data = response.data;
                                    var template = jQuery.fn.loadTemplate("/assets/template/subject/contract_review.tpl");
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
                                                                    me.load_list("state=1", currentPage);
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
                                                                    me.load_list("state=1", currentPage);
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
                                    jQuery.fn.error_msg("无法获取合同列表信息,请尝试刷新操作。");
                                });
                            }
                        },
                        ready: function () {
                            var me = this;
                            me.load_list("state=1", 1);
                        }
                    });
                    LIMS.dialog_lg.$set('title', '合同预览');
                    LIMS.dialog_lg.currentView = 'child';
                },
                /**
                 * 增加检测项
                 */
                addItem: function () {
                    var me = this;
                    me.$http.get("/assets/json/contract_addItem.json").then(function (response) {

                        var data = response.data;
                        var template = jQuery.fn.loadTemplate("/assets/template/subject/contract_monitor_addItem.tpl");

                        Vue.component("addItem", {
                            template: template,
                            data: function () {
                                return {
                                    environment: "",
                                    monitor_point: "",
                                    monitor_type: "",
                                    monitor_item: "",
                                    frequency: "",
                                    other: "",
                                    monitor_type_item: [],
                                    frequency_item: [],
                                    monitor_project_item: []
                                }
                            },
                            methods: {
                                save: function () {
                                    var dom = $(this.$el);
                                    if (!jQuery("#monitor_addItem").valid())return;
                                    var items = [];
                                    dom.find('#monitor_item option:selected').each(function (index, item) {
                                        var dom = jQuery(item);
                                        var temp = {
                                            id: dom.attr("value"),
                                            name: dom.html()
                                        };
                                        items.push(temp);
                                    });

                                    var data = {
                                        environment: dom.find("select[name=environment]").val(),
                                        environment_text: dom.find("select[name=environment] option:selected").html(),
                                        monitor_point: dom.find("#tags").val(),
                                        monitor_item: dom.find("#monitor_item").val(),
                                        monitor_item_text: items,
                                        frequency: dom.find("select[name=frequency]").val(),
                                        other: this.other
                                    };
                                    console.log(data);
                                    me.item_arr.push(data);
                                    jQuery("#monitor_addItem")[0].reset();
                                    jQuery("#monitor_addItem .select2").val("").trigger("change");
                                    jQuery("#tags").removeTag("");
                                    jQuery.fn.alert_msg("检测项保存成功!");

                                },

                                cancel: function () {
                                    jQuery("#custom_modal").modal("hide");
                                }
                            },
                            ready: function () {
                                var me = this;
                                var dom = $(me.$el);
                                dom.find('.select2').select2({
                                    width: '100%',
                                    minimumResultsForSearch: -1
                                });
                                dom.find('#tags').tagsInput({
                                    width: 'auto',
                                    defaultText: '增加...'
                                });
                                me.$http.get("/category/getList").then(function (res) {
                                    var results = res.data.results;
                                    me.$set("monitor_type_item", results);
                                }, function (response) {
                                    jQuery.fn.error_msg("无法获取环境要素列表信息,请尝试刷新操作。");
                                });
                                me.$http.get("/frequency/getList").then(function (response) {
                                    var data = response.data;
                                    me.$set("frequency_item", data);
                                }, function (response) {
                                    jQuery.fn.error_msg("无法获取监测频次列表信息,请尝试刷新操作。");
                                });


                                dom.find('select[name=environment]').on("change", function (event) {
                                    var id = event.val;
                                    if (!id) return;
                                    me.$http.get("/project/getByCategory", {
                                        params: {
                                            id: id
                                        }
                                    }).then(function (response) {
                                        var data = response.data;
                                        me.$set("monitor_project_item", data.results);
                                        console.log(data)
                                    }, function (response) {
                                        jQuery.fn.error_msg("无法获取监测项目列表信息,请尝试刷新操作。");
                                    })
                                });

                                jQuery("#monitor_addItem").validate({
                                    highlight: function (element) {
                                        jQuery(element).closest('.form-group').removeClass('has-success').addClass('has-error');
                                    },
                                    success: function (element) {
                                        jQuery(element).closest('.form-group').removeClass('has-error');
                                    }
                                });


                            }
                        });


                        LIMS.dialog.$set('title', '设置项目检测项');
                        LIMS.dialog.currentView = 'addItem';
                    }, function (response) {

                    });
                },
                create_task: function () {
                    var me = this;
                    jQuery.fn.check_msg({
                        msg: "是否创建任务书并进入项目流程?",
                        success: function () {
                            console.log(JSON.parse(JSON.stringify(me._data)));
                        }
                    })
                },
                clear_sumbit: function () {
                    alert("取消");
                }
            },
            ready: function () {
                var me = this;
                var dom = $(this.$el);
                this.$watch('monitor_way', function (val) {
                    if (this.monitor_way == 0) {
                        dom.find('input[name=monitor_way_desp]').prop("disabled", true);
                        me.$set("monitor_way_desp", "");

                    } else {
                        dom.find('input[name=monitor_way_desp]').prop("disabled", false);
                    }
                });

                me.$http.get("/department/getSampleReceive").then(function (response) {
                    var data = response.data;
                    var self = data.sample_self ? data.sample_self[0].name : "您尚未设置自送样接收部门";
                    var scene = data.sample_scene ? data.sample_scene[0].name : "您尚未设置现场采样接收部门";
                    me.$set("self_depart", self);
                    me.$set("scene_depart", scene);
                }, function (response) {
                    jQuery.fn.error_msg("无法获取承接科室信息!");
                });
                jQuery("#task_form").validate({
                    highlight: function (element) {
                        jQuery(element).closest('.form-group').removeClass('has-success').addClass('has-error');
                    },
                    success: function (element) {
                        jQuery(element).closest('.form-group').removeClass('has-error');
                    }
                });


            }


        });

    });


</script>