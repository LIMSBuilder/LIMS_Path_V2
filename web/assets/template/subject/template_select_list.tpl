<div class="row" id="customer_select_list">
    <div class="form-group">
        <div class="col-sm-12">
            <input type="text" v-on:keydown.enter="startSearch" placeholder="搜索模板..." class="form-control input-sm">
        </div>
    </div>
    <div class="col-md-12">
        <div class="table-responsive">
            <table class="table table-hover table-info mb30">
                <thead>
                <tr>
                    <th class="text-center">编号</th>
                    <th class="text-center">模板名称</th>
                    <th class="text-center">创建时间</th>
                    <th class="text-center"></th>
                </tr>
                </thead>
                <tbody>
                <template v-for="(index , template) in templates">
                    <tr class="text-center">
                        <td>{{index+1}}</td>
                        <td>{{template.name}}</td>
                        <td>{{template.create_time}}</td>
                        <td class="table-action">
                            <a href="javascript:;" v-on:click="choose(this)"><i class="fa fa-mail-reply-all"></i></a>
                        </td>
                    </tr>
                </template>
                </tbody>
            </table>
        </div><!-- table-responsive -->
    </div>
</div>