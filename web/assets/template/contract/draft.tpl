<div class="panel panel-info">
    <div class="panel-heading">
        <h3 class="panel-title">模板合同列表</h3>
    </div>
    <div class="panel-body">
        <div class="table-responsive">
            <table class="table table-hidaction table-hover mb30">
                <thead>
                <tr>
                    <th class="text-center">编号</th>
                    <th class="text-center">模板名称</th>
                    <th class="text-center">创建时间</th>
                    <th class="text-center"></th>
                </tr>
                </thead>
                <tbody>
                <template v-for="(index,item) in result">
                    <tr>
                        <td class="text-center">{{index+1}}</td>
                        <td class="text-center">{{item.name}}</td>
                        <td class="text-center">{{item.create_time}}</td>
                        <td class="table-action">
                            <a href="javascript:;" @click="change_item(item)" data-toggle="modal"
                               data-target=".bs-example-modal-lg"><i class="fa fa-pencil"></i></a>
                            <a href="javascript:;" @click="stop_item(item)"><i class="fa fa-trash-o"></i></a>
                        </td>
                    </tr>
                </template>

                </tbody>
            </table>
        </div><!-- table-responsive -->
        <div class="row">
            <div class="col-md-12 ">
                <div class="paging pull-right"></div>
            </div>

        </div>
    </div>
</div><!-- panel -->

