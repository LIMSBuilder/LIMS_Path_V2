<!-- Nav tabs -->
<ul class="nav nav-tabs">
    <li class="active"><a href="#home" data-toggle="tab"><strong>上传模板</strong></a></li>
    <li><a href="#profile" data-toggle="tab"><strong>模板列表</strong></a></li>
</ul>

<!-- Tab panes -->
<div class="tab-content mb30">
    <div class="tab-pane active" id="home">
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
    <div class="tab-pane" id="profile">
        <div class="row">

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
                category_list: []
            },
            methods: {},
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