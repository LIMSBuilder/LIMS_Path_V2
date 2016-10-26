<div class="row">
    <div class="col-md-12">
        <div class="panel panel-default">
            <div class="panel-body">
                <div class="alert alert-info">
                    <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
                    <strong>推荐操作！</strong> 建议使用"从合同中导入"功能,系统会自动抓取合同中已经设置的信息并自动填充至任务书中。
                </div>
                <div class="col-md-11">
                    <form class="form-horizontal ">
                        <div class="form-group ">

                            <label class="col-sm-2 control-label ">委托单位</label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control" v-model="client_unit">
                            </div>
                            <div class="col-sm-2">
                                <a class="btn btn-sm btn-success-alt pull-right" data-toggle="modal"
                                   data-target=".bs-example-modal-lg" @click="from_contract">从现有合同导入</a>
                            </div>


                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">项目名称</label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control" v-model="project_name">
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
                                <input type="text" class="form-control" v-model="client_address">
                            </div>
                            <label class="col-sm-1 control-label">邮政编码</label>
                            <div class="col-sm-3">
                                <input type="text" class="form-control" v-model="client_code">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">联系人</label>
                            <div class="col-sm-4">
                                <input type="text" class="form-control" v-model="client">
                            </div>
                            <label class="col-sm-1 control-label">联系电话</label>
                            <div class="col-sm-3">
                                <input type="text" class="form-control" v-model="client_tel">
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
                                    <input type="radio" v-model="monitor_way" checked id="way1" value="0"
                                           name="gender" required/>
                                    <label for="way1">以我单位通过计量认证、国家实验室认可的方法进行检测</label>
                                </div>
                                <div class="rdio rdio-primary">
                                    <input type="radio" v-model="monitor_way" value="1" id="way2"
                                           name="gender"/>
                                    <label for="way2">客户指定的方法:</label>
                                    <input type="text" v-model="monitor_way_desp" name="monitor_way_desp"
                                           class="form-control " disabled/>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">承接科室</label>
                            <div class="col-sm-8">
                                <select class="select2" v-model="receive_depart" id="receive_depart"
                                        data-placeholder="选择交付方式"
                                        required>
                                    <template v-for="item in receive_depart_list">
                                        <option value="{{item.id}}">{{item.name}}</option>
                                    </template>
                                </select>
                                <span class="help-block">承接科室设定项目流程的走向,管理员可以在"系统设置"->"承接科室设置"中进行流程修改。</span>
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
                "receive_depart": "",
                "other": "",
                "receive_depart_list": []
            },
            methods: {
                from_customer: function () {
                    var me = this;
                    me.$http.get("/assets/json/customer_select_list.json").then(function (response) {
                        var data = response.data;
                        var template = jQuery.fn.loadTemplate("/assets/template/subject/customer_select_list.tpl");

                        Vue.component('child', {
                            template: template,
                            data: function () {
                                return {customers: data.results};
                            },
                            methods: {
                                startSearch: function (event) {
                                    //向服务器发送查询请求
                                    alert("触发了enter操作");
                                },
                                choose: function (data) {
                                    //console.log(data)
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
                                }
                            }
                        });
                        LIMS.dialog.$set('title', '从客户管理系统中导入');
                        LIMS.dialog.currentView = 'child';
                    }, function (response) {
                        //error
                        jQuery.fn.error_msg("客户资料获取失败！");
                    });
                },
                from_contract: function () {
                    var me = this;
                    me.$http.get("/assets/json/contract_search_result.json").then(function (response) {
                        var data = response.data;
                        var template = jQuery.fn.loadTemplate("/assets/template/subject/contract_select_list.tpl");
                        Vue.component('child', {
                            template: template,
                            data: function () {
                                return {result_list: data.results};
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
                                show_info: function () {
                                    jQuery("#custom_lg_modal").modal("hide");
                                    me.$http.get("/assets/json/contract_template.json").then(function (response) {
                                        var data = response.data;
                                        var template = jQuery.fn.loadTemplate("/assets/template/subject/contract_view.tpl");
                                        Vue.component('view_contract' + data.id, {
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
                                        LIMS.dialog.$set('title', '从客户管理系统中导入');
                                        LIMS.dialog.currentView = 'view_contract' + data.id;
                                    }, function (response) {
                                        //error
                                        jQuery.fn.error_msg("客户资料获取失败！");
                                    });


                                    jQuery("#custom_modal").modal("show");


                                    return;
                                }
                            }
                        });
                        LIMS.dialog_lg.$set('title', '合同预览');
                        LIMS.dialog_lg.currentView = 'child';
                    }, function (response) {
                        //error
                        jQuery.fn.error_msg("客户资料获取失败！");
                    });


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
                                    monitor_type_item: data.monitor_type_item,
                                    frequency_item: data.frequency_item
                                }
                            },
                            methods: {
                                save: function () {
                                    var dom = $(this.$el);
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
                                var dom = $(this.$el);
                                dom.find('.select2').select2({
                                    width: '100%',
                                    minimumResultsForSearch: -1
                                });
                                dom.find('#tags').tagsInput({
                                    width: 'auto',
                                    defaultText: '增加...'
                                });
                                dom.find('select[name=environment]').on("change", function (event) {
                                    var id = event.val;
                                    var items = data.monitor_type_item.find(function (item) {
                                        return item.id == id;
                                    });
                                    var oSelect = jQuery("#monitor_item");
                                    oSelect.find('option').remove();
                                    items.items.forEach(function (item) {
                                        console.log(item);
                                        oSelect.append("<option value='" + item.id + "'>" + item.name + "</option>");
                                    });
                                    $('#monitor_item').trigger("change");
                                })
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
                dom.find('.select2').select2({
                    width: '100%',
                    minimumResultsForSearch: -1
                });
                this.$watch('monitor_way', function (val) {
                    if (this.monitor_way == 0) {
                        dom.find('input[name=monitor_way_desp]').prop("disabled", true);
                    } else {
                        dom.find('input[name=monitor_way_desp]').prop("disabled", false);
                    }
                });


                jQuery('#receive_depart').on("change", function () {
                    me.$set("receive_depart", jQuery("#receive_depart").val());
                });


                me.$http.get("/assets/json/task_receive_deaprt.json").then(function (response) {
                    var data = response.data;
                    me.$set('receive_depart_list', data.results);
                }, function (response) {
                    jQuery.fn.error_msg("无法获取承接科室信息!");
                })


            }


        });

    });


</script>