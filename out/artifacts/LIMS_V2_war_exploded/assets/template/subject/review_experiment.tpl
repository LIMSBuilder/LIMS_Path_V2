<div class="row">
    <div class="col-sm-12">
        <div class="btn-demo">
            <a class="btn btn-danger-alt" @click="flow(id,identify)">业务流转</a>
            <a class="btn btn-success-alt" @click="frash">刷 新</a>
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
                            记录数:{{project.originRecond_count}}个&nbsp;
                            <a data-toggle="modal"
                               data-target=".bs-example-modal-lg" class="btn btn-sm btn-warning-alt"
                               @click="originRecord(project)">列 表</a>
                        </td>
                        <td>
                            <a href="/distribute/createInspection?delivery_id={{project.delivery.id}}"
                               target="_blank" class="btn btn-sm btn-info-alt">查 看</a>
                        </td>
                        <td>{{project.samples.length}}</td>
                        <td v-show="project.state==0">
                            <span class="label label-info">待分析</span>
                        </td>
                        <td v-show="project.state==1">
                            <span class="label label-success">已分析</span>
                        </td>
                        <td class="table-action">
                            <a class="btn btn-sm btn-success-alt" @click="save(project)">完成</a>
                            <a class="btn btn-sm btn-danger-alt"
                               @click="showInfo(project.samples)">清单</a>
                        </td>
                    </tr>
                </template>
                </tbody>
            </table>
        </div>
    </div>
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