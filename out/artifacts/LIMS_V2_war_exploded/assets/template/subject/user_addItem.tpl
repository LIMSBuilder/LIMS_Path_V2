<div class="row">
    <div class="col-md-12">
        <form class="form-horizontal">
            <div class="form-group">
                <label class="col-sm-2 control-label">用户名</label>
                <div class="col-sm-10">
                    <input type="text" v-model="username" class="form-control">
                    <span class="help-block">用户名为用户的唯一登录凭证，由字母或数字组成。</span>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">姓名</label>
                <div class="col-sm-10">
                    <input type="text" v-model="name" class="form-control">
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">性别</label>
                <div class="col-sm-10">
                    <div class="rdio rdio-primary">
                        <input type="radio" v-model="sex" name="radio" value="男" id="man" checked/>
                        <label for="man">男</label>
                    </div>
                    <div class="rdio rdio-primary">
                        <input type="radio" v-model="sex" name="radio" value="女" id="female"/>
                        <label for="female">女</label>
                    </div>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">证件号</label>
                <div class="col-sm-10">
                    <input type="text" v-model="idCard" class="form-control">
                    <span class="help-block">证件号是用户找回密码的唯一凭证。</span>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">联系电话</label>
                <div class="col-sm-10">
                    <input type="text" v-model="tel" class="form-control">
                </div>
            </div>

            <div class="form-group">
                <label class="col-sm-2 control-label">所属部门</label>
                <div class="col-sm-10">
                    <select class="select2" v-model="belong_department" id="depart_select" data-placeholder="请选择部门...">
                        <option value=""></option>
                        <template v-for="item in departments">
                            <option value="{{item.id}}">{{item.name}}</option>
                        </template>
                    </select>
                </div>
            </div>

            <div class="form-group">
                <label class="col-sm-2 control-label">所属角色</label>
                <div class="col-sm-10">

                    <select class="select2" v-model="belong_role" id="role_select" data-placeholder="请选择角色...">
                        <option value=""></option>
                        <template v-for="item in roles">
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