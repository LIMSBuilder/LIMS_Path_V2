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
                <div class="text-center">
                    <a class="btn btn-primary-alt" @click="save" id="save_template">保存修改</a>
                </div>
            </div>
        </form>
    </div>
</div>