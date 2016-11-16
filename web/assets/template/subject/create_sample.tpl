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
                            {{pro.name}}
                        </template>
                    </td>
                    <td v-if="item.feature=='G'">气态</td>
                    <td v-if="item.feature=='L'">液态</td>
                    <td v-if="item.feature=='S'">固态</td>
                    <td>{{item.color}}</td>
                    <td v-if="item.condition=='+'">完好</td>
                    <td v-if="item.condition=='-'">瑕疵</td>
                    <td class="table-action">
                        <a href="javascript:;"><i class="fa fa-pencil" @click="change(item)"></i></a>
                        <a href="javascript:;" class="delete-row" @click="deleteBtn(item)"><i
                                class="fa fa-trash-o"></i></a>
                    </td>
                </tr>
            </template>
            </tbody>
        </table>
    </div>
</div>
<div class="row">
    <div class="col-sm-12">
        <div class="col-sm-12" v-if="isChange">
            <label class="text-primary">
                修改编号为{{identify}}样品信息:
            </label>
        </div>
        <form id="sample_form">
            <div class="form-group col-sm-2">
                <input type="text" placeholder="样品名称" id="name" v-model="name" class="form-control" required>
            </div>
            <div class="form-group col-sm-4">
                <select class="select2" multiple="multiple" data-placeholder="检测项目" id="projectList" required>
                    <option value=""></option>
                    <template v-for="item in projectList">
                        <option value="{{item.id}}">{{item.name}}</option>
                    </template>
                </select>
            </div>
            <div class="form-group col-sm-2">
                <select class="select2" data-placeholder="样品状态" id="feature" required>
                    <option value=""></option>
                    <option value="G">气态</option>
                    <option value="L">液态</option>
                    <option value="S">固态</option>
                </select>
            </div>

            <div class="form-group col-sm-2">
                <input type="text" placeholder="颜色" id="color" v-model="color" class="form-control" required>
            </div>

            <div class="form-group col-sm-2">
                <select class="select2" data-placeholder="是否完好" id="condition" required>
                    <option value=""></option>
                    <option value="+">完好</option>
                    <option value="-">瑕疵</option>
                </select>
            </div>
        </form>
        <div class="mb10"></div>
    </div>
    <div class="col-sm-12 text-center">
        <a class="btn btn-sm btn-success-alt" v-if="!isChange" @click="add">保存</a>
        <a class="btn btn-sm btn-primary-alt" v-else @click="changeBtn">修改</a>
        <a class="btn btn-sm btn-default-alt" v-if="!isChange" @click="clear">清空</a>
        <a class="btn btn-sm btn-default-alt" v-else @click="cancelBtn">取消</a>
    </div>
</div>