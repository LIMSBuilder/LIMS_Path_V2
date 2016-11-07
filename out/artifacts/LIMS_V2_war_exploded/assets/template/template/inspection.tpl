<!-- Nav tabs -->
<ul class="nav nav-tabs">
    <li class="active"><a href="#upload" data-toggle="tab"><strong>上传模板</strong></a></li>
    <li><a href="#category_page" data-toggle="tab"><strong>环境要素列表</strong></a></li>
    <li><a href="#template_page" data-toggle="tab"><strong>送检模板列表</strong></a></li>
</ul>

<!-- Tab panes -->
<div class="tab-content mb30">
    <div class="tab-pane active" id="upload">
        <div class="row">
            <div class="col-sm-12">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-3 control-label">模板名称 <span class="asterisk">*</span></label>
                        <div class="col-sm-6">
                            <input type="text" placeholder="请输入送检单模板名称" v-model="name" class="form-control" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">绑定分类</label>
                        <div class="col-sm-6">
                            <select class="select2" id="category" data-placeholder="选择环境要素">
                                <option value=""></option>
                                <template v-for="item in category_list">
                                    <option value="{{item.id}}">{{item.name}}</option>
                                </template>
                            </select>
                            <label class="help-block">为当前送检单模板绑定环境要素,该环境要素的所有检测项将使用当前送检单模板。</label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">上传模板</label>
                        <div class="col-sm-6">
                            <div id="dropz" class="dropzone"></div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="text-center">
                            <a class="btn btn-primary-alt" id="save_template">保存模板</a>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <div class="tab-pane" id="category_page">
        <div class="row">
            <div class="table-responsive">
                <table class="table table-info table-hover mb30 text-center">
                    <thead>
                    <tr>
                    <tr>
                        <th class="text-center">环境要素</th>
                        <th class="text-center">送检模板</th>
                        <th class="text-center">操作</th>
                    </tr>
                    </tr>
                    </thead>
                    <tbody>
                    <template v-for="item in results">
                        <tr>
                            <td class="text-center">{{item.name}}</td>
                            <td class="text-center">{{item.template.name}}</td>
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
            <div id="category_paging" class="paging nomargin pull-right"></div>
        </div>
    </div>
    <div class="tab-pane" id="template_page">
        <div class="row">
            <div class="table-responsive">
                <table class="table table-info table-hover mb30 text-center">
                    <thead>
                    <tr>
                    <tr>
                        <th class="text-center">模板名称</th>
                        <th class="text-center">操作</th>
                    </tr>
                    </tr>
                    </thead>
                    <tbody>
                    <template v-for="item in template_list">
                        <tr>
                            <td class="text-center">{{item.name}}</td>
                            <td class="table-action text-center">
                                <a href="javascript:;" data-toggle="modal"
                                   data-target=".bs-example-modal-static"
                                   @click="edit_template(item)"><i
                                        class="fa fa-edit"></i></a>
                                <a href="javascript:;" class="delete-row" @click="delete_template(item)"><i
                                        class="fa fa-trash-o "></i></a>
                            </td>
                        </tr>
                    </template>
                    </tbody>
                </table>
            </div><!-- table-responsive -->
            <div id="template_paging" class="paging nomargin pull-right"></div>
        </div>
    </div>
