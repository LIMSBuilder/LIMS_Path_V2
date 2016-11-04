<div class="row">
    <div class="alert alert-info">
        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
        备注: “G”-气态；“L”-液态；“S”-固态。样品状态若"完好"则为“+”，否则为“-”。
    </div>
    <div class="table-responsive">
        <table class="table table-info mb30">
            <thead>
            <tr>
                <th></th>
                <th class="text-center">编号</th>
                <th class="text-center">样品名称</th>
                <th class="text-center">测试项目</th>
                <th class="text-center">样品状态</th>
                <th class="text-center">颜色</th>
                <th class="text-center">是否完好</th>
                <th></th>
            </tr>
            </thead>
            <tbody>
            <template v-for="(index,item) in sample_list">
                <tr class="text-center">
                    <td>{{index+1}}</td>
                    <td>{{item.identify}}</td>
                    <td>{{item.name}}</td>
                    <td>
                        <template v-for="pro in item.project">
                            {{pro.name}} 、
                        </template>
                    </td>
                    <td v-if="item.feature=='G'">气态</td>
                    <td v-if="item.feature=='L'">液态</td>
                    <td v-if="item.feature=='S'">固态</td>
                    <td>{{item.color}}</td>
                    <td v-if="item.condition=='+'">完好</td>
                    <td v-if="item.condition=='-'">瑕疵</td>
                </tr>
            </template>
            <tr>
                <td class="col-sm-1"></td>
                <td class="col-sm-1"></td>
                <td class="col-sm-2"><input type="text" placeholder="样品名称" v-model="name" class="form-control"></td>
                <td class="col-sm-3">
                    <select class="select2" multiple="multiple" data-placeholder="检测项目" id="projectList">
                        <option value=""></option>
                        <template v-for="item in projectList">
                            <option value="{{item.id}}">{{item.name}}</option>
                        </template>
                    </select>
                </td>
                <td class="col-sm-1">
                    <select class="select2" data-placeholder="样品状态" id="feature">
                        <option value=""></option>
                        <option value="G">气态</option>
                        <option value="L">液态</option>
                        <option value="S">固态</option>
                    </select>

                </td>
                <td class="col-sm-2"><input type="text" placeholder="颜色" v-model="color" class="form-control"></td>
                <td class="col-sm-1">
                    <select class="select2" data-placeholder="是否完好" id="condition">
                        <option value=""></option>
                        <option value="+">完好</option>
                        <option value="-">瑕疵</option>
                    </select>
                </td>
                <td class="col-sm-1">
                    <a class="btn btn-sm btn-success-alt" @click="add">保存</a>
                </td>
            </tr>
            </tbody>
        </table>
    </div>
</div>