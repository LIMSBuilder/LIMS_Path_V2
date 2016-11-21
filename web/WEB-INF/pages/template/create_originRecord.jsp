<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="shortcut icon" href="/assets/images/favicon.png" type="image/png">
    <title>实验室信息管理系统</title>

    <link href="/assets/css/style.default.css" rel="stylesheet">
</head>
<body>
<div class="panel panel-default">
    <div class="panel-heading">
        <div class="panel-btns">
            <a href="" class="panel-close">×</a>
            <a href="" class="minimize">−</a>
        </div>
        <h4 class="panel-title">Input Fields</h4>
        <p>Individual form controls automatically receive some global styling. All textual elements with <code>.form-control</code>
            are set to width: 100%; by default. Wrap labels and controls in <code>.form-group</code> for optimum
            spacing.</p>
    </div>
    <div class="panel-body panel-body-nopadding">
        <form class="form-horizontal form-bordered">
            <div class="form-group">
                <label class="col-sm-3 control-label">Default Input</label>
                <div class="col-sm-6">
                    <select class="select2" data-placeholder="Choose a Country...">
                        <option value=""></option>
                        <option value="United States">United States</option>
                        <option value="United Kingdom">United Kingdom</option>
                        <option value="Afghanistan">Afghanistan</option>
                        <option value="Aland Islands">Aland Islands</option>
                        <option value="Albania">Albania</option>
                        <option value="Algeria">Algeria</option>
                        <option value="American Samoa">American Samoa</option>
                        <option value="Andorra">Andorra</option>
                    </select>
                </div>
            </div>
        </form>
    </div><!-- panel-body -->
    <div class="panel-footer">
        <div class="row">
            <div class="col-sm-6 col-sm-offset-3">
                <button class="btn btn-primary">Submit</button>
                &nbsp;
                <button class="btn btn-default">Cancel</button>
            </div>
        </div>
    </div><!-- panel-footer -->

</div>

<script type="text/javascript">
    jQuery(document).ready(function () {
        // Select2
        jQuery(".select2").select2({
            width: '100%'
        });
    });
</script>
</body>
</html>
