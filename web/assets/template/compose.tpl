<div class="panel-body">

    <div class="form-group">
        <input type="text" name="subject" placeholder="联系人 / 后续待补充一个选择器" class="form-control"/>
    </div>
    <div class="form-group">
        <input type="text" name="subject" placeholder="邮件主题" class="form-control"/>
    </div>

    <textarea id="wysiwyg" placeholder="Your message here..." class="form-control" rows="20"></textarea>

</div><!-- panel-body -->
<div class="panel-footer">
    <button class="btn btn-primary">发 送</button>
</div>

<script src="/assets/js/chosen.jquery.min.js"></script>
<script src="/assets/js/wysihtml5-0.3.0.min.js"></script>
<script src="/assets/js/bootstrap-wysihtml5.js"></script>

<script>
    require("jquery");
    jQuery(document).ready(function () {

        "use strict";
        // Chosen Select
        jQuery(".chosen-select").chosen({'width': '100%', 'white-space': 'nowrap'});
    });

    jQuery('#acc').click(function () {
        jQuery('#cc').show();
        jQuery(this).hide();
        return false;
    });

    jQuery('#abcc').click(function () {
        jQuery('#bcc').show();
        jQuery(this).hide();
        return false;
    });

    // HTML5 WYSIWYG Editor
    jQuery('#wysiwyg').wysihtml5({color: true, html: true});

</script>