<div class="row">
    <div class="col-md-12">
        <div class="panel panel-default">
            <div class="panel-body">
                <div class="row">
                    <div class="col-md-9">
                        <div class="btn-demo" id="toolbar">
                            <div class="col-sm-3">
                                <select class="select2" id="depart_change" data-placeholder="请选择部门...">
                                    <option value=""></option>
                                    <template v-for="item in departments">
                                        <option value="{{item.id}}">{{item.name}}</option>
                                    </template>
                                </select>
                            </div>
                            <a class="btn btn-info-alt" data-toggle="modal"
                               data-target=".bs-example-modal-static" @click="add_role">新
                                增</a>
                            <a class="btn btn-success-alt " @click="run_role">启 用</a>
                            <a class="btn btn-warning-alt stop_all_select" @click="stop_role">禁 用</a>
                            <a class="btn btn-danger-alt del_all_select" @click="del_role">删 除</a>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <input type="text" placeholder="搜索角色..." id="serach" class="form-control">
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="table-responsive">
                            <table class="table table-info  mb30 text-center">
                                <thead>
                                <tr>
                                    <th class="text-center">角色名称</th>
                                    <th class="text-center">当前状态</th>
                                    <th class="text-center">所属部门</th>
                                    <th></th>
                                </tr>
                                </thead>
                                <tbody>
                                <template v-for="item in  results">
                                    <template v-for="(index,roles) in item.role">
                                        <tr>
                                            <td>{{roles.name}}</td>
                                            <td class="text-center" v-if="roles.state==0"><span
                                                    class="label label-success">正常</span></td>
                                            <td class="text-center" v-if="roles.state==1"><span
                                                    class="label label-danger">禁用</span></td>
                                            <td>{{item.name}}</td>
                                            <td class="table-action text-center">
                                                <a href="javascript:;" data-toggle="modal"
                                                   data-target=".bs-example-modal-static"
                                                   @click="edit_item(roles,item)"><i
                                                        class="fa fa-pencil"></i></a>
                                                <a href="javascript:;" data-toggle="modal"
                                                   data-target=".bs-example-modal-lg"
                                                   @click="power_item(roles)"><i
                                                        class="fa fa-sign-in"></i></a>
                                                <a href="javascript:;" v-if="roles.state==1" @click="run_item(roles)"><i
                                                        class="fa fa-eye "></i></a>
                                                <a href="javascript:;" v-if="roles.state==0"
                                                   @click="stop_item(roles)"><i
                                                        class="fa fa-eye-slash "></i></a>
                                                <a href="javascript:;" class="delete-row" @click="del_item(roles)"><i
                                                        class="fa fa-trash-o "></i></a>
                                            </td>
                                        </tr>
                                    </template>
                                </template>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <div class="paging nomargin pull-right"></div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">

    var vue = new Vue({
        el: "#contentpanel",
        data: {
            results: [],
            departments: []
        },
        methods: {
            add_role: function () {
                var me = this;
                var template = jQuery.fn.loadTemplate("/assets/template/subject/role_addItem.tpl");
                Vue.component('depart_add_item', {
                    template: template,
                    data: function () {
                        return {
                            depart_list: me.departments,
                            name: "",
                            belong_depart: 0
                        };
                    },
                    methods: {
                        save: function () {
                            var that = this;
                            var data = JSON.parse(JSON.stringify(this._data));
                            this.belong_depart = jQuery('#choose_depart').val();
                            jQuery.fn.alert_msg("角色信息保存成功!");
                            this.name = "";
                        }
                    },
                    ready: function () {
                        var dom = jQuery(this.$el);
                        dom.find('#choose_depart').select2({
                            width: '100%',
                            minimumResultsForSearch: -1
                        });
                    }
                });
                LIMS.dialog.$set('title', '创建角色');
                LIMS.dialog.currentView = 'depart_add_item';
            },
            run_role: function (data) {
                jQuery.fn.check_msg({
                    msg: '是否<span style="color: #1CAF9A;">启用</span>所有选中的角色？',
                    success: function () {
                        jQuery.fn.alert_msg('所选角色启用成功！');
                    }
                });
            },
            stop_role: function (data) {
                jQuery.fn.check_msg({
                    msg: '是否<span style="color: #f0ad4e;">禁用</span>所有选中的角色？',
                    success: function () {
                        jQuery.fn.alert_msg('所选角色禁用成功！');
                    }
                });
            },
            del_role: function (data) {
                jQuery.fn.check_msg({
                    msg: '是否<span style="color: red;">删除</span>所有选中的角色？',
                    success: function () {
                        jQuery.fn.alert_msg('所选角色删除成功！');
                    }
                });
            },
            run_item: function (data) {
                jQuery.fn.check_msg({
                    msg: '是否启用【<span style="color: #1CAF9A;">' + data.name + '</span>】？',
                    success: function () {
                        jQuery.fn.alert_msg('角色启用成功！');
                    }
                });
            },
            stop_item: function (data) {
                jQuery.fn.check_msg({
                    msg: '是否禁用【<span style="color: #f0ad4e;">' + data.name + '</span>】？，该角色的员工将无法登陆！',
                    success: function () {
                        jQuery.fn.alert_msg('角色禁用成功！');
                    }
                });
            },
            del_item: function (data) {
                jQuery.fn.check_msg({
                    msg: '是否删除【<span style="color: red;">' + data.name + '</span>】？，删除角色将清空该部门的员工信息！',
                    success: function () {
                        jQuery.fn.alert_msg('角色删除成功！');
                    }
                });
            },
            edit_item: function (data, depart) {
                var me = this;
                var index = data.id;
                var template = jQuery.fn.loadTemplate("/assets/template/subject/role_addItem.tpl");

                Vue.component('depart_change_item' + index, {
                    template: template,
                    data: function () {
                        return {
                            name: data.name,
                            depart_list: me.departments,
                            belong_depart: depart.id
                        };
                    },
                    methods: {
                        save: function () {
                            var data = JSON.parse(JSON.stringify(this._data));
                            console.log(data);
                            jQuery.fn.alert_msg("部门信息修改成功!");
                            jQuery("#custom_modal").modal("hide");
                        }
                    },
                    ready: function () {
                        var dom = jQuery(this.$el);
                        dom.find('#choose_depart').select2({
                            width: '100%',
                            minimumResultsForSearch: -1
                        });


                    }
                });
                LIMS.dialog.$set('title', '修改部门信息');
                LIMS.dialog.currentView = 'depart_change_item' + index;
            },
            power_item: function (data) {
                var me = this, index = data.id;
                me.$http.get("/assets/json/power.json").then(function (response) {
                    var results = response.data;
                    var template = jQuery.fn.loadTemplate("/assets/template/subject/power.tpl");
                    Vue.component('power' + index, {
                        template: template,
                        data: function () {
                            return {
                                power_list: results.results,
                                checked_power: []
                            };
                        },
                        methods: {
                            save: function () {
                                var me = this;
                                var data = JSON.parse(JSON.stringify(this._data));
                                //此处发送一个请求给后端,返回之后处理下方代码
                                console.log(data);
                                jQuery.fn.alert_msg("权限设置成功!");
                                me.checked_power = [];
                                jQuery("#custom_lg_modal").modal("hide");
                            },
                            clear: function () {
                                var me = this;
                                me.checked_power = [];
                                jQuery('input[name=select_all]').prop("checked",false);
                            },
                            choose_all: function () {
                                var me = this;
                                if (event.target.checked) {
                                    jQuery(event.target).parents('tr').siblings('tr').find('input[type=checkbox]').each(function (index, item) {
                                        var index = item.value;
                                        me.checked_power.push(index);
                                    })
                                }
                            }
                        },
                        ready: function () {
                        }
                    });
                    LIMS.dialog_lg.$set('title', '为“' + data.name + "”设置权限");
                    LIMS.dialog_lg.currentView = 'power' + index;
                }, function (response) {

                });


            }
        },
        ready: function () {
            var me = this;
            var dom = jQuery(me.$el);
            jQuery.get("/assets/json/role_list.json", {pageCount: 1, rowCount: 20}, function (data) {
                me.$set("results", data.results);
                me.$set("departments", data.results);
                jQuery('.select2').select2({
                    width: '100%',
                    minimumResultsForSearch: -1
                });
                //搜索框事件
                dom.find("#serach").keyup(function () {
                    if (event.keyCode == 13) {
                        var data = jQuery(this).val();
                        console.log('按下回车了,数据为' + data);
                    }
                });
                dom.find('#depart_change').on("click", function () {
                    var index = jQuery(this).val();
                    var list = me.departments;
                    list.forEach(function (item) {
                        if (item.id == index) {
                            me.$set("results", [item]);
                        }
                    });
                });
                //页码事件
                dom.find('.paging').pagination({
                    pageCount: data.totalPage,
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

                $.validator.setDefaults({
                    submitHandler: function () {
                    }
                });
            });
        }

    });
</script>