<script src="/assets/js/bootstrap-wizard.min.js"></script>
<script src="/assets/js/jquery-ui-1.10.3.min.js"></script>
<script type="text/javascript">

    var vue = new Vue({
        el: "#contentpanel",
        data: {
            result: []
        },
        methods: {
            change_item: function (data) {
                var me = this;
                var id = data.id;
                me.$http.get("/assets/json/contract_template.json").then(function (response) {
                    var data = response.data;
                    var template = jQuery.fn.loadTemplate("/assets/template/subject/contract_change.tpl");
                    Vue.component('contract_view' + data.id, {
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
                        methods: {
                            /**
                             * 获取预设乙方信息
                             */
                            default_info: function () {
                                var me = this;
                                jQuery("#custom_lg_modal").modal("hide");
                                jQuery.fn.check_msg({
                                    msg: '是否导入系统预设的乙方信息？已填信息将会被覆盖。',
                                    success: function () {
                                        me.$http.get('/assets/json/contract_default.json').then(function (response) {
                                            var data = response.data;
                                            for (var key in data) {
                                                var value = data[key];
                                                me.$set(key, value);
                                            }
                                            jQuery("#custom_lg_modal").modal("show");
                                        }, function (response) {
                                            jQuery.fn.error_msg("服务器无法获取预设信息！");
                                        })


                                    }
                                });
                            },
                            /**
                             * 导入甲方客户资料
                             */
                            open_dialog: function () {
                                var me = this;
                                jQuery("#custom_lg_modal").modal("hide");
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
                                                        jQuery("#custom_lg_modal").modal("show");

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
                            /**
                             * 增加检测项
                             */
                            addItem: function () {
                                var me = this;
                                jQuery("#custom_lg_modal").modal("hide");
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
                                                var panel_me = this;
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

                                                jQuery("#custom_modal").modal("hide");
                                                jQuery("#custom_lg_modal").modal("show");

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
                                                if (!items) return;
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
                            /**
                             * 删除检测项
                             * @param item
                             */
                            delete_item: function (item) {
                                var me = this;
                                jQuery("#custom_lg_modal").modal("hide");
                                jQuery.fn.check_msg({
                                    msg: "是否删除当前选中监测项目?",
                                    success: function () {
                                        me.item_arr.$remove(item);
                                        jQuery.fn.alert_msg("监测项目删除成功!");
                                        jQuery("#custom_lg_modal").modal("show");
                                    }
                                })
                            },
                            /**
                             * 检测项上移一位
                             * @param index
                             */
                            sort_up: function (index) {

                                var upper = this.item_arr[index - 1];
                                var value = this.item_arr[index];
                                this.item_arr.$set(index, upper);
                                this.item_arr.$set(index - 1, value);
                            },
                            /**
                             * 检测项下移一位
                             * @param index
                             */
                            sort_down: function (index) {
                                var upper = this.item_arr[index + 1];
                                var value = this.item_arr[index];
                                this.item_arr.$set(index, upper);
                                this.item_arr.$set(index + 1, value);
                            },
                            /**
                             * 保存并进入流程中
                             */
                            saveAsProject: function () {
                                jQuery("#custom_lg_modal").modal("hide");
                                jQuery.fn.check_msg({

                                    msg: "是否保存当前合同模板的修改？",
                                    success: function () {
                                        jQuery.fn.alert_msg("合同模板修改成功！");
                                    }
                                });
                            },
                            /**
                             * 打印导出报告
                             */
                            print: function () {
//                            jQuery("#custom_lg_modal").modal("hide");
//                            jQuery.fn.check_msg({
//                                msg: "是否打印当前合同？",
//                                success: function () {
//                                    jQuery.fn.alert_msg("合同打印成功！");
//                                    jQuery("#custom_lg_modal").modal("show");
//                                }
//                            });
                            }


                        },
                        ready: function () {
                            var dom = jQuery(this.$el);
                            var $validator = jQuery("#firstForm").validate({
                                highlight: function (element) {
                                    jQuery(element).closest('.form-group').removeClass('has-success').addClass('has-error');
                                },
                                success: function (element) {
                                    jQuery(element).closest('.form-group').removeClass('has-error');
                                }
                            });
                            jQuery('#validationWizard').bootstrapWizard({
                                tabClass: 'nav nav-pills nav-justified nav-disabled-click',
                                'nextSelector': '.next',
                                'previousSelector': '.previous',
                                onInit: function () {
                                    jQuery('.wizard .finish').hide();
                                    jQuery('.wizard .draft').hide();
                                    jQuery('.wizard .print').hide();
                                    jQuery('.wizard .previous').hide();
                                },
                                onTabClick: function (tab, navigation, index) {
                                    return false;
                                },
                                onNext: function (tab, navigation, index) {
                                    var $total = navigation.find('li').length;
                                    var $current = index + 1;
                                    var $percent = ($current / $total) * 100;
                                    jQuery('#validationWizard').find('.progress-bar').css('width', $percent + '%');

                                    var $valid = jQuery('#firstForm').valid();
                                    if (!$valid) {
                                        $validator.focusInvalid();
                                        return false;
                                    }

                                    if (index >= 3) {
                                        jQuery('.wizard .finish').show();
                                        jQuery('.wizard .draft').show();
                                        jQuery('.wizard .print').show();
                                    } else {
                                        jQuery('.wizard .finish').hide();
                                        jQuery('.wizard .draft').hide();
                                        jQuery('.wizard .print').hide();
                                    }
                                    if (index == 3) {
                                        jQuery('.wizard .next').hide();
                                    } else {
                                        jQuery('.wizard .next').show();
                                    }
                                    if (index == 0) {
                                        jQuery('.wizard .previous').hide();
                                    } else {
                                        jQuery('.wizard .previous').show();
                                    }
                                    adjustmainpanelheight();
                                },
                                onPrevious: function (tab, navigation, index) {
                                    var $total = navigation.find('li').length;
                                    var $current = index + 1;
                                    var $percent = ($current / $total) * 100;
                                    jQuery('#validationWizard').find('.progress-bar').css('width', $percent + '%');
                                    if (index >= 3) {
                                        jQuery('.wizard .finish').show();
                                        jQuery('.wizard .draft').show();
                                        jQuery('.wizard .print').hide();
                                    } else {
                                        jQuery('.wizard .finish').hide();
                                        jQuery('.wizard .draft').hide();
                                        jQuery('.wizard .print').hide();
                                    }
                                    if (index == 0) {
                                        jQuery('.wizard .next').hide();
                                    }
                                    if (index == 3) {
                                        jQuery('.wizard .next').hide();
                                    } else {
                                        jQuery('.wizard .next').show();
                                    }
                                    if (index == 0) {
                                        jQuery('.wizard .previous').hide();
                                    } else {
                                        jQuery('.wizard .previous').show();
                                    }
                                    adjustmainpanelheight();
                                },
                                onTabShow: function (tab, navigation, index) {
                                    var $total = navigation.find('li').length;
                                    var $current = index + 1;
                                    var $percent = ($current / $total) * 100;
                                    jQuery('#validationWizard').find('.progress-bar').css('width', $percent + '%');
                                }
                            });

                            jQuery(".select2").select2({
                                width: '100%',
                                minimumResultsForSearch: -1
                            });
                            jQuery('#datepicker-multiple').datepicker({
                                numberOfMonths: 3,
                                showButtonPanel: true
                            });

                            for (var key in data) {
                                var value = data[key];
                                if (this[key] != undefined) {
                                    this.$set(key, value);
                                    if (key == 'monitor_type') {
                                        $('#monitor_type').find('option[value="' + value + '"]').prop("selected", "selected");
                                        $('#monitor_type').trigger("change");
                                    }
                                    if (key == 'payment_way') {
                                        $('#payment_way').find('option[value="' + value + '"]').prop("selected", "selected");
                                        $('#payment_way').trigger("change");
                                    }
                                }

                            }
                            $('.select2').trigger("change");

                            this.$watch('monitor_way', function (val) {
                                if (this.monitor_way == 0) {
                                    jQuery('input[name=monitor_way_desp]').prop("disabled", true);
                                } else {
                                    jQuery('input[name=monitor_way_desp]').prop("disabled", false);
                                }
                            });
                        }
                    });
                    LIMS.dialog_lg.$set('title', '变更合同模板信息');
                    LIMS.dialog_lg.currentView = 'contract_view' + data.id;
                }, function (response) {

                });
            },
            stop_item: function (data) {
                var me = this;
                jQuery.fn.check_msg({
                    msg: "⚠️警告,您正在进行<span class='text-danger'>删除合同模板</span>操作,该操作不可逆,是否进行？",
                    success: function () {
                        me.result.$remove(data);
                    }
                })
            }
        },
        ready: function () {
            var me = this;
            me.$http.get("/assets/json/contract_template_list.json").then(function (response) {
                var data = response.data;
                console.log(data);
                me.$set("result", data.results);
            }, function (response) {

            })
        }


    });
</script>