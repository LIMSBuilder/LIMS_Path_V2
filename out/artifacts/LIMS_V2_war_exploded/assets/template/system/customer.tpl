<div class="row">
    <div class="col-md-12">
        <div class="panel panel-default">
            <div class="panel-body">
                <div class="row">
                    <div class="col-md-9">
                        <div class="btn-demo" id="toolbar">
                            <a class="btn btn-info-alt" data-toggle="modal"
                               data-target=".bs-example-modal-static" @click="add_customer">新
                                增</a>
                            <a class="btn btn-primary-alt" @click="select_all">全 选</a>
                            <a class="btn btn-default-alt select_no" @click="convert_all">反 选</a>
                            <a class="btn btn-danger-alt del_all_select" @click="del_customer">删 除</a>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <input type="text" @keyup.enter="search" v-model="search_key" placeholder="搜索委托单位..."
                               id="serach"
                               class="form-control">
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="table-responsive">
                            <table class="table table-info table-hover mb30 text-center">
                                <thead>
                                <tr>
                                <tr>
                                    <th class="text-center"></th>
                                    <th class="text-center">委托单位</th>
                                    <th class="text-center">联系人</th>
                                    <th class="text-center">联系电话</th>
                                    <th class="text-center">联系地址</th>
                                    <th></th>
                                </tr>
                                </tr>
                                </thead>
                                <tbody>
                                <template v-for="item in results">
                                    <tr>
                                        <td class="text-center">
                                            <input type="checkbox" value="{{item.id}}"
                                                   name="depart_check"></td>
                                        <td class="text-center">{{item.client_unit}}</td>
                                        <td class="text-center">{{item.client}}</td>
                                        <td class="text-center">{{item.client_tel}}</td>
                                        <td class="text-center">{{item.client_address}}</td>
                                        <td class="table-action text-center">
                                            <a href="javascript:;" data-toggle="modal"
                                               data-target=".bs-example-modal-static"
                                               @click="edit_item(item)"><i
                                                    class="fa fa-edit"></i></a>
                                            <a href="javascript:;" data-toggle="modal"
                                               data-target=".bs-example-modal-static"
                                               @click="view_item(item)"><i
                                                    class="fa fa-eye"></i></a>
                                            <a href="javascript:;" class="delete-row" @click="del_item(item)"><i
                                                    class="fa fa-trash-o "></i></a>
                                        </td>
                                    </tr>
                                </template>
                                </tbody>
                            </table>
                        </div><!-- table-responsive -->
                    </div><!-- col-md-12 -->
                    <div class="paging nomargin pull-right"></div>
                </div>
            </div>
        </div>
    </div>
</div>


