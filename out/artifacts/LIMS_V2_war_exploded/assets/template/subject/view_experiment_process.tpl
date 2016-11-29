<div class="row">
    <div class="col-sm-12">
        <div class="btn-demo">
            <a class="btn btn-default-alt" @click="load_list">刷 新</a>
            <a data-content="{{alert_info}}" data-trigger="hover" data-placement="bottom" data-toggle="popover"
               data-container="body" class="btn btn-info-alt popovers" data-original-title="当前各状态介绍" title="">
                状态指引
            </a>
        </div>
        <div class="table-responsive">
            <table class="table table-info mb30">
                <thead>
                <tr>
                    <th class="text-center">编号</th>
                    <th class="text-center">样品类别</th>
                    <th class="text-center">分析项目</th>
                    <th class="text-center">原始记录</th>
                    <th class="text-center">送检单</th>
                    <th class="text-center">样品件数</th>
                    <th class="text-center">当前状态</th>
                    <th class="text-center">操作</th>
                </tr>
                </thead>
                <tbody>
                <template v-for="(index,project) in projectList">
                    <tr class="text-center">
                        <td>{{index+1}}</td>
                        <td>{{project.category.name}}</td>
                        <td>{{project.name}}</td>
                        <td>
                            {{project.originRecond_count}}
                        </td>
                        <td>
                            <a href="/distribute/createInspection?delivery_id={{project.delivery.id}}"
                               target="_blank" class="btn btn-sm btn-info-alt">查 看</a>
                        </td>
                        <td>{{project.samples.length}}</td>
                        <td v-show="project.delivery.state==-3">
                            <span class="label label-default">待完善</span>
                        </td>
                        <td v-show="project.delivery.state==-2">
                            <span class="label label-warning">复核拒绝</span>
                        </td>
                        <td v-show="project.delivery.state==-1">
                            <span class="label label-warning">审核拒绝</span>
                        </td>
                        <td v-show="project.delivery.state==0">
                            <span class="label label-default">待分析</span>
                        </td>
                        <td v-show="project.delivery.state==1">
                            <span class="label label-info">已完成</span>
                        </td>
                        <td v-show="project.delivery.state==2">
                            <span class="label label-primary">待审核</span>
                        </td>
                        <td v-show="project.delivery.state==3">
                            <span class="label label-success">审核通过</span>
                        </td>
                        <td v-show="project.delivery.state==4">
                            <span class="label label-primary">待复核</span>
                        </td>
                        <td class="table-action">
                            <a class="btn btn-sm btn-default-alt"
                               @click="showInfo(project)">清单</a>
                        </td>
                    </tr>
                </template>
                </tbody>
            </table>
        </div>
    </div>
    <div class="col-md-12" v-if="isShow">
        <div class="table-responsive">
            <div class="col-sm-4 mb10">
                <h4>流程详情</h4>
            </div>
            <ul class="col-sm-12 nav nav-pills nav-justified step step-progress">
                <li :class="state>0?'active':''"><a>实验分析/修改<span class="caret"></span></a>
                </li>
                <li :class="state>=2?'active':''"><a>分析完成<span class="caret"></span></a>
                </li>
                <li :class="state>=3?'active':''"><a>待审核<span class="caret"></span></a>
                </li>
                <li :class="state>=4?'active':''"><a>审核完成<span class="caret"></span></a>
                </li>
                <li :class="state>=5?'active':''"><a>待复核<span class="caret"></span></a>
                </li>
                <li :class="state>=6?'active':''"><a>复核完成<span class="caret"></span></a>
                </li>
            </ul>
            <div class="mb10"></div>
            <table class="table table-info table-hover mb30 text-center">
                <thead>
                <tr>
                    <th class="text-center">分析员</th>
                    <th class="text-center">分析时间</th>
                    <th class="text-center">审核员</th>
                    <th class="text-center">审核时间</th>
                    <th class="text-center">复核员</th>
                    <th class="text-center">复核时间</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td class="text-center">{{analyst.name}}</td>
                    <td class="text-center">{{analyst_time==null?"未完成":analyst_time}}</td>
                    <td class="text-center">{{assessor.name}}</td>
                    <td class="text-center">{{assessor_time==null?"未完成":assessor_time}}</td>
                    <td class="text-center">{{checker.name}}</td>
                    <td class="text-center">{{checker_time==null?"未完成":checker_time}}</td>
                </tr>
                </tbody>
            </table>
        </div><!-- table-responsive -->
    </div><!-- col-md-12 -->

    <div class="col-md-12" v-if="isShow">
        <div class="table-responsive">
            <div class="col-sm-4 mb10">
                <h4>原始记录列表</h4>
            </div>
            <table class="table table-info table-hover mb30 text-center">
                <thead>
                <tr>
                    <th class="text-center">编号</th>
                    <th class="text-center">原始记录名称</th>
                    <th class="text-center">操作</th>
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
    <div class="col-sm-12">
        <div class="table-responsive" v-if="isShow">
            <div class="col-sm-4 mb10">
                <h4>样品详情</h4>
            </div>
            <table class="table table-success mb30">
                <thead>
                <tr>
                    <th class="text-center">编号</th>
                    <th class="text-center">样品编号</th>
                    <th class="text-center">样品名称</th>
                    <th class="text-center">样品状态</th>
                    <th class="text-center">颜色</th>
                    <th class="text-center">是否完好</th>
                    <th class="text-center">当前状态</th>
                </tr>
                </thead>
                <tbody>
                <template v-for="(index,item) in sample_list">
                    <tr class="text-center">
                        <td>{{index+1}}</td>
                        <td>{{item.identify}}</td>
                        <td>{{item.name}}</td>
                        <td v-if="item.feature=='G'">气态</td>
                        <td v-if="item.feature=='L'">液态</td>
                        <td v-if="item.feature=='S'">固态</td>
                        <td>{{item.color}}</td>
                        <td v-if="item.condition=='+'">完好</td>
                        <td v-if="item.condition=='-'">瑕疵</td>
                        <td v-if="item.receive==0">
                            <span class="label label-danger">未接收</span>
                        </td>
                        <td v-if="item.receive==1">
                            <span class="label label-success">已接收</span>
                        </td>
                    </tr>
                </template>
                </tbody>
            </table>
        </div>
    </div>
</div>