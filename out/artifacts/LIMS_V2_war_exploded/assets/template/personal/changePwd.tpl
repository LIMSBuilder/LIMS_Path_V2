<div class="panel panel-default">
    <div class="panel-body">
        <div class="alert alert-warning">
            <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
            <strong>❗️请保管好自己的账号密码，每个月修改一次密码可以有效防止密码泄露。</strong>
        </div>
        <form class="form-horizontal">
            <div class="form-group">
                <label class="col-sm-3 control-label" for="username">当前登录账号</label>
                <div class="col-sm-6">
                    <input type="text" id="username" v-model="username" class="form-control"
                           readonly="readonly">
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label">原密码</label>
                <div class="col-sm-6">
                    <input type="password" v-model="old_pwd" placeholder="请输入原密码" class="form-control">
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label">新密码</label>
                <div class="col-sm-6">
                    <input type="password" v-model="new_pwd" placeholder="请输入新密码" class="form-control">
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label">重复新密码</label>
                <div class="col-sm-6">
                    <input type="password" v-model="repeat_pwd" placeholder="请再次输入新密码" class="form-control">
                </div>
            </div>
            <hr>
            <div class="form-group">
                <div class="text-center">
                    <a class="btn btn-primary" @click="save">保存设置</a>
                    <a class="btn btn-default" @click="clear">清空</a>
                </div>
            </div>
        </form>
    </div>
</div>
<script type="text/javascript">
    var vue = new Vue({
        el: "#contentpanel",
        data: {
            "username": "zhangSan",
            "new_pwd": "",
            "old_pwd": "",
            "repeat_pwd": ""
        },
        methods: {
            save: function () {
                var me = this;
                if (me.old_pwd == "") {
                    jQuery.fn.error_msg("请输入当前登录密码!");
                    return;
                }
                if (me.new_pwd == "") {
                    jQuery.fn.error_msg("请输入新登录密码!");
                    return;
                }
                if (me.new_pwd != me.repeat_pwd) {
                    jQuery.fn.error_msg("两次新密码输入不一致!");
                    return;
                }
                jQuery.fn.alert_msg("密码修改成功");
            },
            clear: function () {
                var me = this;
                me.old_pwd = "";
                me.new_pwd = "";
                me.repeat_pwd = "";
            }
        },
        ready: function () {

        }
    });

</script>