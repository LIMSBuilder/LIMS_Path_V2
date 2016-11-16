<div class="row">
    <ul class="nav nav-pills nav-justified step step-progress">
        <template v-if="state>=0">
            <li @click="state(0)" :class="state>=0?'active':''"><a>合同起草<span class="caret"></span></a>
            </li>
            <li @click="state(1)" :class="state>=1?'active':''"><a>合同审核<span class="caret"></span></a>
            </li>
            <li @click="state(2)" :class="state>=2?'active':''"><a>创建任务<span class="caret"></span></a>
            </li>
        </template>
        <template v-if="state==-2">
            <li @click="state(2)" class="active"><a>合同中止<span class="caret"></span></a>
            </li>
        </template>
        <template v-if="state==-4">
            <li @click="state(2)" class="active"><a>审核拒绝,待修改<span class="caret"></span></a>
            </li>
        </template>
    </ul>
    <div class="mb15"></div>
    <div class="col-sm-12">

    </div>
    <div class="col-md-12 text-center">
        <div class="btn-demo">
            <a class="btn btn-info-alt" style="float: none;" >显示细节</a>
            <a class="btn btn-default-alt" style="float: none;" data-dismiss="modal">关 闭</a>
        </div>
    </div>
</div>

