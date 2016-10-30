<div class="row">
    <div class="col-md-12">
        <form id="project_form">
            <div class="form-group">
                <label class="col-sm-2 control-label text-center">环境要素 </label>
                <div class="col-sm-8">
                    <select class="select2" id="project_category" v-model="category" data-placeholder="请选择环境要素..." required>
                        <option value=""></option>
                        <template v-for="item in types">
                            <option value="{{item.id}}">{{item.name}}</option>
                        </template>
                    </select>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label text-center">项目名称 </label>
                <div class="col-sm-8">
                    <input type="text" name="name" v-model="name" class="form-control"
                           required/>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label text-center">项目描述</label>
                <div class="col-sm-8">
                    <textarea class="form-control" rows="5" v-model="desp"></textarea>
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