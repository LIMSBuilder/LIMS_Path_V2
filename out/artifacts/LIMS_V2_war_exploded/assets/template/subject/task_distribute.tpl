<div class="row">
    <div class="col-sm-12">
        <div class="btn-demo">
            <a class="btn btn-default-alt" @click="select_all">全 选</a>
            <a class="btn btn-primary-alt" @click="user('analyst','分析员')">分析员</a>
            <a class="btn btn-success-alt" @click="user('assessor','审核员')">审核员</a>
            <a class="btn btn-warning-alt" @click="user('checker','复核员')">复核员</a>
            <a class="btn btn-danger-alt">清 空</a>
        </div>
        <div class="table-responsive">
            <table class="table table-info mb30">
                <thead>
                <tr>
                    <th class="text-center"></th>
                    <th class="text-center">编号</th>
                    <th class="text-center">样品类别</th>
                    <th class="text-center">分析项目</th>
                    <th class="text-center">件数</th>
                    <th class="text-center">分析员</th>
                    <th class="text-center">审核员</th>
                    <th class="text-center">复核员</th>
                    <th class="text-center">操作</th>
                </tr>
                </thead>
                <tbody>
                <template v-for="(index,project) in projectList">
                    <tr class="text-center">
                        <td><input type="checkbox" data-value="{{project.name}}" name="selectedProject"
                                   value="{{project.id}}"></td>
                        <td>{{index+1}}</td>
                        <td>{{project.category.name}}</td>
                        <td>{{project.name}}</td>
                        <td>{{project.samples.length}}</td>
                        <td v-if="project.analyst!=null">{{project.analyst.name}}</td>
                        <td v-if="project.assessor!=null">{{project.assessor.name}}</td>
                        <td v-if="project.checker!=null">{{project.checker.name}}</td>
                        <td class="table-action">
                            <a class="btn btn-sm btn-info-alt" @click="showInfo(project.samples)">清单</a>
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
    <div class="col-md-12 text-center">
        <div class="btn-demo">
            <a class="btn btn-danger-alt" @click="flow" style="float: none;">业务流转</a>
            <a class="btn btn-default-alt" style="float: none;" data-dismiss="modal">关 闭</a>
        </div>
    </div>
</div>