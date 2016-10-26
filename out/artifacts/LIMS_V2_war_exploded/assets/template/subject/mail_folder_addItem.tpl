<div class="row">
    <form class="form-horizontal">
        <div class="form-group">
            <label class="col-sm-3 control-label">名称</label>
            <div class="col-sm-8">
                <input type="text" placeholder="分类文件夹名称" v-model="name" class="form-control">
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