<div class="panel panel-default">
    <div class="panel-body">
        <ul class="nav nav-tabs">
            <li class="active"><a href="#home" data-toggle="tab"><strong>待下达清单</strong></a></li>
            <li id="tab-task"><a href="#task" data-toggle="tab"><strong>下达列表</strong></a></li>
            <li><a href="#profile" data-toggle="tab"><strong>已下达任务</strong></a></li>
        </ul>

        <!-- Tab panes -->
        <div class="tab-content mb30">
            <div class="tab-pane active" id="home">
                <div class="row">
                    <div class="results-list">
                        <template v-for="result in result_list">
                            <div class="media">
                                <a href="javascript:;" class="pull-left">
                                    <img alt="" src="/assets/images/photos/contract.png" class="media-object">
                                </a>
                                <div class="media-body">
                                    <div class="btn-demo pull-right">
                                        <a class="btn btn-info-alt"
                                           @click="task_distribute(result)">任务分派</a>
                                        <a class="btn btn-default-alt" data-toggle="modal"
                                           data-target=".bs-example-modal-lg" @click="view_info(result)">查看详情</a>
                                        <a class="btn btn-danger-alt" @click="flow(result)">业务流转</a>
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
                </div>
            </div>
            <div class="tab-pane" id="task">
                <div class="row">
                    <div class="col-sm-12">
                        <div class="btn-demo">
                            <a class="btn btn-default-alt" @click="select_all">全 选</a>
                            <a class="btn btn-primary-alt" @click="user('analyst','分析员')">分析员</a>
                            <a class="btn btn-success-alt" @click="user('assessor','审核员')">审核员</a>
                            <a class="btn btn-warning-alt" @click="user('checker','复核员')">复核员</a>
                            <a class="btn btn-danger-alt" @click="clearAll">清 空</a>
                        </div>
                        <div class="table-responsive">
                            <table class="table table-info mb30">
                                <thead>
                                <tr>
                                    <th class="text-center"></th>
                                    <th class="text-center">编号</th>
                                    <th class="text-center">样品类别</th>
                                    <th class="text-center">分析项目</th>
                                    <th class="text-center">件数</th>
                                    <th class="text-center">分析员</th>
                                    <th class="text-center">审核员</th>
                                    <th class="text-center">复核员</th>
                                    <th class="text-center">操作</th>
                                </tr>
                                </thead>
                                <tbody>
                                <template v-for="(index,project) in projectList">
                                    <tr class="text-center">
                                        <td><input type="checkbox" data-value="{{project.name}}" name="selectedProject"
                                                   value="{{project.id}}"></td>
                                        <td>{{index+1}}</td>
                                        <td>{{project.category.name}}</td>
                                        <td>{{project.name}}</td>
                                        <td>{{project.samples.length}}</td>
                                        <td v-if="project.analyst!=null">{{project.analyst.name}} <a href="javascript:;"
                                                                                                     class="delete-row"
                                                                                                     @click="delUser(project.id,'analyst','分析员')"><i
                                                class="fa fa-trash-o"></i></a></td>
                                        <td v-else><a href="javascript:;" class="delete-row"
                                                      @click="addUser(project.id,'analyst','分析员')"><i
                                                class="fa fa-gears"></i></a>
                                        </td>
                                        <td v-if="project.assessor!=null">{{project.assessor.name}} <a
                                                href="javascript:;" class="delete-row"
                                                @click="delUser(project.id,'assessor','审核员')"><i
                                                class="fa fa-trash-o"></i></a>
                                        </td>
                                        <td v-else><a href="javascript:;" class="delete-row"
                                                      @click="addUser(project.id,'assessor','审核员')"><i
                                                class="fa fa-gears"></i></a>
                                        </td>
                                        <td v-if="project.checker!=null">{{project.checker.name}} <a href="javascript:;"
                                                                                                     class="delete-row"
                                                                                                     @click="delUser(project.id,'checker','复核员')"><i
                                                class="fa fa-trash-o"></i></a></td>
                                        <td v-else><a href="javascript:;" class="delete-row"
                                                      @click="addUser(project.id,'checker','复核员')"><i
                                                class="fa fa-gears"></i></a>
                                        </td>
                                        <td class="table-action">
                                            <a class="btn btn-sm btn-info-alt" @click="showInfo(project.samples)">清单</a>
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
            </div>
            <div class="tab-pane" id="profile">
                <div class="row">

                </div>
            </div>
        </div>
    </div>
