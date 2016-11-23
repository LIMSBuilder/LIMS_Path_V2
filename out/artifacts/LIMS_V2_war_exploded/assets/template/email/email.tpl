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
            <li><a href="javascript:;" @click="load_list('2','星标邮件',1)"><i class="glyphicon glyphicon-star"></i>
                星标邮件</a></li>
            <!--<li><a href="javascript:;" @click="view_box('send','发件箱')"><i class="glyphicon glyphicon-send"></i> 发件箱</a>-->
            <!--</li>-->
            <!--<li>-->
            <!--<a href="javascript:;" @click="load_list('-1','草稿箱')">-->
            <!--<span class="badge pull-right ">{{unsend}}</span>-->
            <!--<i class="glyphicon glyphicon-pencil"></i> 草稿箱-->
            <!--</a>-->
            <!--</li>-->
            <li><a href="javascript:;" @click="load_list('-2','垃圾箱',1)"><i class="glyphicon glyphicon-trash"></i>
                垃圾箱</a>
            </li>
        </ul>

        <div class="mb30"></div>

        <h5 class="subtitle">文件夹<p class="nav pull-right"><a href="javascript:;" @click="add_folder" data-toggle="modal"
                                                             data-target=".bs-example-modal-static"><i
                class="fa fa-plus"></i></a></p></h5>
        <ul class="nav nav-pills nav-stacked nav-email mb20">
            <template v-for="folder in folder_list">
                <li>
                    <a href="javascript:;" @click="view_folder(folder)">
                        <span class="badge pull-right" v-if="folder.unread!=0">{{folder.unread}}</span>
                        <i class="glyphicon glyphicon-folder-open"></i> {{folder.name}}
                    </a>
                </li>
            </template>
        </ul>
    </div><!-- col-sm-3 -->

    <div class="col-sm-9 col-lg-10">

        <div class="panel panel-default" id="email_content">
            <div class="panel-body" id="mail_right">


                <div class="pull-right">
                    <div class="btn-group mr10">
                        <button class="btn btn-sm btn-white tooltips" type="button" data-toggle="tooltip"
                                title="设为星标" id="star_all"><i class="glyphicon glyphicon-star"></i></button>
                        <button class="btn btn-sm btn-white tooltips" type="button" data-toggle="tooltip"
                                title="标记已读" id="read_all"><i class="glyphicon glyphicon-eye-open"></i></button>
                        <button class="btn btn-sm btn-white tooltips" type="button" data-toggle="tooltip"
                                title="删除邮件" id="del_all"><i class="glyphicon glyphicon-trash"></i></button>
                    </div>

                    <div class="btn-group mr10">
                        <div class="btn-group nomargin">
                            <button data-toggle="dropdown"
                                    class="btn btn-sm btn-white dropdown-toggle tooltips" type="button"
                                    title="归档">
                                <i class="glyphicon glyphicon-folder-close mr5"></i>
                                <span class="caret"></span>
                            </button>
                            <ul class="dropdown-menu">
                                <template v-for="item in folder_list">
                                    <li><a href="#"><i class="glyphicon glyphicon-folder-open mr5"></i>
                                        {{item.name}}</a></li>
                                </template>
                            </ul>
                        </div>
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
                            <tr :class="item.state==0?'unread':''" @click="read_mail(item)">
                                <td>
                                    <div class="ckbox ckbox-success">
                                        <input type="checkbox" id="checkbox{{item.id}}">
                                        <label for="checkbox{{item.id}}"></label>
                                    </div>
                                </td>
                                <td>
                                    <a href="javascript:;" @click="item.state==2?cancel_star(item):star(item)"
                                       :class="item.state==2?'star star-checked':'star'"><i
                                            class="glyphicon glyphicon-star"></i></a>
                                </td>
                                <td>
                                    <div class="media">
                                        <a href="#" class="pull-left">
                                            <img alt="" src="/assets/images/photos/user3.png" class="media-object">
                                        </a>
                                        <div class="media-body">
                                            <span class="media-meta pull-right">{{item.send_time}}</span>
                                            <h4 class="text-primary">{{item.sender.name}}</h4>
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
            folder_list: [],
            currentView: "",
            result: [],
            unread: "",
            unsend: "",
            mail_list: [],
            box_type: "",
            currentPage: 1,
            totalPage: 1
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
            add_folder: function () {
                var template = jQuery.fn.loadTemplate("/assets/template/subject/mail_folder_addItem.tpl");

                Vue.component("mail_folder_addItem", {
                    template: template,
                    data: function () {
                        return {
                            "name": ""
                        }
                    },
                    methods: {
                        save: function () {
                            var me = this;
                            jQuery("#custom_modal").modal("hide");
                            jQuery.fn.check_msg({
                                msg: "是否保存名为" + me.name + "的分类文件夹?",
                                success: function () {
                                    jQuery.fn.alert_msg("分类文件夹创建成功!");
                                }
                            })
                        }
                    },
                    ready: function () {

                    }
                });


                LIMS.dialog.$set('title', '增加分类文件夹');
                LIMS.dialog.currentView = 'mail_folder_addItem';
            },
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
                        debugger
                        me.load_list(me.getState(), me.box_type, me.currentPage);
                        me.load_count();
                    }
                });
                LIMS.dialog_lg.$set('title', '阅读邮件');
                LIMS.dialog_lg.currentView = 'read_mail' + item.mailReceive_id;

            },
            star: function (item) {
                var me = this;
                me.change_State(item, '2');
            },
            cancel_star: function (item) {
                var me = this;
                me.change_State(item, '1');
            },
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
            prev_list: function () {
                var me = this;
                me.load_list(me.getState(), me.box_type, me.currentPage - 1);
            },
            next_list: function () {
                var me = this;
                me.load_list(me.getState(), me.box_type, me.currentPage + 1);
            },
            load_count: function () {
                var me = this;
                me.$http.get("/mail/mail_count").then(function (response) {
                    var data = response.data;
                    me.$set("unread", data.unread == 0 ? "" : data.unread);
                    me.$set("unsend", data.unsend == 0 ? "" : data.unsend);
                });
            },

            load_list: function (state, desp, currentPage) {
                var me = this;
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

            me.$http.get("/assets/json/mail_folder.json").then(function (response) {
                var data = response.data;
                me.$set("folder_list", data.results);
            }, function (response) {
                jQuery.fn.error_msg("数据异常,无法获取分类文件夹信息!");
            });
            //左侧邮箱分类点击事件
            jQuery('.nav-email-box li').off("click").on("click", function () {
                jQuery(this).addClass('active').siblings('li').removeClass('active');
            });

            me.load_count();
            me.load_list('0,1', '收件箱', 1);
        }
    });

</script>