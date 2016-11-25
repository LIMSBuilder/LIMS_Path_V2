<div class="row">
    <div class="col-sm-3 col-lg-2">
        <a href="javascript:;" class="btn btn-danger btn-block btn-compose-email" @click="new_mail">新邮件</a>

        <ul class="nav nav-pills nav-stacked nav-email nav-email-box">
            <li class="active">
                <a href="javascript:;" @click="load_list('0,1','收件箱',1)">
                    <span class="badge pull-right ">{{unread}}</span>
                    <i class="glyphicon glyphicon-inbox"></i> 收件箱
                </a>
            </li>
            <li><a href="javascript:;" @click="load_sendList('0','发件箱',1)"><i class="glyphicon glyphicon-send"></i> 发件箱</a>
            </li>
            <li><a href="javascript:;" @click="load_list('2','星标邮件',1)"><i class="glyphicon glyphicon-star"></i>
                星标邮件</a></li>
            <li>
                <a href="javascript:;" @click="load_sendList('-1','草稿箱',1)">
                    <span class="badge pull-right ">{{unsend}}</span>
                    <i class="glyphicon glyphicon-pencil"></i> 草稿箱
                </a>
            </li>
            <li><a href="javascript:;" @click="load_list('-2','垃圾箱',1)"><i class="glyphicon glyphicon-trash"></i>
                垃圾箱</a>
            </li>
        </ul>

        <div class="mb30"></div>
    </div><!-- col-sm-3 -->

    <div class="col-sm-9 col-lg-10">

        <div class="panel panel-default" id="email_content">
            <div class="panel-body" v-show="!isSender">
                <div class="pull-right">
                    <div class="btn-group mr10">
                        <button class="btn btn-sm btn-white tooltips" type="button" data-toggle="tooltip"
                                title="设为星标" @click="star_all"><i class="glyphicon glyphicon-star"></i></button>
                        <button class="btn btn-sm btn-white tooltips" type="button" data-toggle="tooltip"
                                title="还原/已读" @click="read_all"><i class="glyphicon glyphicon-pushpin"></i></button>
                        <button class="btn btn-sm btn-white tooltips" type="button" data-toggle="tooltip"
                                title="删除邮件" @click="del_all"><i class="glyphicon glyphicon-trash"></i></button>
                    </div>
                    <div class="btn-group">
                        <button :disabled="currentPage==1" class="btn btn-sm btn-white" title="上一封"
                                type="button"><i
                                class="glyphicon glyphicon-chevron-left" @click="prev_list"></i></button>
                        <button :disabled="currentPage==totalPage" class="btn btn-sm btn-white"
                                title="下一封" type="button"><i
                                class="glyphicon glyphicon-chevron-right" @click="next_list"></i></button>
                    </div>
                </div><!-- pull-right -->

                <h5 class="subtitle mb5">{{box_type}}</h5>
                <p class="text-muted">当前第 {{currentPage}} 页，共 {{totalPage}} 页</p>
                <div class="table-responsive">
                    <table class="table table-email">
                        <tbody>
                        <template v-for="item in mail_list">
                            <tr :class="item.state==0?'unread':''">
                                <td>
                                    <div class="ckbox ckbox-success">
                                        <input type="checkbox" value="{{item.mailReceive_id}}"
                                               v-model="selected_mail"
                                               id="checkbox{{item.mailReceive_id}}">
                                        <label for="checkbox{{item.mailReceive_id}}"></label>
                                    </div>
                                </td>
                                <td>
                                    <a href="javascript:;" @click="item.state==2?cancel_star(item):star(item)"
                                       :class="item.state==2?'star star-checked':'star'"><i
                                            class="glyphicon glyphicon-star"></i></a>
                                </td>
                                <td @click="read_mail(item)">
                                    <div class="media">
                                        <a href="#" class="pull-left">
                                            <img alt="" src="/assets/images/photos/user3.png" class="media-object">
                                        </a>
                                        <div class="media-body">
                                            <span class="media-meta pull-right">{{item.send_time}}</span>
                                            <h4 class="text-primary">{{1}}</h4>
                                            <small class="text-muted"></small>
                                            <p class="email-summary">{{item.title}}</p>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                        </template>
                        </tbody>
                    </table>
                </div><!-- table-responsive -->
            </div><!-- panel-body -->
            <div class="panel-body" v-show="isSender">
                <div class="pull-right">
                    <div class="btn-group mr10">
                        <button class="btn btn-sm btn-white tooltips" type="button" data-toggle="tooltip"
                                title="删除邮件" @click="del_all"><i class="glyphicon glyphicon-trash"></i></button>
                    </div>
                    <div class="btn-group">
                        <button :disabled="currentPage==1" class="btn btn-sm btn-white" title="上一封"
                                type="button"><i
                                class="glyphicon glyphicon-chevron-left" @click="prev_list"></i></button>
                        <button :disabled="currentPage==totalPage" class="btn btn-sm btn-white"
                                title="下一封" type="button"><i
                                class="glyphicon glyphicon-chevron-right" @click="next_list"></i></button>
                    </div>
                </div><!-- pull-right -->

                <h5 class="subtitle mb5">{{box_type}}</h5>
                <p class="text-muted">当前第 {{currentPage}} 页，共 {{totalPage}} 页</p>
                <div class="table-responsive">
                    <table class="table table-email">
                        <tbody>
                        <template v-for="item in mail_list">
                            <tr :class="item.state==0?'unread':''">
                                <td>
                                    <div class="ckbox ckbox-success">
                                        <input type="checkbox" value="{{item.mailReceive_id}}"
                                               v-model="selected_mail"
                                               id="checkbox{{item.id}}">
                                        <label for="checkbox{{item.id}}"></label>
                                    </div>
                                </td>
                                <td>

                                </td>
                                <td @click="read_mail(item)">
                                    <div class="media">
                                        <a href="#" class="pull-left">
                                            <img alt="" src="/assets/images/photos/user3.png" class="media-object">
                                        </a>
                                        <div class="media-body">
                                            <span class="media-meta pull-right">{{item.send_time}}</span>
                                            <h4 class="text-primary">
                                                <template v-for="item in receiver">
                                                    {{item.receiver.name}}
                                                </template>
                                            </h4>
                                            <small class="text-muted"></small>
                                            <p class="email-summary">{{item.title}}</p>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                        </template>
                        </tbody>
                    </table>
                </div><!-- table-responsive -->
            </div><!-- panel-body -->

        </div><!-- panel -->

    </div><!-- col-sm-9 -->

