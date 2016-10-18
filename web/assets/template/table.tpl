<div class="row">
    <div class="col-md-9">
        <div class="btn-demo" id="toolbar">
            {{each toolbar as value index}}
            {{if value=="new"}}<a class="btn btn-info-alt new_obj" data-toggle="modal"
                                  data-target=".bs-example-modal-lg">新
            增</a>{{/if}}
            {{if value=="select_all"}}<a class="btn btn-primary-alt select_all">全 选</a>{{/if}}
            {{if value=="select_toggle"}}<a class="btn btn-default-alt select_no">反 选</a>{{/if}}
            {{if value=="run"}}<a class="btn btn-success-alt run_all_select">启 用</a>{{/if}}
            {{if value=="stop"}}<a class="btn btn-warning-alt stop_all_select">禁 用</a>{{/if}}
            {{if value=="delete"}} <a class="btn btn-danger-alt del_all_select">删 除</a>{{/if}}
            {{/each}}
        </div>
    </div>
    <div class="col-md-3">
        {{if hasSearch}}
            <input type="text" placeholder="搜索内容..." id="serach" class="form-control">
        {{/if}}
    </div>
</div>
<div class="row">
    <div class="col-md-12">
        <div class="table-responsive">
            <table class="table table-info table-hidaction table-hover mb30">
                <thead>
                <tr>
                <tr>
                    {{if hasSelect}}
                    <th class="text-center">
                        选择
                    </th>
                    {{/if}}
                    {{each ths as th index }}
                    <th class="text-center">{{th}}</th>
                    {{/each}}
                    {{if th_opt}}
                    <th class="text-center">操作</th>
                    {{/if}}
                </tr>
                </tr>
                </thead>
                <tbody>

                {{each datas as data index}}
                <tr>
                    {{if hasSelect}}
                    <td class="text-center"><input type="checkbox" name="check"></td>
                    {{/if}}
                    {{each data as value index}}

                    <td class="text-center">{{#value}}</td>
                    {{/each}}
                    {{if th_opt}}
                    <td class="table-action-hide text-center">
                        {{each td_opt as opt index}}
                        {{if opt=="edit"}}
                        <a href="javascript:;" data-toggle="modal" data-target=".bs-example-modal-lg"><i
                                class="fa fa-pencil edit_item"></i></a>
                        {{/if}}
                        {{if opt=="run"}}
                        <a href="javascript:;"><i class="fa fa-eye run_item"></i></a>
                        {{/if}}
                        {{if opt=="stop"}}
                        <a href="javascript:;"><i class="fa fa-eye-slash stop_item"></i></a>
                        {{/if}}
                        {{if opt=="delete"}}
                        <a href="javascript:;" class="delete-row"><i class="fa fa-trash-o del_item"></i></a>
                        {{/if}}
                        {{/each}}
                    </td>
                    {{/if}}
                </tr>
                {{/each}}
                </tbody>
            </table>
        </div><!-- table-responsive -->
    </div><!-- col-md-12 -->

</div>
<div class="row">
    <div class="col-md-12 ">
        <div class="paging pull-right"></div>
    </div>

</div>
<div class="modal fade bs-example-modal-lg" id="addDepart" tabindex="-1" role="dialog"
     aria-labelledby="myLargeModalLabel"
     aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button aria-hidden="true" data-dismiss="modal" class="close" type="button">&times;</button>
                <h4 class="modal-title">编辑部门信息</h4>
            </div>
            <div class="modal-body" id="modal_body">
                {{#body}}
            </div>
        </div>
    </div>
</div>



