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
</div>


</div><!-- pull-right -->

<div class="btn-group mr10">
    <button class="btn btn-sm btn-white" title="上一封" type="button"><i
            class="glyphicon glyphicon-chevron-left" id="prev_mail"></i></button>
    <button class="btn btn-sm btn-white" title="下一封" type="button"><i
            class="glyphicon glyphicon-chevron-right" id="next_mail"></i></button>
</div>

<div class="read-panel">

    <div class="media">
        <a href="#" class="pull-left">
            <img alt="" src="/assets/images/photos/user2.png" class="media-object">
        </a>
        <div class="media-body">
            <span class="media-meta pull-right">{{send_time}}</span>
            <h4 class="text-primary">{{sender.name}}</h4>
            <small class="text-muted">来自:{{sender.department.name}} / {{sender.role.name}}</small>
        </div>
    </div><!-- media -->

    <h4 class="email-subject">{{title}}</h4>

    {{{content}}}

    <br/>

    <div class="media">
        <a href="#" class="pull-left">
            <img alt="" src="/assets/images/photos/user2.png" class="media-object">
        </a>
        <div class="media-body">
            <textarea class="form-control" placeholder="Reply here..."></textarea>
        </div>
    </div><!-- media -->

</div><!-- read-panel -->