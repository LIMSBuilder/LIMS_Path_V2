<div class="row">
    <div class="col-md-12">
        <form class="form-horizontal form-bordered center-block" id="modal_form">
            <div class="form-group">
                <label class="col-sm-3 control-label">部门名称</label>
                <div class="col-sm-6">
                    <input type="text" placeholder="请输入部门名称" name="name" value="{{name}}" class="form-control" required>
                </div>
            </div>

            <div class="form-group text-right">
                <button class="btn btn-info add_msg">确 定</button>
                <a class="btn btn-default"
                   onclick="$('#addDepart').modal('hide');">取 消</a>
            </div>
        </form>
    </div>
</div>