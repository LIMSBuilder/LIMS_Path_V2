<div class="row">
    <div class="col-md-12">
        <div class="table-responsive">
            <table class="table table-hover table-info mb30">
                <thead>
                <tr>
                    <th class="text-center">编号</th>
                    <th class="text-center">审核人</th>
                    <th class="text-center">审核时间</th>
                    <th class="text-center">状态</th>
                    <th class="text-center"></th>
                </tr>
                </thead>
                <tbody>
                <template v-for="(index , result) in result_list">
                    <tr class="text-center">
                        <td>{{index+1}}</td>
                        <td>{{result.result_user.name}}</td>
                        <td>{{result.result_time}}</td>
                        <td v-if="nowResult.id==result.id">
                            <span class="label label-success">当 前</span>
                        </td>
                        <td v-else>
                            <span class="label label-warning">历 史</span>
                        </td>
                        <td class="table-action">
                            <a class="btn btn-sm btn-info-alt"
                               @click="showInfo(result)">查 看</a>
                        </td>
                    </tr>
                </template>
                </tbody>
            </table>
        </div><!-- table-responsive -->
    </div>
    <template v-if="isShow">
        <div class="col-sm-12">
            <form class="form-horizontal">
                <div class="form-group">
                    <div class="col-sm-3"></div>
                    <label class="col-sm-3 ">原始记录是否填写完整？</label>
                    <label class="col-sm-1  text-success" v-if="record.firstResult1==0"
                           style="text-align: left">是</label>
                    <label class="col-sm-1  text-danger" v-if="record.firstResult1==1"
                           style="text-align: left">否</label>
                    <label class="col-sm-1  text-warning" v-if="record.firstResult1==2"
                           style="text-align: left">纠正</label>
                </div>
                <div class="form-group">
                    <div class="col-sm-3"></div>
                    <label class="col-sm-3 ">监测数据有效位数是否规范？</label>
                    <label class="col-sm-1 control-label text-success" v-if="record.firstResult2==0"
                           style="text-align: left">是</label>
                    <label class="col-sm-1  text-danger" v-if="record.firstResult2==1"
                           style="text-align: left">否</label>
                    <label class="col-sm-1  text-warning" v-if="record.firstResult2==2"
                           style="text-align: left">纠正</label>
                </div>
                <div class="form-group">
                    <div class="col-sm-3"></div>
                    <label class="col-sm-3 ">原始记录修改是否符合规范？</label>
                    <label class="col-sm-1  text-success" v-if="record.firstResult3==0"
                           style="text-align: left">是</label>
                    <label class="col-sm-1  text-danger" v-if="record.firstResult3==1"
                           style="text-align: left">否</label>
                    <label class="col-sm-1  text-warning" v-if="record.firstResult3==2"
                           style="text-align: left">纠正</label>
                </div>
                <div class="form-group">
                    <div class="col-sm-3"></div>
                    <label class="col-sm-3 ">送检单结果与记录是否一致？</label>
                    <label class="col-sm-1  text-success" v-if="record.firstResult4==0"
                           style="text-align: left">是</label>
                    <label class="col-sm-1  text-danger" v-if="record.firstResult4==1"
                           style="text-align: left">否</label>
                    <label class="col-sm-1  text-warning" v-if="record.firstResult4==2"
                           style="text-align: left">纠正</label>
                </div>
                <div class="form-group">
                    <div class="col-sm-3"></div>
                    <label class="col-sm-3 ">原始记录审核是否完整？</label>
                    <label class="col-sm-1  text-success" v-if="record.firstResult5==0"
                           style="text-align: left">是</label>
                    <label class="col-sm-1  text-danger" v-if="record.firstResult5==1"
                           style="text-align: left">否</label>
                    <label class="col-sm-1  text-warning" v-if="record.firstResult5==2"
                           style="text-align: left">纠正</label>
                </div>
                <div class="form-group">
                    <div class="col-sm-3"></div>
                    <label class="col-sm-3 ">标准曲线是否符合规范？</label>
                    <label class="col-sm-1  text-success" v-if="record.firstResult6==0"
                           style="text-align: left">是</label>
                    <label class="col-sm-1 control-labe text-danger" v-if="record.firstResult6==1"
                           style="text-align: left">否</label>
                    <label class="col-sm-1  text-warning" v-if="record.firstResult6==2"
                           style="text-align: left">纠正</label>
                </div>
                <div class="form-group">
                    <div class="col-sm-3"></div>
                    <label class="col-sm-3 ">其他信息:</label>
                    <label class="col-sm-6 " style="text-align: left">{{record.other}}</label>
                </div>
            </form>
        </div>
    </template>
</div>