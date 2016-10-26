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
                {{each folder_list as item}}
                <li><a href="#"><i class="glyphicon glyphicon-folder-open mr5"></i>
                    {{item.name}}</a></li>
                {{/each}}
            </ul>
        </div>
    </div>

    <div class="btn-group">
        <button class="btn btn-sm btn-white" title="上一封" type="button"><i
                class="glyphicon glyphicon-chevron-left" id="prev_mail"></i></button>
        <button class="btn btn-sm btn-white" title="下一封" type="button"><i
                class="glyphicon glyphicon-chevron-right" id="next_mail"></i></button>
    </div>
</div><!-- pull-right -->

<h5 class="subtitle mb5">{{box_type}}</h5>
<p class="text-muted">当前第 {{currentPage}} 页，共 {{totalPage}} 页</p>
<div class="table-responsive">
    <table class="table table-email">
        <tbody>
        {{each results as item}}
        <tr {{if item.read==0}}class="unread"{{/if}}>
            <td>
                <div class="ckbox ckbox-success">
                    <input type="checkbox" id="checkbox{{item.id}}">
                    <label for="checkbox{{item.id}}"></label>
                </div>
            </td>
            <td>
                <a href="" class="star"><i class="glyphicon glyphicon-star"></i></a>
            </td>
            <td>
                <div class="media">
                    <a href="#" class="pull-left">
                        <img alt="" src="/assets/images/photos/user3.png" class="media-object">
                    </a>
                    <div class="media-body">
                        <span class="media-meta pull-right">{{item.send_time}}</span>
                        <h4 class="text-primary">{{item.receive.name}}</h4>
                        <small class="text-muted"></small>
                        <p class="email-summary">{{item.title}}</p>
                    </div>
                </div>
            </td>
        </tr>
        {{/each}}
        </tbody>
    </table>
</div><!-- table-responsive -->

<script type="text/javascript">
    // Star
    jQuery('.star').click(function () {
        if (!jQuery(this).hasClass('star-checked')) {
            jQuery(this).addClass('star-checked');
        }
        else
            jQuery(this).removeClass('star-checked');
        return false;
    });

    //批量设为星标
    jQuery("#star_all").off("click").on("click", function () {
        jQuery.fn.check_msg({
            msg: "是否将选中的邮件设置为星标邮件?",
            success: function () {
                jQuery.fn.alert_msg("星标邮件设置成功!");
            }
        })
    });
    //批量设为已读
    jQuery("#read_all").off("click").on("click", function () {
        jQuery.fn.check_msg({
            msg: "是否将选中的邮件标记为已读邮件?",
            success: function () {
                jQuery.fn.alert_msg("邮件标记成功!");
            }
        })
    });
    //批量删除
    jQuery("#del_all").off("click").on("click", function () {
        jQuery.fn.check_msg({
            msg: "是否将选中的邮件移入垃圾箱?",
            success: function () {
                jQuery.fn.alert_msg("邮件删除成功!");
            }
        });
    });
    //上一封
    jQuery("#prev_mail").off("click").on("click", function () {

    });
    //下一封
    jQuery("#next_mail").off("click").on("click", function () {

    });

</script>
