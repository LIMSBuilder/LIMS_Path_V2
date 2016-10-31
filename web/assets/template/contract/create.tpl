<div class="row">
    <div class="col-md-12">
        <div class="panel panel-default">
            <div class="panel-heading">
                <a class="btn btn-sm btn-info-alt pull-right" @click="use_template" data-toggle="modal"
                   data-target=".bs-example-modal-static">使用模板</a>
                <h4 class="panel-title">创建业务合同</h4>
            </div>
            <div class="panel-body panel-body-nopadding">

                <!-- BASIC WIZARD -->
                <div id="validationWizard" class="basic-wizard">

                    <ul class="nav nav-pills nav-justified">
                        <li><a href="#vtab1" data-toggle="tab"><span>第一步:</span> 基本信息</a></li>
                        <li><a href="#vtab2" data-toggle="tab"><span>第二步:</span> 监测内容</a></li>
                        <li><a href="#vtab3" data-toggle="tab"><span>第三步:</span> 其他约定</a></li>
                        <li><a href="#vtab4" data-toggle="tab"><span>第四步:</span> 预览合同</a></li>
                    </ul>


                    <form class="form" id="contractForm">
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
                                        <!--<input type="text" name="trustee" v-model="trustee" class="form-control"-->
                                        <!--required/>-->
                                        <select class="select2" id="trustee" data-placeholder="请选择承办人..." required>
                                            <option value=""></option>
                                            <template v-for="item in user_list">
                                                <option value="{{item.id}}">{{item.name}}</option>
                                            </template>
                                        </select>

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
                                        <label class="help-block">若生成"合同模板",则项目名称为模板名称。</label>
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
                                                data-placeholder="请选择监测类别"
                                                required>
                                            <option value=""></option>
                                            <template v-for="items in monitor_typeList">
                                                <option value="{{items.value}}">{{items.value}}</option>
                                            </template>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label text-center">检测方法</label>
                                    <div class="col-sm-10">
                                        <div class="rdio rdio-primary">
                                            <input type="radio" v-model="monitor_way" id="way1" value="0"
                                                   name="gender" required checked="checked"/>
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
                                        <label class="help-block">若保存为"合同模板",请勿填写监测项目内容,模板将不保存监测项目。</label>
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
                                        <select class="select2" v-model="payment_way" id="payment_way"
                                                data-placeholder="选择交付方式"
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
                                    <div class="form-group">
                                        <label class="col-sm-2 control-label text-center">合同编号</label>
                                        <div class="col-sm-6">
                                            <input type="text" name="payment_count" readonly="readonly"
                                                   v-model="identify"
                                                   class="form-control" required/>
                                            <span class="help-block">合同编号具有唯一性,建议使用"系统生成"功能保证其唯一性。若生成合同模板请勿点击"系统生成"。</span>
                                        </div>
                                        <div class="col-sm-4">
                                            <div class="btn-demo">
                                                <a
                                                        class="btn btn-sm btn-success-alt pull-left "
                                                        v-on:click="create_identify">系统生成</a>
                                                <a
                                                        class="btn btn-sm btn-warning-alt pull-left hidden"
                                                        v-on:click="free_identify">释放编号</a>
                                            </div>
                                        </div>
                                    </div>
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
                                                                        <template
                                                                                v-for="temp in item.monitor_item_text">
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
                                                    客户指定：{{monitor_way_desp}}
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
                                                <td class="text-center">{{payment_count_chinese}}</td>
                                            </tr>
                                            <tr>
                                                <td class="text-center">客户要求</td>
                                                <td class="text-center" colspan="2">客户需要进入实验室监视与本次委托有关的检测活动</td>
                                                <td class="text-center" v-if="in_room!=true">否</td>
                                                <td class="text-center" v-if="in_room==true">是</td>
                                                <td class="text-center" colspan="2">客户需要本实验室对本次委托有关资料保密</td>
                                                <td class="text-center" v-if="keep_secret!=true">否</td>
                                                <td class="text-center" v-if="keep_secret==true">是</td>
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
                                                <td class="text-center" colspan="2">{{trustee.name}}</td>
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
                        <li class="draft"><a href="javascript:void(0)" @click="save(-1)">存为模板</a></li>
                        <li class="print"><a href="javascript:void(0)" @click="print">打印</a></li>
                        <li class="finish"><a href="javascript:void(0)" @click="save(0)">完成创建</a></li>
                    </ul>

                </div><!-- #validationWizard -->

            </div><!-- panel-body -->
        </div><!-- panel -->
    </div>
