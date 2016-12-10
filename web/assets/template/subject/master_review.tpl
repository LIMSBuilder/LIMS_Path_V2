<div class="row">
    <div class="col-sm-12">
        <form class="form-horizontal form-bordered">
            <div class="form-group">
                <label class="col-sm-5 control-label">原始记录是否填写完整？</label>
                <div class="col-sm-6">
                    <div class="radio col-sm-2"><label><input type="radio"> 是</label></div>
                    <div class="radio col-sm-2"><label><input type="radio"> 否</label></div>
                    <div class="radio col-sm-2"><label><input type="radio"> 纠正</label></div>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-5 control-label">监测数据有效位数是否规范？</label>
                <div class="col-sm-6">
                    <div class="radio col-sm-2"><label><input type="radio"> 是</label></div>
                    <div class="radio col-sm-2"><label><input type="radio"> 否</label></div>
                    <div class="radio col-sm-2"><label><input type="radio"> 纠正</label></div>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-5 control-label">原始记录修改是否符合规范？</label>
                <div class="col-sm-6">
                    <div class="radio col-sm-2"><label><input type="radio"> 是</label></div>
                    <div class="radio col-sm-2"><label><input type="radio"> 否</label></div>
                    <div class="radio col-sm-2"><label><input type="radio"> 纠正</label></div>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-5 control-label">送检单结果与记录是否一致？</label>
                <div class="col-sm-6">
                    <div class="radio col-sm-2"><label><input type="radio"> 是</label></div>
                    <div class="radio col-sm-2"><label><input type="radio"> 否</label></div>
                    <div class="radio col-sm-2"><label><input type="radio"> 纠正</label></div>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-5 control-label">原始记录审核是否完整？</label>
                <div class="col-sm-6">
                    <div class="radio col-sm-2"><label><input type="radio"> 是</label></div>
                    <div class="radio col-sm-2"><label><input type="radio"> 否</label></div>
                    <div class="radio col-sm-2"><label><input type="radio"> 纠正</label></div>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-5 control-label">标准曲线是否符合规范？</label>
                <div class="col-sm-6">
                    <div class="radio col-sm-2"><label><input type="radio"> 是</label></div>
                    <div class="radio col-sm-2"><label><input type="radio"> 否</label></div>
                    <div class="radio col-sm-2"><label><input type="radio"> 纠正</label></div>
                </div>
            </div>
        </form>
    </div>
    <div class="col-md-12 text-center">
        <div class="btn-demo">
            <a class="btn btn-primary-alt" @click="save_review" href="javascript:;" style="float: none;">审 核</a>
            <a class="btn btn-default-alt" data-dismiss="modal" href="javascript:;" style="float: none;">取 消</a>
        </div>
    </div>
</div>