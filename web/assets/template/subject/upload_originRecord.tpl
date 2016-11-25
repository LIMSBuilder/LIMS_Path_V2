<div class="row">
    <div class="col-sm-12">
        <form class="form-horizontal">
            <div class="form-group">
                <label class="col-sm-3 control-label">记录名称 <span class="asterisk">*</span></label>
                <div class="col-sm-8">
                    <input type="text" placeholder="请输入原始记录名称" v-model="name" class="form-control" required>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label">上传记录 <span class="asterisk">*</span></label>
                <div class="col-sm-8">
                    <div id="dropz" class="dropzone"></div>
                </div>
            </div>
            <div class="form-group">
                <div class="text-center">
                    <a class="btn btn-primary-alt" id="save_originRecord">保存记录</a>
                </div>
            </div>
        </form>
    </div>
</div>