<div class="row">
    <div class="col-sm-12">
        <form class="form-horizontal form-bordered">
            <div class="form-group">
                <label class="col-sm-4 control-label">原始记录是否填写完整？</label>
                <div class="col-sm-6">
                    <div class="radio col-sm-2"><label><input type="radio" v-model="firstResult1" value="0"> 是</label></div>
                    <div class="radio col-sm-2"><label><input type="radio" v-model="firstResult1" value="1"> 否</label></div>
                    <div class="radio col-sm-2"><label><input type="radio" v-model="firstResult1" value="2"> 纠正</label></div>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-4 control-label">监测数据有效位数是否规范？</label>
                <div class="col-sm-6">
                    <div class="radio col-sm-2"><label><input type="radio" v-model="firstResult2" value="0"> 是</label></div>
                    <div class="radio col-sm-2"><label><input type="radio" v-model="firstResult2" value="1"> 否</label></div>
                    <div class="radio col-sm-2"><label><input type="radio" v-model="firstResult2" value="2"> 纠正</label></div>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-4 control-label">原始记录修改是否符合规范？</label>
                <div class="col-sm-6">
                    <div class="radio col-sm-2"><label><input type="radio" v-model="firstResult3" value="0"> 是</label></div>
                    <div class="radio col-sm-2"><label><input type="radio" v-model="firstResult3" value="1"> 否</label></div>
                    <div class="radio col-sm-2"><label><input type="radio" v-model="firstResult3" value="2"> 纠正</label></div>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-4 control-label">送检单结果与记录是否一致？</label>
                <div class="col-sm-6">
                    <div class="radio col-sm-2"><label><input type="radio" v-model="firstResult4" value="0"> 是</label></div>
                    <div class="radio col-sm-2"><label><input type="radio" v-model="firstResult4" value="1"> 否</label></div>
                    <div class="radio col-sm-2"><label><input type="radio" v-model="firstResult4" value="2"> 纠正</label></div>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-4 control-label">原始记录审核是否完整？</label>
                <div class="col-sm-6">
                    <div class="radio col-sm-2"><label><input type="radio" v-model="firstResult5" value="0"> 是</label></div>
                    <div class="radio col-sm-2"><label><input type="radio" v-model="firstResult5" value="1"> 否</label></div>
                    <div class="radio col-sm-2"><label><input type="radio" v-model="firstResult5" value="2"> 纠正</label></div>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-4 control-label">标准曲线是否符合规范？</label>
                <div class="col-sm-6">
                    <div class="radio col-sm-2"><label><input type="radio" v-model="firstResult6" value="0"> 是</label></div>
                    <div class="radio col-sm-2"><label><input type="radio" v-model="firstResult6" value="1"> 否</label></div>
                    <div class="radio col-sm-2"><label><input type="radio" v-model="firstResult6" value="2"> 纠正</label></div>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-4 control-label">其他信息:</label>
                <div class="col-sm-6">
                    <textarea class="form-control" v-model="other" rows="5"></textarea>
                </div>
            </div>
        </form>
    </div>
    <div class="col-md-12 text-center">
        <div class="btn-demo">
            <a class="btn btn-primary-alt" @click="addReview" href="javascript:;" style="float: none;">审 核</a>
            <a class="btn btn-default-alt" data-dismiss="modal" href="javascript:;" style="float: none;">取 消</a>
        </div>
    </div>
</div>