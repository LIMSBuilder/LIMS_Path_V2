<div class="row">
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
                        <td class="table-action">
                            <a href="javascript:;"><i class="fa fa-gears" @click="showInfo(project)"></i></a>
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
                    <th class="text-center">现场</th>
                    <th class="text-center">实验室</th>
                    <th class="text-center">加标</th>
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
                        <td><input type="checkbox" name="scene" v-model="sceneList" value="{{item.id}}"></td>
                        <td><input type="checkbox" name="lab" v-model="labList" value="{{item.id}}"></td>
                        <td><input type="checkbox" name="mark" v-model="markList" value="{{item.id}}"></td>
                    </tr>
                </template>
                <tr class="text-center">
                    <td class="text-center" style="vertical-align: middle;">盲样数:</td>
                    <td colspan="1">
                        <input type="text" v-model="blindCount" placeholder="输入盲样个数" class="form-control">
                    </td>
                    <td style="vertical-align: middle;">现场数:</td>
                    <td style="vertical-align: middle;">{{sceneList.length}}个</td>
                    <td style="vertical-align: middle;">实验室:</td>
                    <td style="vertical-align: middle;">{{labList.length}}个</td>
                    <td style="vertical-align: middle;">加标数:</td>
                    <td style="vertical-align: middle;">{{markList.length}}个</td>
                    <td class="text-center" colspan="2">
                        <a class="btn btn-sm btn-primary-alt" @click="save">保 存</a>
                    </td>
                </tr>
                </tbody>
            </table>
        </div>
    </div>
    <div class="col-sm-12">
        <div class="table-responsive">
            <div class="col-sm-4 mb10">
                <h4>质控列表</h4>
            </div>
            <table class="table table-warning mb30">
                <thead>
                <tr>
                    <th class="text-center">编号</th>
                    <th class="text-center">项目名称</th>
                    <th class="text-center">现场平行样</th>
                    <th class="text-center">实验室平行样</th>
                    <th class="text-center">加标回收样</th>
                    <th class="text-center">盲样</th>
                    <th></th>
                </tr>
                </thead>
                <tbody>
                <template v-for="(index,item) in qualityList">
                    <tr class="text-center">
                        <td>{{index+1}}</td>
                        <td>{{item.project.name}}</td>
                        <td>
                            <template v-for="scene in item.scene">
                                {{scene.name.name}}
                            </template>
                        </td>
                        <td>
                            <template v-for="lab in item.lab">
                                {{lab.name.name}}
                            </template>
                        </td>
                        <td>
                            <template v-for="mark in item.mark">
                                {{mark.name.name}}
                            </template>
                        </td>
                        <td>{{item.blind}}</td>
                        <td class="table-action">
                            <a href="javascript:;"><i class="fa fa-trash-o" @click="deleteQuality(item)"></i></a>
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