</div>
<script type="text/javascript" src="/assets/js/dropzone.min.js"></script>
<script type="text/javascript">
    jQuery(document).ready(function () {
        var vue = new Vue({
            el: "#contentpanel",
            data: {
                name: "",
                category_id: "",
                category_list: [],
                results: [],
                template_list: []
            },
            methods: {
                edit_item: function (data) {
                    var me = this;
                    var index = data.id;
                    var template = jQuery.fn.loadTemplate("/assets/template/subject/template_inspection.tpl");
                    Vue.component('category_change_item' + index, {
                        template: template,
                        data: function () {
                            return {
                                templateList: []
                            };
                        },
                        methods: {
                            save: function (item) {
                                var that = this;
                                if (!jQuery('#template_choose').val()) {
                                    jQuery.fn.error_msg("请选择送检模板!");
                                    return;
                                }
                                var data = {
                                    id: index,
                                    template_id: jQuery('#template_choose').val()
                                };

                                me.$http.post("/template/setInspection", data).then(function (response) {
                                    var data = response.data;
                                    jQuery.fn.codeState(data.code, {
                                        200: function () {
                                            jQuery.fn.alert_msg("环境要素模板设置成功!");
                                            var currentPage = parseInt(jQuery('#category_paging span').html());
                                            me.load_list("", currentPage);
                                            jQuery("#custom_modal").modal("hide");
                                        }
                                    });
                                }, function (response) {
                                    jQuery.fn.error_msg("无法获取环境要素列表信息,请尝试刷新操作。");
                                });
                            }
                        },
                        ready: function () {
                            var me = this;
                            me.$http.get("/template/getInspection").then(function (response) {
                                var data = response.data;
                                me.$set("templateList", data.results);
                            }, function (response) {
                                jQuery.fn.error_msg("服务器异常,无法获取模板列表!");
                            });
                            jQuery("#template_choose").select2({
                                width: '100%'
                            })
                        }
                    });
                    LIMS.dialog.$set('title', '修改环境要素');
                    LIMS.dialog.currentView = 'category_change_item' + index;
                },
                del_item: function (data) {
                    var me = this;
                    var id = data.id;
                    jQuery.fn.check_msg({
                        msg: "是否删除【" + data.name + "】的送检模板?",
                        success: function () {
                            me.$http.get("/template/deleteInspection", {
                                params: {
                                    id: id
                                }
                            }).then(function (response) {
                                var data = response.data;
                                jQuery.fn.codeState(data.code, {
                                    200: function () {
                                        jQuery.fn.alert_msg("删除成功!");
                                        var currentPage = parseInt(jQuery('#category_paging span').html());
                                        me.load_list("", currentPage);
                                    }
                                })
                            }, function (response) {

                            });
                        }
                    })
                },
                edit_template: function (data) {
                    var me = this;
                    var index = data.id;
                    var template = jQuery.fn.loadTemplate("/assets/template/subject/template_inspection_change.tpl");
                    Vue.component('template_change_item' + index, {
                        template: template,
                        data: function () {
                            return {
                                name: data.name
                            };
                        },
                        methods: {
                            save: function (item) {
                                var that = this;
                                var data = {
                                    id: index,
                                    name: that.name
                                };
                                me.$http.post("/template/changeInspectionTemplate", data).then(function (response) {
                                    var data = response.data;
                                    jQuery.fn.codeState(data.code, {
                                        200: function () {
                                            jQuery.fn.alert_msg("送检模板修改成功!");
                                            var currentPage = parseInt(jQuery('#template_paging span').html());
                                            me.load_template("", currentPage);
                                            var currentCategoryPage = parseInt(jQuery('#category_paging span').html());
                                            me.load_list("", currentCategoryPage);
                                            jQuery("#custom_modal").modal("hide");
                                        }
                                    });
                                }, function (response) {
                                    jQuery.fn.error_msg("无法获取送检模板列表信息,请尝试刷新操作。");
                                });
                            }
                        }
                    });
                    LIMS.dialog.$set('title', '修改送检模板');
                    LIMS.dialog.currentView = 'template_change_item' + index;
                },
                delete_template: function (data) {
                    var me = this;
                    var id = data.id;
                    jQuery.fn.check_msg({
                        msg: "是否删除【"+data.name+"】模板?",
                        success: function () {
                            me.$http.get("/template/delInspectionTemplate", {
                                params: {
                                    id: id
                                }
                            }).then(function (response) {
                                var data = response.data;
                                jQuery.fn.codeState(data.code, {
                                    200: function () {
                                        jQuery.fn.alert_msg("模板删除成功!");
                                        var currentPage = parseInt(jQuery('#template_paging span').html());
                                        me.load_template("", currentPage);
                                        var currentCategoryPage = parseInt(jQuery('#category_paging span').html());
                                        me.load_list("", currentCategoryPage);
                                    }
                                })
                            }, function (response) {
                                jQuery.fn.error_msg("服务器异常,无法删除送检模板!");
                            });
                        }
                    });
                },
                load_list: function (condition, currentPage) {
                    var me = this;
                    var dom = jQuery(me.$el);
                    var rowCount = localStorage.getItem("rowCount") || 0;
                    me.$http.get("/category/list", {
                        params: {
                            rowCount: rowCount,
                            currentPage: currentPage,
                            condition: condition
                        }
                    }).then(function (response) {
                        var data = response.data;
                        me.$set("results", data.results);
                        //页码事件
                        dom.find('#category_paging').pagination({
                            pageCount: data.totalPage != 0 ? data.totalPage : 1,
                            coping: true,
                            homePage: '首页',
                            endPage: '末页',
                            prevContent: '上页',
                            nextContent: '下页',
                            current: data.currentPage,
                            callback: function (page) {
                                var currentPage = page.getCurrent();
                                me.$http.get("/category/list", {
                                    params: {
                                        rowCount: rowCount,
                                        currentPage: currentPage,
                                        condition: data.condition
                                    }
                                }).then(function (response) {
                                    var data = response.data;
                                    me.$set("results", data.results);
                                }, function (response) {
                                    jQuery.fn.error_msg("无法获取环境要素列表信息,请尝试刷新操作。");
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
                load_template: function (condition, currentPage) {
                    var me = this;
                    var dom = jQuery(me.$el);
                    var rowCount = localStorage.getItem("rowCount") || 0;
                    me.$http.get("/template/inspectionList", {
                        params: {
                            rowCount: rowCount,
                            currentPage: currentPage,
                            condition: condition
                        }
                    }).then(function (response) {
                        var data = response.data;
                        me.$set("template_list", data.results);
                        //页码事件
                        dom.find('#template_paging').pagination({
                            pageCount: data.totalPage != 0 ? data.totalPage : 1,
                            coping: true,
                            homePage: '首页',
                            endPage: '末页',
                            prevContent: '上页',
                            nextContent: '下页',
                            current: data.currentPage,
                            callback: function (page) {
                                var currentPage = page.getCurrent();
                                me.$http.get("/template/inspectionList", {
                                    params: {
                                        rowCount: rowCount,
                                        currentPage: currentPage,
                                        condition: data.condition
                                    }
                                }).then(function (response) {
                                    var data = response.data;
                                    me.$set("template_list", data.results);
                                }, function (response) {
                                    jQuery.fn.error_msg("无法获取环境要素列表信息,请尝试刷新操作。");
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
                }
            },
            ready: function () {
                var me = this;
                me.$http.get("/category/getList").then(function (response) {
                    var data = response.data;
                    me.$set("category_list", data.results);
                }, function (response) {
                    jQuery.fn.error_msg("服务器异常,无法获取环境要素列表信息!");
                });

                jQuery("#category").select2({
                    width: '100%'
                }).on("change", function (event) {
                    me.category_id = event.val;
                });

                me.load_list("", 1);

                me.load_template("", 1);
                $("#dropz").dropzone({
                    url: "/file/upload",
                    maxFilesize: 2,
                    method: "post",
                    maxFiles: 1,
                    paramName: 'inspection_template',
                    addRemoveLinks: true,//添加移除文,
                    autoProcessQueue: false,//不自动上传
                    dictCancelUploadConfirmation: '你确定要取消上传吗？',
                    dictMaxFilesExceeded: "您一次最多只能上传{{maxFiles}}个文件",
                    dictResponseError: '文件上传失败!',
                    dictInvalidFileType: "你不能上传该类型文件,文件类型只能是Word文档。",
                    dictCancelUpload: "取消上传",
                    dictCancelUploadConfirmation: "你确定要取消上传吗?",
                    dictRemoveFile: "移除文件",
                    uploadMultiple: false,
                    init: function () {
                        var dropObj = this;
                        dropObj.on("success", function (file) {
                            if (file.xhr.status != 200) {
                                jQuery.fn.error_msg("服务器异常,无法上传文件!");
                                return;
                            }
                            var data = JSON.parse(file.xhr.responseText);
                            if (data.code == 200) {
                                me.$http.post("/template/inspection", {
                                    name: me.name,
                                    category_id: me.category_id,
                                    path: data.path
                                }).then(function (response) {
                                    var data = response.data;
                                    jQuery.fn.codeState(data.code, {
                                        200: function () {
                                            jQuery.fn.alert_msg("送检模板保存成功!");
                                        }
                                    })
                                }, function (response) {
                                    jQuery.fn.error_msg("送检模板保存失败,请刷新后重新尝试!");
                                });
                            }
                        });

                        jQuery("#save_template").off("click").on("click", function () {
                            jQuery.fn.check_msg({
                                msg: "是否保存当前送检单模板?",
                                success: function () {
                                    var data = dropObj.processQueue();
                                    dropObj.removeAllFiles();
                                }
                            });
                        });
                    }
                });
            }
        });
    });
</script>