</div><!-- row -->


<script type="text/javascript">

    var vue = new Vue({
        el: "#contentpanel",
        data: {
            currentView: "",
            isSender: false,
            result: [],
            unread: "",
            unsend: "",
            mail_list: [],
            box_type: "",
            currentPage: 1,
            totalPage: 1,
            selected_mail: []
        },
        methods: {
            new_mail: function () {
                var me = this;
                var tpl = jQuery.fn.loadTemplate("/assets/template/subject/compose.tpl");
                me.$http.get("/user/getList").then(function (response) {
                    var data = response.data;
                    var render = template.compile(tpl);
                    jQuery('#mail_right').html(render({receiver_list: data.results}));
                }, function (response) {
                    jQuery.fn.error_msg("数据异常,无法获取用户列表!");
                });

            },
            //将选中设置为星标邮件
            star_all: function () {
                var me = this;
                me.change_StateList(me.selected_mail, 2);
            },
            //将选中设置为已读邮件,并进入收件箱
            read_all: function () {
                var me = this;
                me.change_StateList(me.selected_mail, 1);

            },
            //将选中移入回收站
            del_all: function () {
                var me = this;
                me.change_StateList(me.selected_mail, -2);
            },
            //打开信件
            read_mail: function (item) {
                var me = this;
                jQuery("#custom_lg_modal").modal("show");
                var template = jQuery.fn.loadTemplate("/assets/template/subject/read_mail.tpl");
                Vue.component('read_mail' + item.mailReceive_id, {
                    template: template,
                    data: function () {
                        return {
                            title: "",
                            content: "",
                            sender: {},
                            send_time: ""
                        };
                    },
                    methods: {},
                    ready: function () {
                        var that = this;
                        that.$http.get("/mail/getByReceiveId", {
                            params: {
                                mailReceive_id: item.mailReceive_id
                            }
                        }).then(function (response) {
                            var data = response.data;
                            for (var key in data) {
                                if (that[key] != undefined) {
                                    that.$set(key, data[key]);
                                }
                            }
                        }, function (response) {
                            jQuery.fn.error_msg("数据异常,无法获取邮件信息!");
                        });
                        me.load_list(me.getState(), me.box_type, me.currentPage);
                        me.load_count();
                    }
                });
                LIMS.dialog_lg.$set('title', '阅读邮件');
                LIMS.dialog_lg.currentView = 'read_mail' + item.mailReceive_id;

            },
            //星标邮件
            star: function (item) {
                var me = this;
                me.change_State(item, '2');
            },
            //取消星标
            cancel_star: function (item) {
                var me = this;
                me.change_State(item, '1');
            },
            //改变邮件State 单个
            change_State: function (item, state) {
                var me = this;
                var temp_state = item.state;
                me.$http.post("/mail/changeState", {
                    mailReceive_id: [item.mailReceive_id],
                    state: state
                }).then(function (response) {
                    var data = response.data;
                    jQuery.fn.codeState(data.code, {
                        200: function () {
                            var state = "";
                            switch (temp_state) {
                                case 0:
                                case 1:
                                    state = '0,1';
                                    break;
                                case 2:
                                    state = '2';
                                    break;
                                case -2:
                                    state = '-2';
                            }
                            me.load_count();
                            me.load_list(state, me.box_type, me.currentPage);
                            jQuery.fn.alert_msg("邮件分类设置成功!");
                        }
                    })
                }, function (response) {
                    jQuery.fn.error_msg("服务器异常,无法设置星标邮件!");
                });
            },
            //改变邮件State 批量
            change_StateList: function (changeList, state) {
                var me = this;
                me.$http.post("/mail/changeState", {
                    mailReceive_id: changeList,
                    state: state
                }).then(function (response) {
                    var data = response.data;
                    jQuery.fn.codeState(data.code, {
                        200: function () {
                            me.load_count();
                            me.load_list(me.getState(), me.box_type, me.currentPage);
                            jQuery.fn.alert_msg("邮件分类设置成功!");
                        }
                    })
                }, function (response) {
                    jQuery.fn.error_msg("服务器异常,无法设置邮件类别!");
                });
            },
            //上一页
            prev_list: function () {
                var me = this;
                me.load_list(me.getState(), me.box_type, me.currentPage - 1);
            },
            //下一页
            next_list: function () {
                var me = this;
                me.load_list(me.getState(), me.box_type, me.currentPage + 1);
            },
            //加载提醒数量
            load_count: function () {
                var me = this;
                me.$http.get("/mail/mail_count").then(function (response) {
                    var data = response.data;
                    me.$set("unread", data.unread == 0 ? "" : data.unread);
                    me.$set("unsend", data.unsend == 0 ? "" : data.unsend);
                });
            },
            //加载邮件清单
            load_list: function (state, desp, currentPage) {
                var me = this;
                me.$set("isSender", false);
                me.$set("box_type", desp);
                var rowCount = localStorage.getItem("rowCount") || 0;
                me.$http.get("/mail/getList", {
                    params: {
                        state: state,
                        currentPage: currentPage,
                        rowCount: rowCount
                    }
                }).then(function (response) {
                    var data = response.data;
                    me.$set("mail_list", data.results);
                    me.currentPage = data.currentPage;
                    me.totalPage = data.totalPage == 0 ? 1 : data.totalPage;
                }, function (response) {
                    jQuery.fn.error_msg("服务器异常,无法加载邮件清单");
                });
            },
            load_sendList: function (state, desp, currentPage) {
                var me = this;
                me.$set("isSender", true);
                me.$set("box_type", desp);
                var rowCount = localStorage.getItem("rowCount") || 0;
                me.$http.get("/mail/getSenderList", {
                    params: {
                        state: state,
                        currentPage: currentPage,
                        rowCount: rowCount
                    }
                }).then(function (response) {
                    var data = response.data;
                    me.$set("mail_list", data.results);
                    me.currentPage = data.currentPage;
                    me.totalPage = data.totalPage == 0 ? 1 : data.totalPage;
                }, function (response) {
                    jQuery.fn.error_msg("服务器异常,无法加载邮件清单");
                });
            },
            //获取当前所在State
            getState: function () {
                var me = this;
                var type = me.box_type;
                var result = "";
                switch (type) {
                    case "收件箱":
                        result = "0,1";
                        break;
                    case "星标邮件":
                        result = "2";
                        break;
                    case "垃圾箱":
                        result = "-2";
                        break;
                }
                return result;
            }

        },
        ready: function () {
            var me = this;
            //checkbox
            jQuery('.ckbox input').click(function () {
                var t = jQuery(this);
                if (t.is(':checked')) {
                    t.closest('tr').addClass('selected');
                } else {
                    t.closest('tr').removeClass('selected');
                }
            });

            //左侧邮箱分类点击事件
            jQuery('.nav-email-box li').off("click").on("click", function () {
                me.selected_mail = [];
                jQuery(this).addClass('active').siblings('li').removeClass('active');
            });

            me.load_count();
            me.load_list('0,1', '收件箱', 1);
        }
    });

</script>