</div>


<script src="/assets/js/bootstrap-wizard.min.js"></script>
<script src="/assets/js/jquery-ui-1.10.3.min.js"></script>
<script>

    jQuery(document).ready(function () {
        "use strict";
        // 带有表单验证的流程图
        var vue = new Vue({
            me: this,
            el: '#contentpanel',
            data: {
                user_list: [],
                monitor_typeList: [],
                identify: "",
                client_unit: "",
                client_code: "",
                client_address: "",
                client_tel: "",
                client: "",
                client_fax: "",
                trustee_unit: "",
                trustee_code: "",
                trustee_address: "",
                trustee_tel: "",
                trustee: "",
                trustee_fax: "",
                project_name: "",
                monitor_aim: "",
                monitor_type: "",
                monitor_way: "",
                monitor_way_desp: "",
                subpackage: "",
                subpackage_project: "",
                item_arr: [],
                payment_way: "",
                finish_date: "",
                payment_count: "",
                payment_count_chinese: "",
                in_room: "",
                keep_secret: "",
                other: ""
            },
            methods: {
                /**
                 * 使用模板
                 */
                use_template: function () {
                    var me = this;
                    var template = jQuery.fn.loadTemplate("/assets/template/subject/template_select_list.tpl");
                    Vue.component('contract_template', {
                        template: template,
                        data: function () {
                            return {
                                templates: [],
                                search_key: ""
                            };
                        },
                        methods: {
                            startSearch: function (event) {
                                var me = this;
                                me.load_list("project_name=" + encodeURI(me.search_key), 1);
                            },
                            choose: function (data) {
                                var id = data.id;
                                me.$http.get("/constarct/getTemplate", {
                                    params: {id: id}
                                }).then(function (response) {
                                    var data = response.data;
                                    data.identify = "";
                                    var arr = ["trustee", "monitor_type", "payment_way"];
                                    for (var key in data) {
                                        if (me[key] != undefined) {
                                            var value = data[key];
                                            me.$set(key, value);

                                            if (jQuery.inArray(key, arr) != -1) {
                                                $('#' + key).select2("val", value);
                                            }
                                            //承办人
                                            if (key == "trustee") {
                                                me.$http.get("/user/getById", {
                                                    params: {
                                                        id: value
                                                    }
                                                }).then(function (response) {
                                                    var data = response.data;
                                                    me.$set("trustee", data);
                                                }, function (response) {
                                                    jQuery.fn.error_msg("服务器无法获取承办人信息！");
                                                })
                                            }
                                        }
                                    }
                                }, function (response) {
                                    jQuery.fn.error_msg("服务器无法获取合同模板信息！");
                                })
                            },
                            load_list: function (condition, currentPage) {
                                var me = this;
                                var dom = jQuery(me.$el);
                                var rowCount = localStorage.getItem("rowCount") || 0;
                                me.$http.get("/constarct/getTemplateList", {
                                    params: {
                                        rowCount: rowCount,
                                        currentPage: currentPage,
                                        condition: condition
                                    }
                                }).then(function (response) {
                                    var data = response.data;
                                    me.$set("templates", data.results);
                                    //页码事件
                                    dom.find('.paging').pagination({
                                        pageCount: data.totalPage != 0 ? data.totalPage : 1,
                                        coping: true,
                                        homePage: '首页',
                                        endPage: '末页',
                                        prevContent: '上页',
                                        nextContent: '下页',
                                        current: data.currentPage,
                                        callback: function (page) {
                                            var currentPage = page.getCurrent();
                                            me.$http.get("/constarct/getTemplateList", {
                                                params: {
                                                    rowCount: rowCount,
                                                    currentPage: currentPage,
                                                    condition: data.condition
                                                }
                                            }).then(function (response) {
                                                var data = response.data;
                                                me.$set("templates", data.results);
                                            }, function (response) {
                                                jQuery.fn.error_msg("无法获取合同模板列表信息,请尝试刷新操作。");
                                            });
                                        }
                                    });
                                    jQuery.validator.setDefaults({
                                        submitHandler: function () {
                                        }
                                    });
                                }, function (response) {
                                    jQuery.fn.error_msg("无法获取合同模板列表信息,请尝试刷新操作。");
                                });

                            }
                        },
                        ready: function () {
                            var me = this;
                            me.load_list("", 1);
                        }
                    });
                    LIMS.dialog.$set('title', '使用合同模板');
                    LIMS.dialog.currentView = 'contract_template';


                },
                /**
                 * 获取预设乙方信息
                 */
                default_info: function () {
                    var me = this;
                    jQuery.fn.check_msg({
                        msg: '是否导入系统预设的乙方信息？已填信息将会被覆盖。',
                        success: function () {
                            me.$http.get('/default/getDefault').then(function (response) {
                                var data = response.data;
                                for (var key in data) {
                                    var value = data[key];
                                    me.$set(key, value);
                                    if (key == "trustee") {
                                        jQuery("#trustee").select2("val", data[key].id);
                                    }
                                }
                            }, function (response) {
                                jQuery.fn.error_msg("服务器无法获取预设信息！");
                            })


                        }
                    });
                },
                /**
                 * 导入甲方客户资料
                 */
                open_dialog: function () {
                    var me = this;
                    var template = jQuery.fn.loadTemplate("/assets/template/subject/customer_select_list.tpl");
                    Vue.component('child', {
                        template: template,
                        data: function () {
                            return {
                                customers: [],
                                search_key: ""
                            };
                        },
                        methods: {
                            startSearch: function (event) {
                                var me = this;
                                me.load_list("client_unit=" + encodeURI(me.search_key), 1);
                            },
                            choose: function (data) {
                                var customer = data.customer;
                                jQuery("#custom_modal").modal("hide");
                                jQuery.fn.check_msg({
                                    msg: "是否导入【" + customer.client_unit + "】公司的客户资料?",
                                    success: function () {
                                        for (var key in customer) {
                                            me.$set(key, customer[key]);
                                        }

                                    }
                                });
                            },
                            load_list: function (condition, currentPage) {
                                var me = this;
                                var dom = jQuery(me.$el);
                                var rowCount = localStorage.getItem("rowCount") || 0;
                                me.$http.get("/customer/list", {
                                    params: {
                                        rowCount: rowCount,
                                        currentPage: currentPage,
                                        condition: condition
                                    }
                                }).then(function (response) {
                                    var data = response.data;
                                    me.$set("customers", data.results);
                                    //页码事件
                                    dom.find('.paging').pagination({
                                        pageCount: data.totalPage != 0 ? data.totalPage : 1,
                                        coping: true,
                                        homePage: '首页',
                                        endPage: '末页',
                                        prevContent: '上页',
                                        nextContent: '下页',
                                        current: data.currentPage,
                                        callback: function (page) {
                                            var currentPage = page.getCurrent();
                                            me.$http.get("/customer/list", {
                                                params: {
                                                    rowCount: rowCount,
                                                    currentPage: currentPage,
                                                    condition: data.condition
                                                }
                                            }).then(function (response) {
                                                var data = response.data;
                                                me.$set("customers", data.results);
                                            }, function (response) {
                                                jQuery.fn.error_msg("无法获取客户列表信息,请尝试刷新操作。");
                                            });
                                        }
                                    });
                                    jQuery.validator.setDefaults({
                                        submitHandler: function () {
                                        }
                                    });
                                }, function (response) {
                                    jQuery.fn.error_msg("无法获取客户列表信息,请尝试刷新操作。");
                                });

                            }
                        },
                        ready: function () {
                            var me = this;
                            me.load_list("", 1);
                        }
                    });
                    LIMS.dialog.$set('title', '从客户管理系统中导入');
                    LIMS.dialog.currentView = 'child';


                },
                /**
                 * 增加检测项
                 */
                addItem: function () {
                    var me = this;
                    me.$http.get("/assets/json/contract_addItem.json").then(function (response) {

                        var data = response.data;
                        var template = jQuery.fn.loadTemplate("/assets/template/subject/contract_monitor_addItem.tpl");

                        Vue.component("addItem", {
                            template: template,
                            data: function () {
                                return {
                                    environment: "",
                                    monitor_point: "",
                                    monitor_type: "",
                                    monitor_item: "",
                                    frequency: "",
                                    other: "",
                                    monitor_type_item: [],
                                    frequency_item: [],
                                    monitor_project_item: []
                                }
                            },
                            methods: {
                                save: function () {
                                    var dom = $(this.$el);
                                    if (!jQuery("#monitor_addItem").valid())return;
                                    var items = [];
                                    dom.find('#monitor_item option:selected').each(function (index, item) {
                                        var dom = jQuery(item);
                                        var temp = {
                                            id: dom.attr("value"),
                                            name: dom.html()
                                        };
                                        items.push(temp);
                                    });

                                    var data = {
                                        environment: dom.find("select[name=environment]").val(),
                                        environment_text: dom.find("select[name=environment] option:selected").html(),
                                        monitor_point: dom.find("#tags").val(),
                                        monitor_item: dom.find("#monitor_item").val(),
                                        monitor_item_text: items,
                                        frequency: dom.find("select[name=frequency]").val(),
                                        other: this.other
                                    };
                                    console.log(data);
                                    me.item_arr.push(data);
                                    jQuery("#monitor_addItem")[0].reset();
                                    jQuery("#monitor_addItem .select2").val("").trigger("change");
                                    jQuery("#tags").removeTag("");
                                    jQuery.fn.alert_msg("检测项保存成功!");

                                },

                                cancel: function () {
                                    jQuery("#custom_modal").modal("hide");
                                }
                            },
                            ready: function () {
                                var me = this;
                                var dom = $(me.$el);
                                dom.find('.select2').select2({
                                    width: '100%',
                                    minimumResultsForSearch: -1
                                });
                                dom.find('#tags').tagsInput({
                                    width: 'auto',
                                    defaultText: '增加...'
                                });
                                me.$http.get("/category/getList").then(function (res) {
                                    var results = res.data.results;
                                    me.$set("monitor_type_item", results);
                                }, function (response) {
                                    jQuery.fn.error_msg("无法获取环境要素列表信息,请尝试刷新操作。");
                                });
                                me.$http.get("/frequency/getList").then(function (response) {
                                    var data = response.data;
                                    me.$set("frequency_item", data);
                                }, function (response) {
                                    jQuery.fn.error_msg("无法获取监测频次列表信息,请尝试刷新操作。");
                                });


                                dom.find('select[name=environment]').on("change", function (event) {
                                    var id = event.val;
                                    if (!id) return;
                                    me.$http.get("/project/getByCategory", {
                                        params: {
                                            id: id
                                        }
                                    }).then(function (response) {
                                        var data = response.data;
                                        me.$set("monitor_project_item", data.results);
                                        console.log(data)
                                    }, function (response) {
                                        jQuery.fn.error_msg("无法获取监测项目列表信息,请尝试刷新操作。");
                                    })
                                });

                                jQuery("#monitor_addItem").validate({
                                    highlight: function (element) {
                                        jQuery(element).closest('.form-group').removeClass('has-success').addClass('has-error');
                                    },
                                    success: function (element) {
                                        jQuery(element).closest('.form-group').removeClass('has-error');
                                    }
                                });


                            }
                        });


                        LIMS.dialog.$set('title', '设置项目检测项');
                        LIMS.dialog.currentView = 'addItem';
                    }, function (response) {

                    });


                },
                /**
                 * 删除检测项
                 * @param item
                 */
                delete_item: function (item) {
                    var me = this;
                    jQuery.fn.check_msg({
                        msg: "是否删除当前选中监测项目?",
                        success: function () {
                            me.item_arr.$remove(item);
                            jQuery.fn.alert_msg("监测项目删除成功!");
                        }
                    })
                },
                /**
                 * 检测项上移一位
                 * @param index
                 */
                sort_up: function (index) {

                    var upper = this.item_arr[index - 1];
                    var value = this.item_arr[index];
                    this.item_arr.$set(index, upper);
                    this.item_arr.$set(index - 1, value);
                },
                /**
                 * 检测项下移一位
                 * @param index
                 */
                sort_down: function (index) {
                    var upper = this.item_arr[index + 1];
                    var value = this.item_arr[index];
                    this.item_arr.$set(index, upper);
                    this.item_arr.$set(index + 1, value);
                },
                /**
                 * 保存
                 */
                save: function (state) {
                    var me = this;
                    if (state == 0 && !jQuery('#contractForm').valid()) {
                        jQuery.fn.error_msg("您有合同信息尚未填写完成,请返回检查。");
                        return;
                    }
                    var arr_item = [];
                    for (var i = 0; i < me.item_arr.length; i++) {
                        var item = me.item_arr[i];
                        var m = "";
                        for (var j = 0; j < item.monitor_item.length; j++) {
                            m += (item.monitor_item[j] + ",");
                        }
                        var temp = {
                            category_id: item.environment,
                            frequency: item.frequency,
                            monitor_point: item.monitor_point.replace(/,/g, ';'),
                            other: item.other,
                            project_id: encodeURI(m.substr(0, m.length - 1)).replace(/,/g, ';')
                        };
                        arr_item.push(JSON.stringify(temp));
                    }
                    var data = {
                        identify: state == 0 ? me.identify : "000000",
                        client_unit: me.client_unit,
                        client_code: me.client_code,
                        client_address: me.client_address,
                        client_tel: me.client_tel,
                        client: me.client,
                        client_fax: me.client_fax,
                        trustee_unit: me.trustee_unit,
                        trustee_code: me.trustee_code,
                        trustee_address: me.trustee_address,
                        trustee_tel: me.trustee_tel,
                        trustee: me.trustee.id,
                        trustee_fax: me.trustee_fax,
                        project_name: me.project_name,
                        monitor_aim: me.monitor_aim,
                        monitor_type: jQuery("#monitor_type").val(),
                        monitor_way: me.monitor_way,
                        monitor_way_desp: me.monitor_way_desp,
                        subpackage: me.subpackage,
                        subpackage_project: me.subpackage_project,
                        "item_arr[]": arr_item,
                        payment_way: jQuery("#payment_way").val(),
                        finish_date: me.finish_date,
                        payment_count: me.payment_count,
                        in_room: me.in_room ? 1 : 0,
                        keep_secret: me.keep_secret ? 1 : 0,
                        other: me.other,
                        state: state
                    };
                    jQuery.fn.check_msg({
                        msg: state == 0 ? "您即将创建一份全新的合同,创建完成之后将进入项目流中,是否创建？" : "是否将当前合同保存为合同模板？您可以在后续合同创建中复用该模板。",
                        success: function () {
                            jQuery.ajax({
                                type: "POST",
                                url: "/constarct/add",
                                cache: false,
                                data: data,
                                traditional: true,
                                success: function (data) {
                                    jQuery.fn.codeState(data.code, {
                                        200: state == 0 ? "合同保存成成功!" : "合同模板保存成功!",
                                        503: "当前合同编号已经存在,请使用\"系统生成\"按钮重新生成！"
                                    });
                                }
                            });
                        }
                    });
                },
                /**
                 * 打印导出报告
                 */
                print: function () {
                    jQuery.fn.check_msg({
                        msg: "是否打印当前合同？",
                        success: function () {
                            jQuery.fn.alert_msg("合同打印成功！");
                        }
                    });
                },
                /**
                 * 生成合同编号
                 */
                create_identify: function () {
                    var me = this;
                    jQuery.fn.check_msg({
                        msg: "是否由系统自动生成合同编号?",
                        success: function () {
                            me.$http.get("/constarct/identify").then(function (response) {
                                var data = response.data;
                                me.$set("identify", data.identify);
                            }, function (response) {
                                jQuery.fn.error_msg("无法生成合同编号,请尝试刷新操作。");
                            });
                        }
                    });
                },
                free_identify: function () {
                    var me = this;
                    jQuery.fn.check_msg({
                        msg: "是否由释放合同编号" + me.identify + "?释放的合同编号将进入优先编号库,下次自动生成时将优先使用。",
                        success: function () {
                            var identify = me.identify;
                            me.$http.post("/constarct/freeIdentify", {"identify": identify}).then(function (response) {
                                var data = response.data;
                                jQuery.fn.codeState(data.code, {
                                    200: function () {
                                        jQuery.fn.alert_msg("合同编码释放成功!");
                                        me.identify = "";
                                    }
                                })
                            }, function (response) {
                                jQuery.fn.error_msg("无法生成合同编号,请尝试刷新操作。");
                            });
                        }
                    });
                }
            },
            /**
             * 页面加载完成,执行ready操作
             */
            ready: function () {
                var me = this;
                var dom = jQuery(me.$el);
                jQuery("#contractForm").validate({
                    highlight: function (element) {
                        jQuery(element).closest('.form-group').removeClass('has-success').addClass('has-error');
                    },
                    success: function (element) {
                        jQuery(element).closest('.form-group').removeClass('has-error');
                    }
                });

                jQuery('#validationWizard').bootstrapWizard({
                    tabClass: 'nav nav-pills nav-justified nav-disabled-click',
                    'nextSelector': '.next',
                    'previousSelector': '.previous',
                    onInit: function () {
                        jQuery('.wizard .finish').hide();
                        jQuery('.wizard .draft').hide();
                        jQuery('.wizard .print').hide();
                        jQuery('.wizard .previous').hide();
                    },
                    onTabClick: function (tab, navigation, index) {
                        return false;
                    },
                    onNext: function (tab, navigation, index) {
                        var $total = navigation.find('li').length;
                        var $current = index + 1;
                        var $percent = ($current / $total) * 100;
                        jQuery('#validationWizard').find('.progress-bar').css('width', $percent + '%');

                        var $valid = jQuery('#contractForm').valid();
                        if (!$valid) {
                            return false;
                        }

                        if (index >= 3) {
                            jQuery('.wizard .finish').show();
                            jQuery('.wizard .draft').show();
                            jQuery('.wizard .print').show();
                        } else {
                            jQuery('.wizard .finish').hide();
                            jQuery('.wizard .draft').hide();
                            jQuery('.wizard .print').hide();
                        }
                        if (index == 3) {
                            jQuery('.wizard .next').hide();
                        } else {
                            jQuery('.wizard .next').show();
                        }
                        if (index == 0) {
                            jQuery('.wizard .previous').hide();
                        } else {
                            jQuery('.wizard .previous').show();
                        }
                        adjustmainpanelheight();
                    },
                    onPrevious: function (tab, navigation, index) {
                        var $total = navigation.find('li').length;
                        var $current = index + 1;
                        var $percent = ($current / $total) * 100;
                        jQuery('#validationWizard').find('.progress-bar').css('width', $percent + '%');
                        if (index >= 3) {
                            jQuery('.wizard .finish').show();
                            jQuery('.wizard .draft').show();
                            jQuery('.wizard .print').hide();
                        } else {
                            jQuery('.wizard .finish').hide();
                            jQuery('.wizard .draft').hide();
                            jQuery('.wizard .print').hide();
                        }
                        if (index == 0) {
                            jQuery('.wizard .next').hide();
                        }
                        if (index == 3) {
                            jQuery('.wizard .next').hide();
                        } else {
                            jQuery('.wizard .next').show();
                        }
                        if (index == 0) {
                            jQuery('.wizard .previous').hide();
                        } else {
                            jQuery('.wizard .previous').show();
                        }
                        adjustmainpanelheight();
                    },
                    onTabShow: function (tab, navigation, index) {
                        var $total = navigation.find('li').length;
                        var $current = index + 1;
                        var $percent = ($current / $total) * 100;
                        jQuery('#validationWizard').find('.progress-bar').css('width', $percent + '%');
                    }
                });

                jQuery(".select2").select2({
                    width: '100%',
                    minimumResultsForSearch: -1
                });
                jQuery('#datepicker-multiple').datepicker({
                    numberOfMonths: 3,
                    showButtonPanel: true
                });

                this.$watch('monitor_way', function (val) {
                    if (this.monitor_way == 0) {
                        jQuery('input[name=monitor_way_desp]').prop("disabled", true).val("");
                    } else {
                        jQuery('input[name=monitor_way_desp]').prop("disabled", false);
                    }
                });

                this.$watch('payment_count', function (val) {
                    var count = chineseNumber(val);
                    me.$set("payment_count_chinese", count);
                });


                jQuery("#monitor_type").on("change", function (event) {
                    var index = event.val;
                    me.$set("monitor_type", index);
                });

                jQuery("#payment_way").on("change", function (event) {
                    var index = event.val;
                    me.$set("payment_way", index);
                });

                //加载用户列表
                me.$http.get("/user/getList").then(function (response) {
                    var data = response.data;
                    me.$set("user_list", data.results);
                }, function (response) {
                    jQuery.fn.error_msg("无法获取用户列表信息,请尝试刷新操作。");
                });

                //加载监测类别
                me.$http.get("/constarct/monitorType").then(function (response) {
                    var data = response.data;
                    for (var key in data) {
                        me.monitor_typeList.push({
                            id: data[key],
                            value: key
                        })
                    }
                }, function (response) {
                    jQuery.fn.error_msg("无法获取监测类别列表信息,请尝试刷新操作。");
                });


                jQuery('#trustee').on("change", function (event) {
                    var id = event.val;
                    me.$http.get("/user/getById", {
                        params: {
                            id: id
                        }
                    }).then(function (response) {
                        var data = response.data;
                        me.$set("trustee",data);
                    }, function (response) {
                        jQuery.fn.error_msg("服务器无法获取承办人信息！");
                    })
                })

            }
        });


        function chineseNumber(num) {
            if (isNaN(num) || num > Math.pow(10, 12))
                return "";
            var cn = "零壹贰叁肆伍陆柒捌玖";
            var unit = new Array("拾百千", "分角");
            var unit1 = new Array("万亿", "");
            var numArray = num.toString().split(".");
            var start = new Array(numArray[0].length - 1, 2);

            function toChinese(num, index) {
                var num = num.replace(/\d/g, function ($1) {
                    return cn.charAt($1) + unit[index].charAt(start-- % 4 ? start % 4 : -1)
                })
                return num
            }

            for (var i = 0; i < numArray.length; i++) {
                var tmp = ""
                for (var j = 0; j * 4 < numArray[i].length; j++) {
                    var strIndex = numArray[i].length - (j + 1) * 4
                    var str = numArray[i].substring(strIndex, strIndex + 4)
                    var start = i ? 2 : str.length - 1
                    var tmp1 = toChinese(str, i)
                    tmp1 = tmp1.replace(/(零.)+/g, "零").replace(/零+$/, "")
                    tmp1 = tmp1.replace(/^壹拾/, "拾")
                    tmp = (tmp1 + unit1[i].charAt(j - 1)) + tmp
                }
                numArray[i] = tmp
            }
            numArray[1] = numArray[1] ? numArray[1] : ""
            numArray[0] = numArray[0] ? numArray[0] + "元" : numArray[0], numArray[1] = numArray[1].replace(/^零+/, "")
            numArray[1] = numArray[1].match(/分/) ? numArray[1] : numArray[1] + "整"
            return numArray[0] + numArray[1]
        }
    });
</script>