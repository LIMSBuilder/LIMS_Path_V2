<div class="row">
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
    <div class="col-md-12 text-center" >
        <a class="btn btn-primary">打印合同</a>
    </div>
</div>