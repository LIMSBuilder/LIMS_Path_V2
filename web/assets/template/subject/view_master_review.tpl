<div class="row">
    <div class="col-sm-12">
        <form class="form-horizontal">
            <div class="form-group">
                <label class="col-sm-5 control-label">原始记录是否填写完整？</label>
                <label class="col-sm-1 control-label text-success" v-if="firstResult1==0"
                       style="text-align: left">是</label>
                <label class="col-sm-1 control-label text-danger" v-if="firstResult1==1"
                       style="text-align: left">否</label>
                <label class="col-sm-1 control-label text-warning" v-if="firstResult1==2"
                       style="text-align: left">纠正</label>
            </div>
            <div class="form-group">
                <label class="col-sm-5 control-label">监测数据有效位数是否规范？</label>
                <label class="col-sm-1 control-labe text-success" v-if="firstResult2==0"
                       style="text-align: left">是</label>
                <label class="col-sm-1 control-label text-danger" v-if="firstResult2==1"
                       style="text-align: left">否</label>
                <label class="col-sm-1 control-label text-warning" v-if="firstResult2==2"
                       style="text-align: left">纠正</label>
            </div>
            <div class="form-group">
                <label class="col-sm-5 control-label">原始记录修改是否符合规范？</label>
                <label class="col-sm-1 control-label text-success" v-if="firstResult3==0"
                       style="text-align: left">是</label>
                <label class="col-sm-1 control-label text-danger" v-if="firstResult3==1"
                       style="text-align: left">否</label>
                <label class="col-sm-1 control-label text-warning" v-if="firstResult3==2"
                       style="text-align: left">纠正</label>
            </div>
            <div class="form-group">
                <label class="col-sm-5 control-label">送检单结果与记录是否一致？</label>
                <label class="col-sm-1 control-label text-success" v-if="firstResult4==0"
                       style="text-align: left">是</label>
                <label class="col-sm-1 control-label text-danger" v-if="firstResult4==1"
                       style="text-align: left">否</label>
                <label class="col-sm-1 control-label text-warning" v-if="firstResult4==2"
                       style="text-align: left">纠正</label>
            </div>
            <div class="form-group">
                <label class="col-sm-5 control-label">原始记录审核是否完整？</label>
                <label class="col-sm-1 control-label text-success" v-if="firstResult5==0"
                       style="text-align: left">是</label>
                <label class="col-sm-1 control-label text-danger" v-if="firstResult5==1"
                       style="text-align: left">否</label>
                <label class="col-sm-1 control-label text-warning" v-if="firstResult5==2"
                       style="text-align: left">纠正</label>
            </div>
            <div class="form-group">
                <label class="col-sm-5 control-label">标准曲线是否符合规范？</label>
                <label class="col-sm-1 control-label text-success" v-if="firstResult6==0"
                       style="text-align: left">是</label>
                <label class="col-sm-1 control-labe text-danger" v-if="firstResult6==1"
                       style="text-align: left">否</label>
                <label class="col-sm-1 control-label text-warning" v-if="firstResult6==2"
                       style="text-align: left">纠正</label>
            </div>
            <div class="form-group">
                <label class="col-sm-5 control-label">其他信息:</label>
                <label class="col-sm-6 control-label" style="text-align: left">{{other}}</label>
            </div>
            <hr>
            <div class="form-group">
                <label class="col-sm-3 control-label">审核人:</label>
                <label class="col-sm-3 control-label" style="text-align: left">{{result_user.name}}</label>
                <label class="col-sm-3 control-label">审核时间:</label>
                <label class="col-sm-3 control-label" style="text-align: left">{{result_time}}</label>
            </div>
        </form>
    </div>
</div>