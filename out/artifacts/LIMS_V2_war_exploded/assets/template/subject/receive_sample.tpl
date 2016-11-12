<div class="row">
    <div class="col-sm-12">
        <div class="alert alert-info">
            <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
            备注:送样总件数=所有样品件数之和
        </div>
    </div>
    <div class="col-sm-12">
        <div class="col-sm-4 mb10">
            <h4>基本信息</h4>
        </div>
        <div class="col-sm-12">
            <div class="col-sm-6">
                <p>样品件数：{{sampleCount}}</p>
                <p>起止编号：{{sampleFrom}} ~ {{sampleTo}}</p>
            </div>
            <div class="col-sm-6">
                <p>送样日期：{{sample_create}}</p>
                <p>送样人员：{{sample_user.name}}</p>
            </div>
        </div>
    </div>
    <div class="col-sm-12">
        <div class="col-sm-4 mb10">
            <h4>接收信息</h4>
        </div>
        <div class="col-sm-12">
            <div class="form-group">
                <label class="col-sm-2 control-label">样品包装状况</label>
                <div class="col-sm-8">
                    <select class="select2" id="package" data-placeholder="选择样品包装情况">
                        <option value=""></option>
                        <option value="完好">完好</option>
                        <option value="破损">破损</option>
                        <option value="玷污">玷污</option>
                    </select>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">样品标识</label>
                <div class="col-sm-8">
                    <input type="text" v-model="sampleFlag" placeholder="请输入样品标识" class="form-control">
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">固定添加剂</label>
                <div class="col-sm-8">
                    <input type="text" v-model="additive" placeholder="请描述固体添加剂情况" class="form-control">
                </div>
            </div>
        </div>
    </div>
    <div class="col-sm-12">
        <div class="col-sm-4 mb10">
            <h4>交联清单</h4>
        </div>
        <div class="table-responsive">
            <table class="table table-info mb30">
                <thead>
                <tr>
                    <th class="text-center">编号</th>
                    <th class="text-center">样品类别</th>
                    <th class="text-center">分析项目</th>
                    <th class="text-center">件数</th>
                    <th class="text-center">性状描述</th>
                    <th class="text-center">保存条件</th>
                    <th class="text-center">操作</th>
                </tr>
                </thead>
                <tbody>
                <template v-for="(index,project) in projectList">
                    <tr class="text-center">
                        <td>{{index+1}}</td>
                        <td>{{project.category.name}}</td>
                        <td>{{project.name}}</td>
                        <td>{{project.samples.length}}</td>
                        <td>
                            <input type="text" v-model="project.character" class="form-control"/>
                        </td>
                        <td>
                            <div class="radio"><label><input type="radio" v-model="project.storage" value="常温"
                                                             name="condition{{project.id}}">常温 </label> <label><input
                                    type="radio" v-model="project.storage" value="低温" name="condition{{project.id}}">低温
                            </label></div>
                        </td>
                        <td class="table-action">
                            <a class="btn btn-sm btn-success-alt" @click="save(project)">保存</a>
                            <a class="btn btn-sm btn-danger-alt" @click="showInfo(project.samples)">清单</a>
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
                    <th class="text-center">检查</th>
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
                        <td class="table-action">
                            <a class="btn btn-sm btn-success-alt" v-if="item.receive==0" @click="receive(item,1)">接收</a>
                            <a class="btn btn-sm btn-danger-alt" v-if="item.receive==1"
                               @click="receive(item,0)">取消接收</a>
                        </td>
                    </tr>
                </template>
                </tbody>
            </table>
        </div>
    </div>
    <div class="col-md-12 text-center">
        <div class="btn-demo">
            <a class="btn btn-primary-alt" @click="export" style="float: none;">导 出</a>
            <a class="btn btn-danger-alt" @click="flow" style="float: none;">业务流转</a>
            <a class="btn btn-default-alt" style="float: none;" data-dismiss="modal">关 闭</a>
        </div>
    </div>
</div>