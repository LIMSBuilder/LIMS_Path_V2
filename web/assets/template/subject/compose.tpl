<div class="panel-body">

    <div class="form-group">
        <div class="col-md-12">
            <select class="select2" id="receiver" v-model="receiver" multiple data-placeholder="选择收件人">
                {{each receiver_list as item}}
                    <option value="{{item.id}}">{{item.department_name}} / {{item.role_name}} / {{item.name}} / {{item.username}}</option>
                {{/each}}
            </select>
        </div>
        <!--<div class="col-md-1">-->
        <!--<a class="btn btn-success" id="choose_more">批量选择</a>-->
        <!--</div>-->
    </div>
    <div class="form-group">
        <div class="col-md-12">
            <input type="text" name="title" v-model="title" placeholder="邮件主题" class="form-control"/>
        </div>
    </div>

    <div class="form-group">
        <div class="col-md-12">
            <textarea id="wysiwyg" v-model="content" placeholder="请输入邮件正文..." class="form-control" rows="20"></textarea>
        </div>
    </div>


</div><!-- panel-body -->
<div class="panel-footer">
    <div class="col-md-12">
        <button class="btn btn-primary" @click="send">发 送</button>
        <button class="btn btn-default" @click="draft">存为草稿</button>
    </div>
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
                this.$set("receiver", jQuery("#receiver").select2("val"));
                this.$set("content", jQuery("#wysiwyg").val());
                //console.log(this.receiver_list);
                //console.log(this.content);
                console.log(JSON.stringify(this._data));
            },
            draft: function () {
                this.$set("receiver", jQuery("#receiver").select2("val"));
                this.$set("content", jQuery("#wysiwyg").val());

                console.log(JSON.stringify(this._data));
            }
        }, ready: function () {
            var me = this;

//            me.$http.get("/assets/json/mail_receiver_list.json").then(function (response) {
//                var data = response.data;
//                console.log(data.results);
//                //me.$set("receiver_list", data.results);
//            }, function (response) {
//
//            });
            // Select2
            jQuery(".select2").select2({
                width: '100%'
            });
            // HTML5 WYSIWYG Editor
            jQuery('#wysiwyg').wysihtml5({color: true, html: true});
        }

    });


</script>