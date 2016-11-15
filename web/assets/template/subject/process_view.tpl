<div class="row">
    <ul class="nav nav-pills nav-justified step step-progress">
        <li @click="state(0)" :class="state>=0?'active':''"><a>创建任务<span class="caret"></span></a>
        </li>
        <li @click="state(1)" :class="state>=1?'active':''"><a>样品管理<span class="caret"></span></a>
        </li>
        <li @click="state(2)" :class="state>=2?'active':''"><a>任务交接<span class="caret"></span></a>
        </li>
        <li @click="state(3)" :class="state>=3?'active':''"><a>质量控制<span class="caret"></span></a>
        </li>
        <li @click="state(4)" :class="state>=4?'active':''"><a>样品接收<span class="caret"></span></a>
        </li>
        <li @click="state(5)" :class="state>=5?'active':''"><a>任务分配<span class="caret"></span></a>
        </li>
        <li><a>实验分析<span class="caret"></span></a>
        </li>
        <li><a>结果审核<span class="caret"></span></a>
        </li>
        <li><a>报告编写<span class="caret"></span></a>
        </li>
        <li><a>报告审核<span class="caret"></span></a>
        </li>
    </ul>
    <div class="mb15"></div>
    <div class="col-sm-12">
        <h5 class="col-sm-3 control-label text-center">项目书编号</h5>
        <h5 class="col-sm-9 control-label text-left">{{task.identify}}</h5>
        <h5 class="col-sm-3 control-label text-center">创建时间</h5>
        <h5 class="col-sm-9 control-label text-left">{{task.create_time}}</h5>
        <h5 class="col-sm-3 control-label text-center">创建人</h5>
        <h5 class="col-sm-9 control-label text-left">{{task.create_user.name}}</h5>
    </div>
    <div class="col-md-12 text-center">
        <div class="btn-demo">
            <a class="btn btn-default-alt" style="float: none;" data-dismiss="modal">关 闭</a>
        </div>
    </div>
</div>

