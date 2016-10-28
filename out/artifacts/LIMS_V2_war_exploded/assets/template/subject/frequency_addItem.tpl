<div class="row">
    <div class="col-md-12">
        <form id="frequency_form">
            <div class="form-group">
                <label class="col-sm-2 control-label text-center">监测频次 </label>
                <div class="col-sm-8">
                    <input type="text" name="client_unit" v-model="name" class="form-control"
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