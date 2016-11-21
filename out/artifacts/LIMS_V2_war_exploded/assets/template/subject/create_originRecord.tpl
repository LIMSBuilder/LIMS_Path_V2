<div class="row">
    <div class="col-md-9">
        <div class="btn-demo" id="toolbar">
            <a class="btn btn-info-alt" @click="add_record">新 增</a>
            <a class="btn btn-primary-alt" @click="select_all">全 选</a>
            <a class="btn btn-danger-alt del_all_select" @click="del_record(null)">删 除</a>
        </div>
    </div>
</div>
<div class="row">
    <div class="col-md-12">
        <div class="table-responsive">
            <table class="table table-info table-hover mb30 text-center">
                <thead>
                <tr>
                <tr>
                    <th class="text-center"></th>
                    <th class="text-center">编号</th>
                    <th class="text-center">原始记录名称</th>
                    <th class="text-center">操作</th>
                    <th></th>
                </tr>
                </tr>
                </thead>
                <tbody>
                <template v-for="(index,item) in originRecordList">
                    <tr>
                        <td class="text-center">
                            <input type="checkbox" data-value="{{item.name}}" value="{{item.id}}"
                                   name="record_select"></td>
                        <td class="text-center">{{index+1}}</td>
                        <td class="text-center">{{item.name}}</td>
                        <td class="table-action text-center">
                            <a class="btn btn-sm btn-info-alt" @click="changeItem(item)">修改</a>
                            <a class="btn btn-sm btn-warning-alt" @click="del_record(item)">删除</a>
                        </td>
                    </tr>
                </template>
                </tbody>
            </table>
        </div><!-- table-responsive -->
    </div><!-- col-md-12 -->
</div>

<div class="modal fade originRecord" id="create_originRecord" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel"
     aria-hidden="true" >
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button aria-hidden="true" data-dismiss="modal" class="close" type="button">&times;</button>
                <h4 class="modal-title">aa</h4>
            </div>
            <div class="modal-body">

            </div>
        </div>
    </div>
</div>