</div>
<div class="modal fade bs-example-modal-sm" id="charge_user" tabindex="-1" role="dialog"
     aria-labelledby="mySmallModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-sm">
        <div class="modal-content">
            <div class="modal-header">
                <button aria-hidden="true" data-dismiss="modal" class="close" type="button">&times;</button>
                <h4 class="modal-title">选择操作者</h4>
            </div>
            <div class="modal-body">
                <div class="form-group">
                    <label class="col-sm-4 control-label">选择岗位</label>
                    <div class="col-sm-8">
                        <select class="select2" id="role_select" data-placeholder="选择一个岗位">
                            <option value=""></option>
                            <template v-for="role in roleList">
                                <option value="{{role.id}}">{{role.name}}</option>
                            </template>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-4 control-label">选择用户</label>
                    <div class="col-sm-8">
                        <select class="select2" id="user_select" data-placeholder="选择一个用户">
                            <option value=""></option>
                            <template v-for="user in userList">
                                <option value="{{user.id}}">{{user.name}}</option>
                            </template>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <div class="text-center">
                        <a class="btn btn-primary-alt" id="saveOpt">保 存</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    jQuery(document).ready(function () {
        "use strict";
        var vue = new Vue({
            el: '#contentpanel',
            data: function () {
                return {
                    result_list: [],//结果集
                    id: "",
                    identify: "",
                    isShow: false,
                    projectList: [],
                    sample_list: [],

                    roleList: [],//岗位列表
                    userList: []
                }
            },
            methods: {
                task_distribute: function (task) {
                    var me = this;
                    var id = task.id;
                    me.isShow = false;
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
                    me.$http.get("/task/list", {
                        params: {
                            rowCount: rowCount,
                            currentPage: currentPage,
                            condition: condition
                        }
                    }).then(function (response) {
                        var data = response.data;
                        me.$set("result_list", data.results);
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
                load_projectlist: function (id) {
                    var me = this;
                    me.$http.get("/sample/getProjectListByDelivery", {
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
                select_all: function () {
                    jQuery.fn.select_all("selectedProject", "convert");
                },
                user: function (type, name) {
                    var me = this;
                    var oChecked = jQuery('input[name=selectedProject]:checked');
                    var selected = [];
                    var values = [];
                    for (var i = 0; i < oChecked.length; i++) {
                        selected.push(oChecked[i].value);
                        values.push(jQuery(oChecked[i]).data("value"));
                    }
                    jQuery("#charge_user").modal("show");
                    jQuery("#saveOpt").off("click").on("click", function () {
                        var user_name = jQuery("#user_select").find('option:selected').html();
                        var user_id = jQuery("#user_select").val();
                        if (!user_id) {
                            jQuery.fn.error_msg("请选择操作用户!");
                            return;
                        }
                        jQuery("#charge_user").modal("hide");
                        jQuery.fn.check_msg({
                            msg: "是否将【" + user_name + "】设置为任务【" + me.identify + "】的【" + values.toString() + "】检测项目的【" + name + "】?",
                            success: function () {
                                var data = {
                                    user_id: user_id,
                                    task_id: me.id,
                                    projectList: selected,
                                    type: type
                                };
                                me.$http.post("/distribute/task_distribute", data).then(function (response) {
                                    var data = response.data;
                                    jQuery.fn.codeState(data.code, {
                                        200: function () {
                                            jQuery.fn.alert_msg(name + "分配成功!");
                                            me.load_projectlist(me.id);
                                        }
                                    })
                                }, function (response) {
                                    jQuery.fn.error_msg("数据异常,无法分配" + name);
                                });
                            }
                        });
                    });
                },
                clearAll: function () {
                    var me = this;
                    var oChecked = jQuery('input[name=selectedProject]:checked');
                    var selected = [];
                    var values = [];
                    for (var i = 0; i < oChecked.length; i++) {
                        selected.push(oChecked[i].value);
                        values.push(jQuery(oChecked[i]).data("value"));
                    }
                    jQuery.fn.check_msg({
                        msg: "是否将任务【" + me.identify + "】的【" + values.toString() + "】检测项目的分析员、审核员、复核员全部清空?",
                        success: function () {
                            var data = {
                                task_id: me.id,
                                projectList: selected
                            };
                            me.$http.post("/distribute/clear_distribute", data).then(function (response) {
                                var data = response.data;
                                jQuery.fn.codeState(data.code, {
                                    200: function () {
                                        jQuery.fn.alert_msg(name + "清空成功!");
                                        me.load_projectlist(me.id);
                                    }
                                })
                            }, function (response) {
                                jQuery.fn.error_msg("数据异常,无法清空操作人员!");
                            });
                        }
                    });
                },
                delUser: function (project_id, type, name) {
                    var me = this;
                    jQuery.fn.check_msg({
                        msg: "是否移除当前检测项目的" + name + "？",
                        success: function () {
                            var data = {
                                task_id: me.id,
                                project_id: project_id,
                                type: type
                            };
                            me.$http.post("/distribute/delUser", data).then(function (response) {
                                var data = response.data;
                                jQuery.fn.codeState(data.code, {
                                    200: function () {
                                        jQuery.fn.alert_msg(name + "删除成功!");
                                        me.load_projectlist(me.id);
                                    }
                                });
                            }, function (response) {
                                jQuery.fn.error_msg("数据异常,无法删除当前监测项目的" + name);
                            });
                        }
                    });
                },
                addUser: function (project_id, type, name) {
                    var me = this;
                    jQuery("#charge_user").modal("show");
                    jQuery("#saveOpt").off("click").on("click", function () {
                        var user_name = jQuery("#user_select").find('option:selected').html();
                        var user_id = jQuery("#user_select").val();
                        if (!user_id) {
                            jQuery.fn.error_msg("请选择操作用户!");
                            return;
                        }
                        jQuery("#charge_user").modal("hide");
                        jQuery.fn.check_msg({
                            msg: "是否将【" + user_name + "】设置为当前检测项目的【" + name + "】?",
                            success: function () {
                                var data = {
                                    user_id: user_id,
                                    task_id: me.id,
                                    projectList: [project_id],
                                    type: type
                                };
                                me.$http.post("/distribute/task_distribute", data).then(function (response) {
                                    var data = response.data;
                                    jQuery.fn.codeState(data.code, {
                                        200: function () {
                                            jQuery.fn.alert_msg(name + "分配成功!");
                                            me.load_projectlist(me.id);
                                        }
                                    })
                                }, function (response) {
                                    jQuery.fn.error_msg("数据异常,无法分配" + name);
                                });
                            }
                        });
                    });
                },
                flow: function (task) {
                    var me = this;
                    jQuery.fn.check_msg({
                        msg: "您即将进行任务编号为【" + task.identify + "】的进度流转,是否继续?",
                        success: function () {
                            var data = {
                                task_id: task.id
                            };
                            me.$http.post("/distribute/checkUser", data).then(function (response) {
                                var data = response.data;
                                jQuery.fn.codeState(data.code, {
                                    200: function () {
                                        me.$http.post("/flow/distributeFlow", {id: task.id}).then(function (response) {
                                            var data = response.data;
                                            jQuery.fn.codeState(data.code, {
                                                200: function () {
                                                    jQuery.fn.alert_msg("任务流转成功!");
                                                    me.load_list("state=receive_delivery", 1);
                                                }
                                            })
                                        }, function (response) {
                                            jQuery.fn.error_msg("数据异常,无法流转任务,请刷新后重新尝试!");
                                        });
                                    },
                                    504: function () {
                                        jQuery.fn.error_msg("当前任务书尚有未分配监测项目,任务无法流转!");
                                    }
                                })
                            }, function (response) {
                                jQuery.fn.error_msg("数据异常,无法进行项目流转!");
                            });
                        }
                    })
                }
            },
            ready: function () {
                var me = this;
                me.load_list("state=receive_delivery", 1);
                me.$http.get("/role/getList").then(function (response) {
                    var data = response.data;
                    me.$set("roleList", data.results);
                }, function (response) {
                    jQuery.fn.error_msg("服务器异常,无法获取岗位列表!");
                });

                jQuery("#role_select").select2({
                    width: '100%'
                }).on("change", function (event) {
                    var id = event.val;
                    me.$http.get("/user/getListByRole", {
                        params: {
                            id: id
                        }
                    }).then(function (response) {
                        var data = response.data;
                        me.$set("userList", data.results);
                    }, function (response) {
                        jQuery.fn.error_msg("服务器异常,无法获取用户列表!");
                    });
                });
                jQuery("#user_select").select2({
                    width: '100%'
                });
            }
        });
    });
</script>