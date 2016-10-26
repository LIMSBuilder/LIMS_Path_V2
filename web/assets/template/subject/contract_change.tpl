<div id="validationWizard" class="basic-wizard">

    <ul class="nav nav-pills nav-justified">
        <li><a href="#vtab1" data-toggle="tab"><span>第一步:</span> 基本信息</a></li>
        <li><a href="#vtab2" data-toggle="tab"><span>第二步:</span> 监测内容</a></li>
        <li><a href="#vtab3" data-toggle="tab"><span>第三步:</span> 其他约定</a></li>
        <li><a href="#vtab4" data-toggle="tab"><span>第四步:</span> 预览合同</a></li>
    </ul>


    <form class="form" id="firstForm">
        <div class="tab-content">
            <div class="progress progress-striped active">
                <div class="progress-bar" role="progressbar" aria-valuenow="45" aria-valuemin="0"
                     aria-valuemax="100"></div>
            </div>
            <div class="tab-pane" id="vtab1">
                <div class="form-group">
                    <hr>
                    <h3 class="text-center">甲方信息<a
                            class="btn btn-sm btn-success-alt pull-right " data-toggle="modal"
                            data-target=".bs-example-modal-static" v-on:click="open_dialog">导入客户资料</a>
                    </h3>
                    <hr/>
                </div>

                <div class="form-group">
                    <label class="col-sm-2 control-label text-center">委托单位 </label>
                    <div class="col-sm-4">
                        <input type="text" name="client_unit" v-model="client_unit" class="form-control"
                               required/>
                    </div>
                    <label class="col-sm-2 control-label text-center">邮政编码</label>
                    <div class="col-sm-4">
                        <input type="text" name="client_code" v-model="client_code" class="form-control"
                               required/>
                    </div>
                </div>

                <div class="form-group">
                    <label class="col-sm-2 control-label text-center">联系地址</label>
                    <div class="col-sm-4">
                        <input type="text" name="client_address" v-model="client_address"
                               class="form-control" required/>
                    </div>
                    <label class="col-sm-2 control-label text-center">联系电话</label>
                    <div class="col-sm-4">
                        <input type="text" name="client_tel" v-model="client_tel" class="form-control"
                               required/>
                    </div>
                </div>

                <div class="form-group">
                    <label class="col-sm-2 control-label text-center">联系人</label>
                    <div class="col-sm-4">
                        <input type="text" name="client" v-model="client"
                               class="form-control" required/>
                    </div>
                    <label class="col-sm-2 control-label text-center">传真电话</label>
                    <div class="col-sm-4">
                        <input type="text" name="client_fax" v-model="client_fax" class="form-control"
                               required/>
                    </div>
                </div>

                <div class="form-group">
                    <hr>
                    <h3 class="text-center">乙方信息 <a
                            class="btn btn-sm btn-success-alt pull-right " v-on:click="default_info">导入预设</a>
                    </h3>

                    <hr/>
                </div>

                <div class="form-group">
                    <label class="col-sm-2 control-label text-center">受托单位</label>
                    <div class="col-sm-4">
                        <input type="text" name="trustee_unit" v-model="trustee_unit"
                               class="form-control" required/>
                    </div>
                    <label class="col-sm-2 control-label text-center">邮政编码</label>
                    <div class="col-sm-4">
                        <input type="text" name="trustee_code" v-model="trustee_code"
                               class="form-control" required/>
                    </div>
                </div>

                <div class="form-group">
                    <label class="col-sm-2 control-label text-center">联系地址</label>
                    <div class="col-sm-4">
                        <input type="text" name="trustee_address" v-model="trustee_address"
                               class="form-control" required/>
                    </div>
                    <label class="col-sm-2 control-label text-center">联系电话</label>
                    <div class="col-sm-4">
                        <input type="text" name="trustee_tel" v-model="trustee_tel" class="form-control"
                               required/>
                    </div>
                </div>

                <div class="form-group">
                    <label class="col-sm-2 control-label text-center">承办人</label>
                    <div class="col-sm-4">
                        <input type="text" name="trustee" v-model="trustee" class="form-control"
                               required/>
                    </div>
                    <label class="col-sm-2 control-label text-center">传真电话</label>
                    <div class="col-sm-4">
                        <input type="text" name="trustee_fax" v-model="trustee_fax" class="form-control"
                               required/>
                    </div>
                </div>
            </div>
            <div class="tab-pane" id="vtab2">
                <div class="form-group">
                    <label class="col-sm-2 control-label text-center">项目名称</label>
                    <div class="col-sm-10">
                        <input type="text" v-model="project_name" name="project_name"
                               class="form-control" required/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label text-center">监测目的</label>
                    <div class="col-sm-10">
                        <textarea class="form-control" v-model="monitor_aim" rows="5"></textarea>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label text-center">监测类别</label>
                    <div class="col-sm-10">
                        <select class="select2" id="monitor_type" v-model="monitor_type"
                                data-placeholder="选择监测类别"
                                required>
                            <option value="1"></option>
                            <option value="2">验收监测</option>
                            <option value="3">环评监测</option>
                            <option value="4">委托监测</option>
                            <option value="5">执法监测</option>
                            <option value="6">例行监测</option>
                            <option value="7">应急监测</option>
                            <option value="8">监督监测</option>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label text-center">检测方法</label>
                    <div class="col-sm-10">
                        <div class="rdio rdio-primary">
                            <input type="radio" v-model="monitor_way" checked id="way1" value="0"
                                   name="gender" required/>
                            <label for="way1">以我单位通过计量认证、国家实验室认可的方法进行检测</label>
                        </div>
                        <div class="rdio rdio-primary">
                            <input type="radio" v-model="monitor_way" value="1" id="way2"
                                   name="gender"/>
                            <label for="way2">客户指定的方法:</label>
                            <input type="text" v-model="monitor_way_desp" name="monitor_way_desp"
                                   class="form-control " disabled/>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label text-center">监测项目</label>
                    <div class="col-sm-10">
                        <div class="alert alert-warning">
                            <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
                            如需修改监测项目,请点击"监测项目修改"按钮,或者点击<a href="" class="alert-link">此处</a>跳转至监测项目修改窗口.
                        </div>
                        <div class="table-responsive">
                            <table class="table table-info mb30">
                                <thead>
                                <tr>
                                    <th class="text-center">序号</th>
                                    <th class="text-center">环境要素</th>
                                    <th class="text-center">监测点(个)</th>
                                    <th class="text-center">监测项目</th>
                                    <th class="text-center">监测频次</th>
                                    <th class="text-center">备注</th>
                                    <th class="text-center"></th>
                                </tr>
                                </thead>
                                <tbody>
                                <template v-for="(index,item) in item_arr">
                                    <tr>
                                        <td class="text-center">{{index+1}}</td>
                                        <td class="text-center">
                                            {{item.environment_text}}
                                        </td>
                                        <td class="text-center">{{item.monitor_point}}</td>
                                        <td class="text-center">
                                            <template v-for="item in item.monitor_item_text">
                                                {{item.name}}
                                            </template>
                                        </td>
                                        <td class="text-center">{{item.frequency}}</td>
                                        <td class="text-center">{{item.other}}</td>
                                        <td class="table-action">

                                            <a v-if="index!=0" href="javascript:;"
                                               @click="sort_up(index)"><i
                                                    class="fa fa-arrow-up"></i></a>
                                            <a v-if="index!=item_arr.length-1" href="javascript:;"
                                               @click="sort_down(index)"><i
                                                    class="fa fa-arrow-down"></i></a>
                                            <a href="javascript:;" @click="delete_item(item)"><i
                                                    class="fa fa-trash-o"></i></a>
                                        </td>
                                    </tr>
                                </template>
                                <tr>
                                    <td class="table-action" colspan="7">
                                        <a href="javascript:;" v-on:click="addItem" data-toggle="modal"
                                           data-target=".bs-example-modal-static"><i
                                                class="fa fa-plus"></i> 新增</a>
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                        </div><!-- table-responsive -->
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label text-center">分包单位</label>
                    <div class="col-sm-4">
                        <input type="text" name="subpackage" v-model="subpackage"
                               class="form-control"/>
                    </div>
                    <label class="col-sm-2 control-label text-center">分包项目</label>
                    <div class="col-sm-4">
                        <input type="text" name="subpackage_project" v-model="subpackage_project"
                               class="form-control"/>
                    </div>
                </div>
            </div>

            <div class="tab-pane" id="vtab3">
                <div class="form-group">
                    <label class="col-sm-2 control-label text-center">交付方式</label>
                    <div class="col-sm-10">
                        <select class="select2" v-model="payment_way" id="payment_way" data-placeholder="选择交付方式"
                                required>
                            <option value=""></option>
                            <option value="0">客户自取</option>
                            <option value="1">挂号邮寄</option>
                            <option value="2">其他方式</option>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label text-center">完成时间</label>
                    <div class="col-sm-4">
                        <div class="input-group">
                            <input type="text" v-model="finish_date" class="form-control"
                                   placeholder="mm/dd/yyyy"
                                   id="datepicker-multiple">
                            <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                        </div>
                    </div>
                    <label class="col-sm-2 control-label text-center">监测费用(元)</label>
                    <div class="col-sm-4">
                        <input type="text" name="payment_count" v-model="payment_count"
                               class="form-control" required/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label text-center">客户要求</label>
                    <div class="col-sm-10">
                        <div class="checkbox block"><label><input v-model="in_room" value="room"
                                                                  type="checkbox">
                            客户需要进入实验室监视与本次委托有关的检测活动</label></div>
                        <div class="checkbox block"><label><input v-model="keep_secret" value="secret"
                                                                  type="checkbox">
                            客户需要本实验室对本次委托有关资料保密</label></div>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label text-center">其他约定</label>
                    <div class="col-sm-10">
                        <textarea v-model="other" class="form-control" rows="5"></textarea>
                    </div>
                </div>
            </div>
            <div class="tab-pane" id="vtab4">

                <div class="col-sm-12">
                    <div class="table-responsive">
                        <table class="table table-bordered  mb30">
                            <thead>
                            <tr>
                                <th class="text-center" colspan="7">环境监测业务合同</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td class="text-center" rowspan="3">甲方信息</td>
                                <td class="text-center">委托单位</td>
                                <td class="text-center" colspan="2">{{client_unit}}</td>
                                <td class="text-center">邮政编码</td>
                                <td class="text-center" colspan="2">{{client_code}}</td>
                            </tr>
                            <tr>
                                <td class="text-center">联系地址</td>
                                <td class="text-center" colspan="2">{{client_address}}</td>
                                <td class="text-center">联系电话</td>
                                <td class="text-center" colspan="2">{{client_tel}}</td>
                            </tr>
                            <tr>
                                <td class="text-center">联系人</td>
                                <td class="text-center" colspan="2">{{client}}</td>
                                <td class="text-center">传真电话</td>
                                <td class="text-center" colspan="2">{{client_fax}}</td>
                            </tr>
                            <tr>
                                <td class="text-center" rowspan="6">项目名称</td>
                                <td class="text-center">项目名称</td>
                                <td class="text-center" colspan="5">{{project_name}}</td>
                            </tr>
                            <tr>
                                <td class="text-center">监测目的</td>
                                <td class="text-center" colspan="5">{{monitor_aim}}</td>
                            </tr>
                            <tr>
                                <td class="text-center">监测类别</td>
                                <td class="text-center" colspan="5">{{monitor_type}}</td>
                            </tr>
                            <tr>
                                <td class="text-center">监测项目</td>
                                <td class="text-center" colspan="5">

                                    <div class="table-responsive">
                                        <table class="table  mb30">
                                            <thead>
                                            <tr>
                                                <th class="text-center">序号</th>
                                                <th class="text-center">环境要素</th>
                                                <th class="text-center">监测点(个)</th>
                                                <th class="text-center">监测项目</th>
                                                <th class="text-center">监测频次</th>
                                                <th class="text-center">备注</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <template v-for="(index,item) in item_arr">
                                                <tr>
                                                    <td class="text-center">{{index+1}}</td>
                                                    <td class="text-center">
                                                        {{item.environment_text}}
                                                    </td>
                                                    <td class="text-center">{{item.monitor_point}}</td>
                                                    <td class="text-center">
                                                        <template v-for="temp in item.monitor_item_text">
                                                            {{temp.name}}
                                                        </template>

                                                    </td>
                                                    <td class="text-center">{{item.frequency}}</td>
                                                    <td class="text-center">{{item.other}}</td>
                                                </tr>
                                            </template>
                                            </tbody>
                                        </table>
                                    </div><!-- table-responsive -->
                                </td>
                            </tr>
                            <tr>
                                <td class="text-center">检测方法</td>
                                <td class="text-center" colspan="5" v-if="monitor_way==0">
                                    以我单位通过计量认证、国家实验室认可的方法进行检测
                                </td>
                                <td class="text-center" colspan="5" v-if="monitor_way==1">
                                    {{monitor_way_desp}}
                                </td>

                            </tr>
                            <tr>
                                <td class="text-center">分包单位</td>
                                <td class="text-center">{{subpackage}}</td>
                                <td class="text-center">分包项目</td>
                                <td class="text-center" colspan="3">{{subpackage_project}}</td>
                            </tr>
                            <tr>
                                <td class="text-center" rowspan="2">报告</td>
                                <td class="text-center">交付方式</td>
                                <td class="text-center" colspan="5" v-if="payment_way == 0">客户自取</td>
                                <td class="text-center" colspan="5" v-if="payment_way == 1">挂号邮寄</td>
                                <td class="text-center" colspan="5" v-if="payment_way == 2">其他方式</td>
                            </tr>
                            <tr>
                                <td class="text-center">完成时间</td>
                                <td class="text-center" colspan="2">{{finish_date}}</td>
                                <td class="text-center">监测费用(¥)</td>
                                <td class="text-center">{{payment_count}}</td>
                                <td class="text-center">壹佰贰拾叁圆</td>
                            </tr>
                            <tr>
                                <td class="text-center">客户要求</td>
                                <td class="text-center" colspan="2">客户需要进入实验室监视与本次委托有关的检测活动</td>
                                <td class="text-center" v-if="in_room!='room'">否</td>
                                <td class="text-center" v-if="in_room=='room'">是</td>
                                <td class="text-center" colspan="2">客户需要本实验室对本次委托有关资料保密</td>
                                <td class="text-center" v-if="keep_secret!='secret'">否</td>
                                <td class="text-center" v-if="keep_secret=='secret'">是</td>
                            </tr>
                            <tr>
                                <td class="text-center">其他约定</td>
                                <td colspan="7">{{other}}</td>
                            </tr>
                            <tr>
                                <td class="text-center" rowspan="3">乙方信息</td>
                                <td class="text-center">受托单位</td>
                                <td class="text-center" colspan="2">{{trustee_unit}}</td>
                                <td class="text-center">邮政编码</td>
                                <td class="text-center" colspan="2">{{trustee_code}}</td>
                            </tr>
                            <tr>
                                <td class="text-center">联系地址</td>
                                <td class="text-center" colspan="2">{{trustee_address}}</td>
                                <td class="text-center">联系电话</td>
                                <td class="text-center" colspan="2">{{trustee_tel}}</td>
                            </tr>
                            <tr>
                                <td class="text-center">承办人</td>
                                <td class="text-center" colspan="2">{{trustee}}</td>
                                <td class="text-center">传真电话</td>
                                <td class="text-center" colspan="2">{{trustee_fax}}</td>
                            </tr>
                            </tbody>
                        </table>
                    </div><!-- table-responsive -->
                </div>
            </div>

        </div><!-- tab-content -->
    </form>

    <ul class="pager wizard">
        <li class="previous"><a href="javascript:void(0)">上一项</a></li>
        <li class="next"><a href="javascript:void(0)">下一项</a></li>
        <li class="print"><a href="javascript:void(0)" @click="print">打印</a></li>
        <li class="finish"><a href="javascript:void(0)" @click="saveAsProject">完成修改</a></li>
    </ul>

</div><!-- #validationWizard -->