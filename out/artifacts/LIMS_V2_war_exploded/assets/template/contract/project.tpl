<div class="row">
    <div class="col-md-12">
        <div class="panel panel-default">
            <div class="panel-body">
                <div class="row">
                    <div class="col-md-12">
                        <div class="btn-demo" id="toolbar">
                            <a class="btn btn-info-alt" data-toggle="modal"
                               data-target=".bs-example-modal-static" @click="add_project">新
                                增</a>
                            <a class="btn btn-primary-alt" @click="select_all">全 选</a>
                            <a class="btn btn-default-alt select_no" @click="convert_all">反 选</a>
                            <a class="btn btn-danger-alt del_all_select" @click="del_project">删 除</a>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="form-group">
                            <select class="select2" id="category_choose" data-placeholder="请选择环境要素...">
                                <option value=""></option>
                                <option value="0">全部</option>
                                <template v-for="item in projects">
                                    <option value="{{item.id}}">{{item.name}}</option>
                                </template>
                            </select>
                        </div>
                    </div>
                    <div class="col-md-3 pull-right">
                        <input type="text" @keyup.enter="search" v-model="search_key" placeholder="搜索监测项目..."
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
                                    <th class="text-center">项目名称</th>
                                    <th class="text-center">所属分类</th>
                                    <th class="text-center">负责科室</th>
                                    <th class="text-center">项目描述</th>
                                    <th class="text-center">操作</th>
                                </tr>
                                </tr>
                                </thead>
                                <tbody>
                                <template v-for="item in results">
                                    <tr>
                                        <td class="text-center">
                                            <input type="checkbox" value="{{item.id}}"
                                                   name="depart_check"></td>
                                        <td class="text-center">{{item.name}}</td>
                                        <td class="text-center">{{item.category.name}}</td>
                                        <td class="text-center">{{item.chargeDepart.name}}</td>
                                        <td class="text-center">{{item.desp}}</td>
                                        <td class="table-action text-center">
                                            <a href="javascript:;" data-toggle="modal"
                                               data-target=".bs-example-modal-static"
                                               @click="edit_item(item)"><i
                                                    class="fa fa-edit"></i></a>
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
            "projects": [],
            "results": [],
            search_key: ""
        },
        methods: {
            load_list: function (condition, currentPage) {
                var me = this;
                var dom = jQuery(me.$el);
                var rowCount = localStorage.getItem("rowCount") || 0;
                me.$http.get("/project/list", {
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
                            me.$http.get("/project/list", {
                                params: {
                                    rowCount: rowCount,
                                    currentPage: currentPage,
                                    condition: data.condition
                                }
                            }).then(function (response) {
                                var data = response.data;
                                me.$set("results", data.results);
                            }, function (response) {
                                jQuery.fn.error_msg("无法获取监测项目列表信息,请尝试刷新操作。");
                            });
                        }
                    });
                    jQuery.validator.setDefaults({
                        submitHandler: function () {
                        }
                    });
                }, function (response) {
                    jQuery.fn.error_msg("无法获取环境要素列表信息,请尝试刷新操作。");
                });

            },
            search: function (data) {
                var value = data.target.value;
                this.load_list("name=" + encodeURI(value), 1);
            },
            add_project: function () {
                var outer = this;
                var template = jQuery.fn.loadTemplate("/assets/template/subject/project_addItem.tpl");
                Vue.component('project_add_item', {
                    template: template,
                    data: function () {
                        return {
                            name: "",
                            types: [],
                            category: 0,
                            desp: "",
                            departmentList: [],
                            chargeDepart: ""
                        };
                    },
                    methods: {
                        save: function () {
                            var me = this;
                            if (jQuery("#project_form").valid()) {
                                var data = {
                                    category: jQuery("#project_category").val(),
                                    name: me.name,
                                    desp: me.desp,
                                    chargeDepart: me.chargeDepart
                                };
                                me.$http.post("/project/add", data).then(function (response) {
                                    var data = response.data;
                                    jQuery.fn.codeState(data.code, {
                                        200: function () {
                                            var currentPage = parseInt(jQuery('.paging span').html());
                                            var condition = outer.search_key == "" ? "" : "name=" + encodeURI(outer.search_key);
                                            outer.load_list(condition, currentPage);

                                            jQuery.fn.alert_msg("环境要素保存成功!");
                                            me.name = "";//清空表单
                                            jQuery("#custom_modal").modal("hide");
                                        }
                                    })
                                }, function (response) {
                                    jQuery.fn.error_msg("服务器数据异常!无法保存环境要素信息,请刷新后重新尝试。");
                                });
                            }
                        }
                    },
                    ready: function () {
                        var me = this;
                        var dom = jQuery(this.$el);

                        me.$http.get("/category/getList").then(function (response) {
                            me.$set("types", response.data.results);
                        }, function (response) {
                            jQuery.fn.error_msg("无法获取环境要素列表信息,请尝试刷新操作。");
                        });


                        dom.find("#project_form").validate({
                            highlight: function (element) {
                                jQuery(element).closest('.form-group').removeClass('has-success').addClass('has-error');
                            },
                            success: function (element) {
                                jQuery(element).closest('.form-group').removeClass('has-error');
                            }
                        });
                        dom.find('#project_category').select2({
                            width: '100%',
                            minimumResultsForSearch: -1
                        });

                        me.$http.get("/department/getList").then(function (response) {
                            var data = response.data;
                            me.$set("departmentList", data.results);
                        }, function (response) {
                            jQuery.fn.error_msg("无法获取部门列表信息,请刷新后重新尝试!");
                        });


                        jQuery("#chargeDepart").select2({
                            width: '100%'
                        }).on("change", function (event) {
                            var id = event.val;
                            me.$set("chargeDepart", id);
                        });
                    }
                });
                LIMS.dialog.$set('title', '新增监测项目');
                LIMS.dialog.currentView = 'project_add_item';
            },
            del_project: function () {
                var me = this;
                var selected = [];
                var oCheck = jQuery('input[name=depart_check]:checked');
                if (oCheck.length == 0) {
                    jQuery.fn.error_msg('至少需要选择一个监测项目！');
                    return;
                }
                oCheck.each(function (index, item) {
                    selected.push(item.value);
                });
                jQuery.fn.check_msg({
                    msg: '是否<span style="color: red;">删除</span>所有选中的监测项目？',
                    success: function () {
                        me.$http.post("/project/changeStateAll", {
                            selected: selected
                        }).then(function (response) {
                            var data = response.data;
                            if (data.code == "200") {
                                var currentPage = parseInt(jQuery('.paging span').html());
                                var condition = me.search_key == "" ? "" : "name=" + encodeURI(me.search_key);
                                me.load_list(condition, currentPage);
                                jQuery.fn.alert_msg('所选监测项目删除成功！');
                            }
                            if (data.code == "503") {
                                var results = data.results;
                                var error_msg = "";
                                for (var i = 0; i < results.length; i++) {
                                    error_msg += results[i].client_unit + ",";
                                }
                                jQuery.fn.error_msg("数据异常,监测项目" + error_msg.substr(0, error_msg.length - 1) + "删除失败!");
                            }
                        }, function (response) {
                            jQuery.fn.error_msg("无法获取监测项目列表信息,请尝试刷新操作。");
                        });
                    }
                });
            },
            del_item: function (data) {
                var me = this;
                jQuery.fn.check_msg({
                    msg: '是否删除【<span style="color: red;">' + data.name + '</span>】？',
                    success: function () {
                        me.$http.post("/project/changeState", {
                            id: data.id
                        }).then(function (response) {
                            var data = response.data;
                            jQuery.fn.codeState(data.code, {
                                200: function () {
                                    var currentPage = parseInt(jQuery('.paging span').html());
                                    var condition = me.search_key == "" ? "" : "name=" + encodeURI(me.search_key);
                                    me.load_list(condition, currentPage);
                                    jQuery.fn.alert_msg('监测项目删除成功！');
                                }
                            })
                        }, function (response) {
                            jQuery.fn.error_msg("无法获取监测项目列表信息,请尝试刷新操作。");
                        });
                    }
                });
            },
            edit_item: function (data) {
                var me = this;
                var index = data.id;
                var template = jQuery.fn.loadTemplate("/assets/template/subject/project_addItem.tpl");
                Vue.component('project_change_item' + index, {
                    template: template,
                    data: function () {
                        return {
                            id: data.id,
                            name: data.name,
                            desp: data.desp,
                            types: [],
                            chargeDepart: "",
                            departmentList: []
                        };
                    },
                    methods: {
                        save: function () {
                            var that = this;
                            if (jQuery("#project_form").valid()) {
                                var data = {
                                    id: that.id,
                                    category: jQuery("#project_category").val(),
                                    name: that.name,
                                    chargeDepart:that.chargeDepart,
                                    desp: that.desp
                                };
                                me.$http.post("/project/change", data).then(function (response) {
                                    var data = response.data;
                                    jQuery.fn.codeState(data.code, {
                                        200: function () {
                                            var currentPage = parseInt(jQuery('.paging span').html());
                                            var condition = me.search_key == "" ? "" : "name=" + encodeURI(me.search_key);
                                            me.load_list(condition, currentPage);
                                            jQuery.fn.alert_msg("监测项目保存成功!");
                                            jQuery("#custom_modal").modal("hide");
                                        }
                                    })
                                }, function (response) {
                                    jQuery.fn.error_msg("服务器数据异常!无法保存监测项目信息,请刷新后重新尝试。");
                                });
                            }
                        }
                    },
                    ready: function () {
                        var me = this;
                        var dom = jQuery(this.$el);

                        me.$http.get("/category/getList").then(function (response) {
                            me.$set("types", response.data.results);
                        }, function (response) {
                            jQuery.fn.error_msg("无法获取环境要素列表信息,请尝试刷新操作。");
                        });


                        dom.find("#project_form").validate({
                            highlight: function (element) {
                                jQuery(element).closest('.form-group').removeClass('has-success').addClass('has-error');
                            },
                            success: function (element) {
                                jQuery(element).closest('.form-group').removeClass('has-error');
                            }
                        });
                        dom.find('#project_category').select2({
                            width: '100%',
                            minimumResultsForSearch: -1
                        });
                        me.$http.get("/department/getList").then(function (response) {
                            var data = response.data;
                            me.$set("departmentList", data.results);
                        }, function (response) {
                            jQuery.fn.error_msg("无法获取部门列表信息,请刷新后重新尝试!");
                        });


                        jQuery("#chargeDepart").select2({
                            width: '100%'
                        }).on("change", function (event) {
                            var id = event.val;
                            me.$set("chargeDepart", id);
                        });
                    }
                });
                LIMS.dialog.$set('title', '修改环境要素');
                LIMS.dialog.currentView = 'project_change_item' + index;
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
            var me = this;
            var dom = jQuery(me.$el);
            this.load_list("", 1);

            me.$http.get("/category/getList").then(function (response) {
                var data = response.data;
                me.$set("projects", data.results);
            }, function (response) {

            });

            dom.find("#category_choose").on("change", function (event) {
                var index = event.val;
                var condition = "";
                if (index != 0) {
                    condition = "category_id=" + index;
                }
                me.load_list(condition, 1);
            });

            dom.find('.select2').select2({
                width: '100%',
                minimumResultsForSearch: -1
            });
        }
    })
</script>


