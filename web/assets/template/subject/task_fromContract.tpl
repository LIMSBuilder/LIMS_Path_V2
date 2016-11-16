<div class="row">
    <div class="col-sm-12 col-md-12">
        <div class="panel panel-default">
            <div class="panel-heading">
                <div class="paging nomargin pull-right"></div>
                <p>共有 {{totalRowCount}} 个结果。</p>
            </div><!-- panel-heading -->
            <div class="panel-body">
                <div class="results-list">
                    <template v-for="result in result_list">
                        <div class="media">
                            <a href="javascript:;" class="pull-left">
                                <img alt="" src="/assets/images/photos/contract.png" class="media-object">
                            </a>
                            <div class="media-body">
                                <div class="btn-demo pull-right">
                                    <a class="btn btn-info-alt " @click="import_into(result)">导入</a>
                                    <a class="btn btn-default-alt " @click="view_info(result)">查看合同</a>
                                </div>
                                <h4 class="filename text-primary">{{result.project_name}}</h4>
                                <small class="text-muted">合同编号: {{result.identify}}</small>
                                <br/>
                                <small class="text-muted">监测类型: {{result.monitor_type}}</small>
                                <br/>
                                <small class="text-muted">创建时间: {{result.create_time}}</small>
                                <br/>
                                <small class="text-muted">客户单位: {{result.client_unit}}</small>
                            </div>
                        </div>

                    </template>

                </div><!-- results-list -->

            </div><!-- panel-body -->
        </div><!-- panel -->
    </div><!-- col-sm-8 -->
</div><!-- row -->