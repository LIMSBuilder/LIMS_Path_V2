<div class="row">
    <div class="col-md-12">
        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title">乙方预设信息</h3>
            </div>
            <div class="panel-body">
                <form class="form-horizontal form-bordered" id="default_info">
                    <div class="form-group">
                        <label class="col-sm-2 text-center  control-label">受托单位</label>
                        <div class="col-sm-9">
                            <input type="text" placeholder="请输入单位名称" v-model="trustee_unit" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 text-center  control-label">邮政编码</label>
                        <div class="col-sm-9">
                            <input type="text" placeholder="请输入邮政编码" v-model="trustee_code" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 text-center  control-label">联系地址</label>
                        <div class="col-sm-9">
                            <input type="text" placeholder="请输入联系地址" v-model="trustee_address" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 text-center  control-label">联系电话</label>
                        <div class="col-sm-9">
                            <input type="text" placeholder="请输入联系电话" v-model="trustee_tel" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 text-center  control-label">承办人</label>
                        <div class="col-sm-9">
                            <input type="text" placeholder="请输入承办人姓名" v-model="trustee" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 text-center  control-label">传真电话</label>
                        <div class="col-sm-9">
                            <input type="text" placeholder="请输入传真" v-model="trustee_fax" class="form-control">
                        </div>
                    </div>
                    <div class="form-group text-center">
                        <a class="btn btn-primary" @click="save">保存设置</a>
                        <a class="btn btn-default" @click="clear">清 空 </a>
                    </div>

                </form>
            </div>
        </div><!-- panel -->

    </div>

</div>


<script type="text/javascript">
    var vue = new Vue({
        el: '#contentpanel',
        data: {
            "trustee_unit": "",
            "trustee_code": "",
            "trustee_address": "",
            "trustee_tel": "",
            "trustee": "",
            "trustee_fax": ""
        },
        methods: {
            save: function () {
                console.log(JSON.parse(JSON.stringify(this._data)));
            },
            clear: function () {
                var me = this;
                //var temp = jQuery("#default_info")[0];
                //temp.reset();
                var data = this._data;
                for (var key in data) {
                    me.$set(key, "");
                }
            }
        },
        ready: function () {
            var me = this;
            me.$http.get("/assets/json/contract_default.json").then(function (response) {
                var data = response.data;
                for (var key in data) {
                    me.$set(key, data[key]);
                }
            }, function (response) {
            });
        }
    });

</script>