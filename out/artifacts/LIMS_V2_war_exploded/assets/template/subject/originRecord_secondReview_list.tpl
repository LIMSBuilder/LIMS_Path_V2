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
                    <label class="col-sm-3 ">质控样品比例是否满足要求？</label>
                    <label class="col-sm-1  text-success" v-if="record.secondResult1==0"
                           style="text-align: left">是</label>
                    <label class="col-sm-1  text-danger" v-if="record.secondResult1==1"
                           style="text-align: left">否</label>
                    <label class="col-sm-1  text-warning" v-if="record.secondResult1==2"
                           style="text-align: left">纠正</label>
                </div>
                <div class="form-group">
                    <div class="col-sm-3"></div>
                    <label class="col-sm-3 ">监测过程是否满足规范要求？</label>
                    <label class="col-sm-1 control-label text-success" v-if="record.secondResult2==0"
                           style="text-align: left">是</label>
                    <label class="col-sm-1  text-danger" v-if="record.secondResult2==1"
                           style="text-align: left">否</label>
                    <label class="col-sm-1  text-warning" v-if="record.secondResult2==2"
                           style="text-align: left">纠正</label>
                </div>
                <div class="form-group">
                    <div class="col-sm-3"></div>
                    <label class="col-sm-3 ">监测分析方法是否现行有效？</label>
                    <label class="col-sm-1  text-success" v-if="record.secondResult3==0"
                           style="text-align: left">是</label>
                    <label class="col-sm-1  text-danger" v-if="record.secondResult3==1"
                           style="text-align: left">否</label>
                    <label class="col-sm-1  text-warning" v-if="record.secondResult3==2"
                           style="text-align: left">纠正</label>
                </div>
                <div class="form-group">
                    <div class="col-sm-3"></div>
                    <label class="col-sm-3 ">回收率是否合格？</label>
                    <label class="col-sm-1  text-success" v-if="record.secondResult4==0"
                           style="text-align: left">是</label>
                    <label class="col-sm-1  text-danger" v-if="record.secondResult4==1"
                           style="text-align: left">否</label>
                    <label class="col-sm-1  text-warning" v-if="record.secondResult4==2"
                           style="text-align: left">纠正</label>
                </div>
                <div class="form-group">
                    <div class="col-sm-3"></div>
                    <label class="col-sm-3 ">平行样偏差是否满足要求？</label>
                    <label class="col-sm-1  text-success" v-if="record.secondResult5==0"
                           style="text-align: left">是</label>
                    <label class="col-sm-1  text-danger" v-if="record.secondResult5==1"
                           style="text-align: left">否</label>
                    <label class="col-sm-1  text-warning" v-if="record.secondResult5==2"
                           style="text-align: left">纠正</label>
                </div>
                <div class="form-group">
                    <div class="col-sm-3"></div>
                    <label class="col-sm-3 ">空白样测试结果是否满足要求？</label>
                    <label class="col-sm-1  text-success" v-if="record.secondResult6==0"
                           style="text-align: left">是</label>
                    <label class="col-sm-1 control-labe text-danger" v-if="record.secondResult6==1"
                           style="text-align: left">否</label>
                    <label class="col-sm-1  text-warning" v-if="record.secondResult6==2"
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