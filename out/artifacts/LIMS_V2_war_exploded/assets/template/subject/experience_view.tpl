<div class="row">
    <div class="table-responsive">
        <table class="table table-info mb30">
            <thead>
            <tr>
                <th class="text-center">编号</th>
                <th class="text-center">分析项目</th>
                <th class="text-center">原始记录</th>
                <th class="text-center">送检单</th>
                <th class="text-center">当前状态</th>
                <th class="text-center">操作</th>
            </tr>
            </thead>
            <tbody>
            <template v-for="(index,delivery) in deliveryList">
                <tr class="text-center">
                    <td>{{index+1}}</td>
                    <td>{{delivery.project.name}}</td>
                    <td class="table-action">
                        <a class="btn btn-sm btn-info-alt" href="javascript:;"
                           @click="viewOriginRecord(delivery)">查看</a>
                    </td>
                    <td class="table-action">
                        <a href="/distribute/viewInspection?delivery_id={{delivery.id}}"
                           target="_blank" class="btn btn-sm btn-info-alt">查 看</a>
                    </td>
                    <td v-show="delivery.state==-3">
                        <span class="label label-default">待完善</span>
                    </td>
                    <td v-show="delivery.state==-2">
                        <span class="label label-warning">复核拒绝</span>
                    </td>
                    <td v-show="delivery.state==-1">
                        <span class="label label-warning">审核拒绝</span>
                    </td>
                    <td v-show="delivery.state==0">
                        <span class="label label-default">待分析</span>
                    </td>
                    <td v-show="delivery.state==1">
                        <span class="label label-info">已完成</span>
                    </td>
                    <td v-show="delivery.state==2">
                        <span class="label label-primary">待审核</span>
                    </td>
                    <td v-show="delivery.state==3">
                        <span class="label label-success">审核通过</span>
                    </td>
                    <td v-show="delivery.state==4">
                        <span class="label label-primary">待复核</span>
                    </td>
                    <td v-show="delivery.state==5">
                        <span class="label label-primary">复核通过</span>
                    </td>
                    <td v-show="delivery.state==6">
                        <span class="label label-success">已完成</span>
                    </td>
                    <td class="table-action">
                        <a class="btn btn-sm btn-info-alt" href="javascript:;"
                           @click="viewDetail(delivery)">查看</a>
                    </td>
                </tr>
            </template>
            </tbody>
        </table>
    </div>
    <div class="col-md-12" v-if="detailShow">
        <div class="table-responsive">
            <div class="col-sm-4 mb10">
                <h4>操作人员</h4>
            </div>
            <table class="table table-info table-hover mb30 text-center">
                <thead>
                <tr>
                <tr>
                    <th class="text-center">分析员</th>
                    <th class="text-center">分析日期</th>
                    <th class="text-center">审核员</th>
                    <th class="text-center">审核日期</th>
                    <th class="text-center">复核员</th>
                    <th class="text-center">复核日期</th>
                </tr>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td class="text-center">{{optionUser.analyst.name}}</td>
                    <td class="text-center">{{optionUser.analyst_time==null?"未完成":optionUser.analyst_time}}</td>
                    <td class="text-center">{{optionUser.assessor.name}}</td>
                    <td class="text-center">{{optionUser.assessor_time==null?"未完成":optionUser.assessor_time}}</td>
                    <td class="text-center">{{optionUser.checker.name}}</td>
                    <td class="text-center">{{optionUser.checker_time==null?"未完成":optionUser.checker_time}}</td>
                </tr>
                </tbody>
            </table>
        </div><!-- table-responsive -->
    </div><!-- col-md-12 -->
    <div class="col-md-12" v-if="originShow">
        <div class="table-responsive" >
            <div class="col-sm-4 mb10">
                <h4>原始记录列表</h4>
            </div>
            <table class="table table-info table-hover mb30 text-center">
                <thead>
                <tr>
                <tr>
                    <th class="text-center">编号</th>
                    <th class="text-center">原始记录名称</th>
                    <th class="text-center">操作</th>
                </tr>
                </tr>
                </thead>
                <tbody>
                <template v-for="(index,item) in originRecordList">
                    <tr>
                        <td class="text-center">{{index+1}}</td>
                        <td class="text-center">{{item.name}}</td>
                        <td class="table-action text-center">
                            <a class="btn btn-sm btn-info-alt" href="/distribute/viewOriginRecord?record_id={{item.id}}"
                               target="_blank">查看</a>
                        </td>
                    </tr>
                </template>
                </tbody>
            </table>
        </div><!-- table-responsive -->
    </div><!-- col-md-12 -->
    <div class="col-md-12" v-if="detailShow">
        <div class="table-responsive">
            <div class="col-sm-4 mb10">
                <h4>审核拒绝记录</h4>
            </div>
            <table class="table table-info table-hover mb30 text-center">
                <thead>
                <tr>
                    <th class="text-center">编号</th>
                    <th class="text-center">审核者</th>
                    <th class="text-center">拒绝时间</th>
                </tr>
                </thead>
                <tbody>
                <template v-for="(index,item) in assess_reject">
                    <tr>
                        <td class="text-center">{{index+1}}</td>
                        <td class="text-center">{{item.assessor.name}}</td>
                        <td class="text-center">{{item.assessor_time}}</td>
                    </tr>
                </template>
                </tbody>
            </table>
        </div><!-- table-responsive -->
    </div><!-- col-md-12 -->
    <div class="col-md-12" v-if="detailShow">
        <div class="table-responsive">
            <div class="col-sm-4 mb10">
                <h4>复核拒绝记录</h4>
            </div>
            <table class="table table-info table-hover mb30 text-center">
                <thead>
                <tr>
                    <th class="text-center">编号</th>
                    <th class="text-center">审核者</th>
                    <th class="text-center">拒绝时间</th>
                </tr>
                </thead>
                <tbody>
                <template v-for="(index,item) in check_reject">
                    <tr>
                        <td class="text-center">{{index+1}}</td>
                        <td class="text-center">{{item.checker.name}}</td>
                        <td class="text-center">{{item.checker_time}}</td>
                    </tr>
                </template>
                </tbody>
            </table>
        </div><!-- table-responsive -->
    </div><!-- col-md-12 -->
    <div class="col-md-12" v-if="detailShow">
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
                <template v-for="(index , result) in experience_first">
                    <tr class="text-center">
                        <td>{{index+1}}</td>
                        <td>{{result.result_user.name}}</td>
                        <td>{{result.result_time}}</td>
                        <td v-if="currentMasterReview.id==result.id">
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
                    <label class="col-sm-1 control-labe text-successl" v-if="record.firstResult2==0"
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
    <div class="col-md-12" v-if="detailShow">
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
                <template v-for="(index , result) in experience_second">
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
                               @click="showInfoSecond(result)">查 看</a>
                        </td>
                    </tr>
                </template>
                </tbody>
            </table>
        </div><!-- table-responsive -->
    </div>
    <template v-if="isShowSecond">
        <div class="col-sm-12">
            <form class="form-horizontal">
                <div class="form-group">
                    <div class="col-sm-3"></div>
                    <label class="col-sm-3 ">质控样品比例是否满足要求？</label>
                    <label class="col-sm-1  text-success" v-if="recordSecond.secondResult1==0"
                           style="text-align: left">是</label>
                    <label class="col-sm-1  text-danger" v-if="recordSecond.secondResult1==1"
                           style="text-align: left">否</label>
                    <label class="col-sm-1  text-warning" v-if="recordSecond.secondResult1==2"
                           style="text-align: left">纠正</label>
                </div>
                <div class="form-group">
                    <div class="col-sm-3"></div>
                    <label class="col-sm-3 ">监测过程是否满足规范要求？</label>
                    <label class="col-sm-1 control-labe text-successl" v-if="recordSecond.secondResult2==0"
                           style="text-align: left">是</label>
                    <label class="col-sm-1  text-danger" v-if="recordSecond.secondResult2==1"
                           style="text-align: left">否</label>
                    <label class="col-sm-1  text-warning" v-if="recordSecond.secondResult2==2"
                           style="text-align: left">纠正</label>
                </div>
                <div class="form-group">
                    <div class="col-sm-3"></div>
                    <label class="col-sm-3 ">监测分析方法是否现行有效？</label>
                    <label class="col-sm-1  text-success" v-if="recordSecond.secondResult3==0"
                           style="text-align: left">是</label>
                    <label class="col-sm-1  text-danger" v-if="recordSecond.secondResult3==1"
                           style="text-align: left">否</label>
                    <label class="col-sm-1  text-warning" v-if="recordSecond.secondResult3==2"
                           style="text-align: left">纠正</label>
                </div>
                <div class="form-group">
                    <div class="col-sm-3"></div>
                    <label class="col-sm-3 ">回收率是否合格？</label>
                    <label class="col-sm-1  text-success" v-if="recordSecond.secondResult4==0"
                           style="text-align: left">是</label>
                    <label class="col-sm-1  text-danger" v-if="recordSecond.secondResult4==1"
                           style="text-align: left">否</label>
                    <label class="col-sm-1  text-warning" v-if="recordSecond.secondResult4==2"
                           style="text-align: left">纠正</label>
                </div>
                <div class="form-group">
                    <div class="col-sm-3"></div>
                    <label class="col-sm-3 ">平行样偏差是否满足要求？</label>
                    <label class="col-sm-1  text-success" v-if="recordSecond.secondResult5==0"
                           style="text-align: left">是</label>
                    <label class="col-sm-1  text-danger" v-if="recordSecond.secondResult5==1"
                           style="text-align: left">否</label>
                    <label class="col-sm-1  text-warning" v-if="recordSecond.secondResult5==2"
                           style="text-align: left">纠正</label>
                </div>
                <div class="form-group">
                    <div class="col-sm-3"></div>
                    <label class="col-sm-3 ">空白样测试结果是否满足要求？</label>
                    <label class="col-sm-1  text-success" v-if="recordSecond.secondResult6==0"
                           style="text-align: left">是</label>
                    <label class="col-sm-1 control-labe text-danger" v-if="recordSecond.secondResult6==1"
                           style="text-align: left">否</label>
                    <label class="col-sm-1  text-warning" v-if="recordSecond.secondResult6==2"
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