<script type="text/javascript">
    var vue = new Vue({
        el: "#contentpanel",
        data: {
            "results": [],
            search_key: ""
        },
        methods: {
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
                    me.$set("results", data.results);
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
                                me.$set("results", data.results);
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

            },
            search: function (data) {
                var value = data.target.value;
                this.load_list("client_unit=" + encodeURI(value), 1);
            },
            view_item: function (data) {
                var me = this;
                var index = data.id;
                var template = jQuery.fn.loadTemplate("/assets/template/subject/customer_view.tpl");
                Vue.component('customer_view_item' + index, {
                    template: template,
                    data: function () {
                        return {
                            data: data
                        };
                    }
                });
                LIMS.dialog.$set('title', '查看客户资料');
                LIMS.dialog.currentView = 'customer_view_item' + index;
            },
            add_customer: function () {
                var outer = this;
                var template = jQuery.fn.loadTemplate("/assets/template/subject/customer_addItem.tpl");
                Vue.component('customer_add_item', {
                    template: template,
                    data: function () {
                        return {
                            client_unit: "",
                            client_code: "",
                            client_address: "",
                            client_tel: "",
                            client: "",
                            client_fax: ""
                        };
                    },
                    methods: {
                        save: function () {
                            var me = this;
                            if (jQuery("#customer_form").valid()) {
                                me.$http.post("/customer/add", me._data).then(function (response) {
                                    var data = response.data;
                                    jQuery.fn.codeState(data.code, {
                                        200: function () {
                                            var currentPage = parseInt(jQuery('.paging span').html());
                                            var condition = outer.search_key == "" ? "" : "client_unit=" + encodeURI(outer.search_key);
                                            outer.load_list(condition, currentPage);

                                            jQuery.fn.alert_msg("客户资料保存成功!");
                                            var datas = me._data;
                                            for (var key in datas) {
                                                me.$set(key, "");//清空表单数据
                                            }
                                        }
                                    })
                                }, function (response) {
                                    jQuery.fn.error_msg("服务器数据异常!无法保存部门信息,请刷新后重新尝试。");
                                });
                            }
                        }
                    },
                    ready: function () {
                        var me = this;
                        var dom = jQuery(this.$el);
                        dom.find("#customer_form").validate({
                            highlight: function (element) {
                                jQuery(element).closest('.form-group').removeClass('has-success').addClass('has-error');
                            },
                            success: function (element) {
                                jQuery(element).closest('.form-group').removeClass('has-error');
                            }
                        });
                    }
                });
                LIMS.dialog.$set('title', '创建客户资料');
                LIMS.dialog.currentView = 'customer_add_item';
            },
            del_customer: function () {
                var me = this;
                var selected = [];
                var oCheck = jQuery('input[name=depart_check]:checked');
                if (oCheck.length == 0) {
                    jQuery.fn.error_msg('至少需要选择一个客户！');
                    return;
                }
                oCheck.each(function (index, item) {
                    selected.push(item.value);
                });
                jQuery.fn.check_msg({
                    msg: '是否<span style="color: red;">删除</span>所有选中的客户？',
                    success: function () {
                        me.$http.post("/customer/deleteAll", {
                            selected: selected
                        }).then(function (response) {
                            var data = response.data;
                            if (data.code == "200") {
                                var currentPage = parseInt(jQuery('.paging span').html());
                                var condition = me.search_key == "" ? "" : "client_unit=" + encodeURI(me.search_key);
                                me.load_list(condition, currentPage);
                                jQuery.fn.alert_msg('所选客户信息删除成功！');
                            }
                            if (data.code == "503") {
                                var results = data.results;
                                var error_msg = "";
                                for (var i = 0; i < results.length; i++) {
                                    error_msg += results[i].client_unit + ",";
                                }
                                jQuery.fn.error_msg("数据异常,客户" + error_msg.substr(0, error_msg.length - 1) + "删除失败!");
                            }
                        }, function (response) {
                            jQuery.fn.error_msg("无法获取客户列表信息,请尝试刷新操作。");
                        });
                    }
                });
            },
            del_item: function (data) {
                var me = this;
                jQuery.fn.check_msg({
                    msg: '是否删除【<span style="color: red;">' + data.client_unit + '</span>】？，删除部门将清空该部门的员工信息！',
                    success: function () {
                        me.$http.post("/customer/delete", {
                            id: data.id
                        }).then(function (response) {
                            var data = response.data;
                            jQuery.fn.codeState(data.code, {
                                200: function () {
                                    var currentPage = parseInt(jQuery('.paging span').html());
                                    var condition = me.search_key == "" ? "" : "client_unit=" + encodeURI(me.search_key);
                                    me.load_list(condition, currentPage);
                                    jQuery.fn.alert_msg('客户信息删除成功！');
                                }
                            })
                        }, function (response) {
                            jQuery.fn.error_msg("无法获取客户列表信息,请尝试刷新操作。");
                        });
                    }
                });
            },
            edit_item: function (data) {
                var me = this;
                var index = data.id;
                var template = jQuery.fn.loadTemplate("/assets/template/subject/customer_addItem.tpl");
                Vue.component('customer_change_item' + index, {
                    template: template,
                    data: function () {
                        return {
                            id: data.id,
                            client_unit: data.client_unit,
                            client_code: data.client_code,
                            client_address: data.client_address,
                            client_tel: data.client_tel,
                            client: data.client,
                            client_fax: data.client_fax
                        };
                    },
                    methods: {
                        save: function () {
                            var that = this;
                            var data = JSON.parse(JSON.stringify(that._data));
                            me.$http.post("/customer/change", data).then(function (response) {
                                var data = response.data;
                                jQuery.fn.codeState(data.code, {
                                    200: function () {
                                        var currentPage = parseInt(jQuery('.paging span').html());
                                        var condition = me.search_key == "" ? "" : "client_unit=" + encodeURI(me.search_key);
                                        me.load_list(condition, currentPage);
                                        jQuery.fn.alert_msg("客户信息修改成功!");
                                        jQuery("#custom_modal").modal("hide");
                                    }
                                });
                            }, function (response) {
                                jQuery.fn.error_msg("无法获取客户列表信息,请尝试刷新操作。");
                            });


                        }
                    }
                });
                LIMS.dialog.$set('title', '修改客户信息');
                LIMS.dialog.currentView = 'customer_change_item' + index;
            },
            convert_all: function () {
                //反选操作
                jQuery.fn.select_all("depart_check", "other");
            },
            select_all: function () {
                //全选操作
                jQuery.fn.select_all("depart_check", "all");
            }
        },
        ready: function () {
            this.load_list("", 1);
        }
    })
</script>


