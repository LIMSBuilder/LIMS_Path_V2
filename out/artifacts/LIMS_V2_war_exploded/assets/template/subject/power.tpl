<div class="row">
    <div class="col-md-12">
        <template v-for="item in power_list">
            <div class="table-responsive">
                <table class="table table-bordered mb30 text-center">
                    <thead>
                    <tr>
                        <th class="text-success" colspan="2">
                            <h4>{{item.name}}</h4>
                        </th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td class="text-success">
                            全部
                        </td>
                        <td>
                            <input type="checkbox" name="select_all" value="0" @change="choose_all"/>
                        </td>
                    </tr>
                    <template v-for="sub in item.subject">
                        <tr>
                            <td class="text-info">
                                {{sub.name}}
                            </td>
                            <td>
                                <input type="checkbox" value="{{sub.id}}" v-model="checked_power"/>
                            </td>
                        </tr>
                    </template>
                    </tbody>
                </table>
            </div>
        </template>
        <div class="text-center col-md-12">
            <a class="btn btn-primary" @click="save">保存设置</a>
            <a class="btn btn-default" @click="clear">清空选择</a>
        </div>
    </div>
</div>