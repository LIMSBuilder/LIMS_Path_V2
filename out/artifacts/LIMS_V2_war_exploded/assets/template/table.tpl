<div class="row">
    <div class="col-md-9">
        <div class="btn-demo" id="toolbar">
            <a class="btn btn-info-alt new_obj" data-toggle="modal" data-target=".bs-example-modal-lg">新
                增</a>
            <a class="btn btn-primary-alt select_all">全 选</a>
            <a class="btn btn-default-alt select_no">反 选</a>
            <a class="btn btn-success-alt run_all_select">启 用</a>
            <a class="btn btn-warning-alt stop_all_select">禁 用</a>
            <a class="btn btn-danger-alt del_all_select">删 除</a>
        </div>
    </div>
    <div class="col-md-3">
        <input type="text" placeholder="搜索内容..." id="serach" class="form-control">
    </div>
</div>
<div class="row">
    <div class="col-md-12">
        <div class="table-responsive">
            <table class="table table-info table-hidaction table-hover mb30">
                <thead>
                <tr>
                <tr>
                    <th class="text-center">
                        选择
                    </th>
                    <th class="text-center">部门编号</th>
                    <th class="text-center">部门名称</th>
                    <th class="text-center">当前状态</th>
                    <th class="text-center">部门人数</th>
                    <th class="text-center">操作</th>
                </tr>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td class="text-center"><input type="checkbox" name="check"></td>
                    <td class="text-center">1</td>
                    <td class="text-center">部门1</td>
                    <td class="text-center">
                        <span class="label label-warning">禁用</span>
                    </td>
                    <td class="text-center">20</td>
                    <td class="table-action-hide text-center">
                        <a href="javascript:;" data-toggle="modal" data-target=".bs-example-modal-lg"><i class="fa fa-pencil edit_item"></i></a>
                        <a href="javascript:;"><i class="fa fa-eye run_item"></i></a>
                        <a href="javascript:;" class="delete-row"><i class="fa fa-trash-o del_item"></i></a>
                    </td>
                </tr>
                <tr>
                    <td class="text-center"><input type="checkbox" name="check"></td>
                    <td class="text-center">2</td>
                    <td class="text-center">部门2</td>
                    <td class="text-center">
                        <span class="label label-warning">禁用</span>
                    </td>
                    <td class="text-center">15</td>
                    <td class="table-action-hide text-center">
                        <a href="javascript:;" data-toggle="modal" data-target=".bs-example-modal-lg"><i class="fa fa-pencil edit_item"></i></a>
                        <a href="javascript:;"><i class="fa fa-eye run_item"></i></a>
                        <a href="javascript:;" class="delete-row"><i class="fa fa-trash-o del_item"></i></a>
                    </td>
                </tr>
                <tr>
                    <td class="text-center"><input type="checkbox" name="check"></td>
                    <td class="text-center">3</td>
                    <td class="text-center">部门3</td>
                    <td class="text-center">
                        <span class="label label-success">正常</span>
                    </td>
                    <td class="text-center">30</td>
                    <td class="table-action-hide text-center">
                        <a href="javascript:;" data-toggle="modal" data-target=".bs-example-modal-lg"><i class="fa fa-pencil edit_item"></i></a>
                        <a href="javascript:;"><i class="fa fa-eye-slash stop_item"></i></a>
                        <a href="javascript:;" class="delete-row"><i class="fa fa-trash-o del_item"></i></a>
                    </td>
                </tr>
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
                <script type="text/javascript">
                    jQuery.get("/assets/template/items/depart.tpl", function (data) {
                        jQuery('#modal_body').html(data);
                    });
                </script>
            </div>
        </div>
    </div>
</div>