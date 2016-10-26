<div class="row">
    <div class="col-md-12">
        <form class="form-horizontal">
            <div class="form-group">
                <label class="col-sm-2 control-label">部门名称</label>
                <div class="col-sm-9">
                    <input type="text" v-model="name" placeholder="请输入部门名称" class="form-control">
                </div>
            </div>
            <div class="form-group">
                <div class="text-center">
                    <a class="btn btn-primary" @click="save">保 存</a>
                    <a class="btn btn-default" data-dismiss="modal">关 闭</a>
                </div>
            </div>
        </form>

    </div>
</div>