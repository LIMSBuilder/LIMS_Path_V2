<div class="panel-body">

    <div class="form-group">
        <div class="col-md-12">
            <select class="select2" id="receiver" v-model="receiver" multiple data-placeholder="选择收件人">
                {{each receiver_list as item}}
                <option value="{{item.id}}">{{item.role.department.name}}-{{item.role.name}}-{{item.name}}</option>
                {{/each}}
            </select>
        </div>
    </div>
    <div class="form-group">
        <div class="col-md-12">
            <input type="text" name="title" v-model="title" placeholder="邮件主题" class="form-control"/>
        </div>
    </div>

    <div class="form-group">
        <div class="col-md-12">
            <textarea id="wysiwyg" placeholder="请输入邮件正文..." class="form-control" rows="20"></textarea>
        </div>
    </div>


</div><!-- panel-body -->
<div class="col-md-12 btn-demo text-center">
    <a class="btn btn-success-alt clear-float" @click="send">发 送</a>
    <a class="btn btn-default-alt clear-float" @click="draft">存为草稿</a>
</div>

<script src="/assets/js/chosen.jquery.min.js"></script>
<script src="/assets/js/wysihtml5-0.3.0.min.js"></script>
<script src="/assets/js/bootstrap-wysihtml5.js"></script>


<script>
    var vue = new Vue({
        el: "#mail_right",
        data: {
            title: "",
            content: "",
            receiver: []
        }, methods: {
            send: function () {
                var me = this;
                this.$set("receiver", jQuery("#receiver").select2("val"));
                this.$set("content", jQuery("#wysiwyg").val());
                console.log(JSON.stringify(this._data));
                me.$http.post("/mail/send", me._data).then(function (response) {
                    var data = response.data;
                    jQuery.fn.codeState(data.code, {
                        200: function () {
                            jQuery.fn.alert_msg("邮件发送成功!");
                        }
                    })
                }, function (response) {
                    jQuery.fn.error_msg("服务器异常,无法发送邮件!");
                });
            },
            draft: function () {
                this.$set("receiver", jQuery("#receiver").select2("val"));
                this.$set("content", jQuery("#wysiwyg").val());

                console.log(JSON.stringify(this._data));
            }
        }, ready: function () {
            var me = this;

            // Select2
            jQuery("#receiver").select2({
                width: '100%'
            });
            // HTML5 WYSIWYG Editor
            jQuery('#wysiwyg').wysihtml5({color: true, html: true});
        }

    });


</script>