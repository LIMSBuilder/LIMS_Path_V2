<div class="row">
    <div class="col-md-12">
        <div class="table-responsive">
            <table class="table table-bordered mb30 text-center">
                <tr>
                    <th colspan="6" class="text-center"><h4>任 务 书</h4></th>
                </tr>
                <tr>
                    <td>任务书编号</td>
                    <td colspan="5">{{identify}}</td>
                </tr>
                <tr>
                    <td>委托单位</td>
                    <td colspan="5">{{client_unit}}</td>
                </tr>
                <tr>
                    <td>监测目的</td>
                    <td colspan="5">{{monitor_aim}}</td>
                </tr>
                <tr>
                    <td>联系地址</td>
                    <td colspan="2">{{client_address}}</td>
                    <td>邮政编码</td>
                    <td colspan="2">{{client_code}}</td>
                </tr>
                <tr>
                    <td>联系人</td>
                    <td colspan="2">{{client}}</td>
                    <td>联系电话</td>
                    <td colspan="2">{{client_tel}}</td>
                </tr>
                <tr>
                    <td>监测内容</td>
                    <td colspan="5">
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
                                    </tr>
                                </template>
                                </tbody>
                            </table>
                        </div><!-- table-responsive -->

                    </td>
                </tr>
                <tr>
                    <td>监测方法</td>
                    <td colspan="5" v-if="monitor_way==0">以我单位通过计量认证、国家实验室认可的方法进行检测</td>
                    <td colspan="5" v-if="monitor_way==1">客户指定的方法:{{monitor_way_desp}}</td>
                </tr>
                <tr>
                    <td>任务下达人</td>
                    <td colspan="2">{{task_assigned}}</td>
                    <td>日期</td>
                    <td colspan="2">{{task_assigned_date}}</td>
                </tr>
                <tr>
                    <td>承接科室</td>
                    <td colspan="2">{{receive_depart}}</td>
                    <td>项目负责人</td>
                    <td colspan="2">{{task_charge}}</td>
                </tr>
                <tr>
                    <td>报告编制人</td>
                    <td colspan="2">{{report_edit}}</td>
                    <td>日期</td>
                    <td colspan="2">{{report_edit_date}}</td>
                </tr>
                <tr>
                    <td>报告一审人</td>
                    <td colspan="2">{{report_first_check}}</td>
                    <td>日期</td>
                    <td colspan="2">{{report_first_check_date}}</td>
                </tr>
                <tr>
                    <td>报告二审人</td>
                    <td colspan="2">{{report_second_check}}</td>
                    <td>日期</td>
                    <td colspan="2">{{report_second_check_date}}</td>
                </tr>
                <tr>
                    <td>报告签发人</td>
                    <td colspan="2">{{report_sign_check}}</td>
                    <td>日期</td>
                    <td colspan="2">{{report_sign_check_date}}</td>
                </tr>
                <tr>
                    <td>业务员签收</td>
                    <td colspan="2">{{report_receive_check}}</td>
                    <td>日期</td>
                    <td colspan="2">{{report_receive_check_date}}</td>
                </tr>
                <tr>
                    <td>归并人签收</td>
                    <td colspan="2">{{report_save_check}}</td>
                    <td>日期</td>
                    <td colspan="2">{{report_save_check_date}}</td>
                </tr>
                <tr>
                    <td>备注</td>
                    <td colspan="5" class="text-left">{{other}}</td>
                </tr>
            </table>
        </div>
        <div class="btn-demo">
            <a class="btn btn-primary">导 出</a>
            <a class="btn btn-default">打 印</a>
        </div>
    </div>
</div>