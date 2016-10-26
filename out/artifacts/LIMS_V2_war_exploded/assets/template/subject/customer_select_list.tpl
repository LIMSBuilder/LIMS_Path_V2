<div class="row" id="customer_select_list">
    <div class="form-group">
        <div class="col-sm-12">
            <input type="text" v-on:keydown.enter="startSearch" placeholder="搜索客户..." class="form-control input-sm">
        </div>
    </div>
    <div class="col-md-12">
        <div class="table-responsive">
            <table class="table table-hover table-info mb30">
                <thead>
                <tr>
                    <th>编号</th>
                    <th>客户单位</th>
                    <th>联系地址</th>
                    <th>联系人</th>
                    <th></th>
                </tr>
                </thead>
                <tbody>
                <template v-for="(index , customer) in customers">
                    <tr>
                        <td>{{index}}</td>
                        <td>{{customer.client_unit}}</td>
                        <td>{{customer.client_address}}</td>
                        <td>{{customer.client}}</td>
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