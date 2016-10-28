<div class="row">
    <div class="col-md-12">
        <form id="customer_form">
            <div class="form-group">
                <label class="col-sm-2 control-label text-center">委托单位 </label>
                <div class="col-sm-8">
                    <input type="text" name="client_unit" v-model="client_unit" class="form-control"
                           required/>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label text-center">邮政编码</label>
                <div class="col-sm-8">
                    <input type="text" name="client_code" v-model="client_code" class="form-control"
                           required/>
                </div>
            </div>

            <div class="form-group">
                <label class="col-sm-2 control-label text-center">联系地址</label>
                <div class="col-sm-8">
                    <input type="text" name="client_address" v-model="client_address"
                           class="form-control" required/>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label text-center">联系电话</label>
                <div class="col-sm-8">
                    <input type="text" name="client_tel" v-model="client_tel" class="form-control"
                           required/>
                </div>
            </div>

            <div class="form-group">
                <label class="col-sm-2 control-label text-center">联系人</label>
                <div class="col-sm-8">
                    <input type="text" name="client" v-model="client"
                           class="form-control" required/>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label text-center">传真电话</label>
                <div class="col-sm-8">
                    <input type="text" name="client_fax" v-model="client_fax" class="form-control"
                           required/>
                </div>
            </div>
            <div class="form-group">
                <div class="text-center">
                    <a class="btn btn-primary" @click="save">保 存</a>
                    <a class="btn btn-default" data-dismiss="modal">关 闭</a>
                </div>
            </div>
        </form>
    </div>
</div>