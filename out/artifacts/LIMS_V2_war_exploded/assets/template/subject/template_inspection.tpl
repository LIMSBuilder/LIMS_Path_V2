<div class="row">
    <div class="col-md-12">
        <form id="category_form">
            <div class="form-group">
                <label class="col-sm-2 control-label text-center"> 选择模板 </label>
                <div class="col-sm-8">
                    <select class="select2" id="template_choose" data-placeholder="请选择送检模板">
                        <option value=""></option>
                        <template v-for="item in templateList">
                            <option value="{{item.id}}">{{item.name}}</option>
                        </template>
                    </select>

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