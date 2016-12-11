<div class="row">
    <div class="col-sm-12">
        <form class="form-horizontal form-bordered">
            <div class="form-group">
                <label class="col-sm-4 control-label">质控样品比例是否满足要求？</label>
                <div class="col-sm-6">
                    <div class="radio col-sm-2"><label><input type="radio" v-model="secondResult1" value="0"> 是</label>
                    </div>
                    <div class="radio col-sm-2"><label><input type="radio" v-model="secondResult1" value="1"> 否</label>
                    </div>
                    <div class="radio col-sm-2"><label><input type="radio" v-model="secondResult1" value="2"> 纠正</label>
                    </div>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-4 control-label">监测过程是否满足规范要求？</label>
                <div class="col-sm-6">
                    <div class="radio col-sm-2"><label><input type="radio" v-model="secondResult2" value="0"> 是</label>
                    </div>
                    <div class="radio col-sm-2"><label><input type="radio" v-model="secondResult2" value="1"> 否</label>
                    </div>
                    <div class="radio col-sm-2"><label><input type="radio" v-model="secondResult2" value="2"> 纠正</label>
                    </div>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-4 control-label">监测分析方法是否现行有效？</label>
                <div class="col-sm-6">
                    <div class="radio col-sm-2"><label><input type="radio" v-model="secondResult3" value="0"> 是</label>
                    </div>
                    <div class="radio col-sm-2"><label><input type="radio" v-model="secondResult3" value="1"> 否</label>
                    </div>
                    <div class="radio col-sm-2"><label><input type="radio" v-model="secondResult3" value="2"> 纠正</label>
                    </div>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-4 control-label">回收率是否合格？</label>
                <div class="col-sm-6">
                    <div class="radio col-sm-2"><label><input type="radio" v-model="secondResult4" value="0"> 是</label>
                    </div>
                    <div class="radio col-sm-2"><label><input type="radio" v-model="secondResult4" value="1"> 否</label>
                    </div>
                    <div class="radio col-sm-2"><label><input type="radio" v-model="secondResult4" value="2"> 纠正</label>
                    </div>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-4 control-label">平行样偏差是否满足要求？</label>
                <div class="col-sm-6">
                    <div class="radio col-sm-2"><label><input type="radio" v-model="secondResult5" value="0"> 是</label>
                    </div>
                    <div class="radio col-sm-2"><label><input type="radio" v-model="secondResult5" value="1"> 否</label>
                    </div>
                    <div class="radio col-sm-2"><label><input type="radio" v-model="secondResult5" value="2"> 纠正</label>
                    </div>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-4 control-label">空白样测试结果是否满足要求？</label>
                <div class="col-sm-6">
                    <div class="radio col-sm-2"><label><input type="radio" v-model="secondResult6" value="0"> 是</label>
                    </div>
                    <div class="radio col-sm-2"><label><input type="radio" v-model="secondResult6" value="1"> 否</label>
                    </div>
                    <div class="radio col-sm-2"><label><input type="radio" v-model="secondResult6" value="2"> 纠正</label>
                    </div>
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