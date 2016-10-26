<form class="form-horizontal form-bordered" id="monitor_addItem">

    <div class="form-group">
        <label class="col-sm-2 control-label">环境要素</label>
        <div class="col-sm-10">
            <select class="select2"
                    data-placeholder="选择环境要素" name="environment" v-model="environment"
                    required>
                <option></option>
                <template v-for="item in monitor_type_item">
                    <option value="{{item.id}}">{{item.name}}</option>
                </template>
            </select>
        </div>
    </div>

    <div class="form-group">
        <label class="col-sm-2 control-label">监测点</label>
        <div class="col-sm-10">
            <div class="alert alert-info">
                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
                <strong>监测点输入完成之后回车可以多次输入!</strong>
            </div>
            <input name="tags" id="tags" class="form-control" v-model="monitor_point" value=""/>
        </div>
    </div>
    <div class="form-group">
        <label class="col-sm-2 control-label">监测项目</label>
        <div class="col-sm-10">
            <select class="select2"
                    data-placeholder="选择监测项目" multiple id="monitor_item" v-model="monitor_item"
                    required>
            </select>
        </div>
    </div>
    <div class="form-group">
        <label class="col-sm-2 control-label">监测频次</label>
        <div class="col-sm-10">
            <select class="select2"
                    data-placeholder="选择监测频次" name="frequency" v-model="frequency"
                    required>
                <option></option>
                <template v-for="item in frequency_item">
                    <option value="{{item}}">{{item}}</option>
                </template>
            </select>
        </div>
    </div>
    <div class="form-group">
        <label class="col-sm-2 control-label">备注</label>
        <div class="col-sm-10">
            <textarea v-model="other" class="form-control" rows="5"></textarea>
        </div>
    </div>
    <div class="form-group text-right">
        <a class="btn btn-primary" v-on:click="save">保 存</a>
        <a class="btn btn-default" v-on:click="cancel">取 消</a>
    </div>
</form>