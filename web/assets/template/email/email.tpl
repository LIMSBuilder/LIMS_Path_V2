<div class="row">
    <div class="col-sm-3 col-lg-2">
        <a href="javascript:;" class="btn btn-danger btn-block btn-compose-email" @click="new_mail">新邮件</a>

        <ul class="nav nav-pills nav-stacked nav-email nav-email-box">
            <li class="active">
                <a href="javascript:;" @click="view_box('receive','收件箱')">
                    <span class="badge pull-right">2</span>
                    <i class="glyphicon glyphicon-inbox"></i> 收件箱
                </a>
            </li>
            <li><a href="javascript:;" @click="view_box('star','星标邮件')"><i class="glyphicon glyphicon-star"></i>
                星标邮件</a></li>
            <li><a href="javascript:;" @click="view_box('send','发件箱')"><i class="glyphicon glyphicon-send"></i> 发件箱</a>
            </li>
            <li>
                <a href="javascript:;" @click="view_box('draft','草稿箱')">
                    <span class="badge pull-right">3</span>
                    <i class="glyphicon glyphicon-pencil"></i> 草稿箱
                </a>
            </li>
            <li><a href="javascript:;" @click="view_box('dustbin','垃圾箱')"><i class="glyphicon glyphicon-trash"></i> 垃圾箱</a>
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
                <!--<component :is="currentView"></component>-->
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
            result: []
        },
        methods: {
            new_mail: function () {
                var me =this;
                var tpl = jQuery.fn.loadTemplate("/assets/template/subject/compose.tpl");
                me.$http.get("/assets/json/mail_receiver_list.json").then(function (response) {
                    var data = response.data;
                    var render = template.compile(tpl);
                    jQuery('#mail_right').html(render({receiver_list: data.results}));
                }, function (response) {

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
            view_folder: function (item) {
                console.log("查看" + item.name + "的方法,id为" + item.id);
            },
            view_box: function (item, msg) {
                console.log(item);
                var me = this;
                me.$http.get("/assets/json/mail_list.json").then(function (response) {
                    var data = response.data;
                    var tpl = jQuery.fn.loadTemplate("/assets/template/subject/mail_box.tpl");
                    var render = template.compile(tpl);
                    data.box_type = msg;
                    data.folder_list=me.$get("folder_list");
                    jQuery('#mail_right').html(render(data));


                }, function (response) {

                });

            }
        },
        ready: function () {
            var me = this;
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

            });

            me.$http.get("/assets/json/mail_list.json").then(function (response) {
                var data = response.data;
                var tpl = jQuery.fn.loadTemplate("/assets/template/subject/mail_box.tpl");
                var render = template.compile(tpl);
                data.box_type = '收件箱';
                data.folder_list=me.$get("folder_list");
                jQuery('#mail_right').html(render(data));

            }, function (response) {
            });

            jQuery('.nav-email-box li').on("click", function () {
                jQuery(this).addClass('active').siblings('li').removeClass('active');
            })
        }
    });

</script>