﻿jQuery(window).load(function () {

    "use strict";

    // Page Preloader
    jQuery('#preloader').delay(350).fadeOut(function () {
        jQuery('body').delay(350).css({'overflow': 'visible'});
    });
});

jQuery(document).ready(function () {

    "use strict";
    var LIMS = window.LIMS = {};


    // Toggle Left Menu
    jQuery('.leftpanel .nav-parent > a').live('click', function () {

        var parent = jQuery(this).parent();
        var sub = parent.find('> ul');

        // Dropdown works only when leftpanel is not collapsed
        if (!jQuery('body').hasClass('leftpanel-collapsed')) {
            if (sub.is(':visible')) {
                sub.slideUp(200, function () {
                    parent.removeClass('nav-active');
                    jQuery('.mainpanel').css({height: ''});
                    adjustmainpanelheight();
                });
            } else {
                closeVisibleSubMenu();
                parent.addClass('nav-active');
                sub.slideDown(200, function () {
                    adjustmainpanelheight();
                });
            }
        }
        return false;
    });

    function closeVisibleSubMenu() {
        jQuery('.leftpanel .nav-parent').each(function () {
            var t = jQuery(this);
            if (t.hasClass('nav-active')) {
                t.find('> ul').slideUp(200, function () {
                    t.removeClass('nav-active');
                });
            }
        });
    }

    function adjustmainpanelheight() {
        // Adjust mainpanel height
        var docHeight = jQuery(document).height();
        if (docHeight > jQuery('.mainpanel').height())
            jQuery('.mainpanel').height(docHeight);
    }

    window.adjustmainpanelheight = adjustmainpanelheight;

    adjustmainpanelheight();


    // Tooltip
    jQuery('.tooltips').tooltip({container: 'body'});

    // Popover
    jQuery('.popovers').popover();

    // Close Button in Panels
    jQuery('.panel .panel-close').click(function () {
        jQuery(this).closest('.panel').fadeOut(200);
        return false;
    });

    // Form Toggles
    jQuery('.toggle').toggles({on: true});

    jQuery('.toggle-chat1').toggles({on: false});

    var scColor1 = '#428BCA';
    if (jQuery.cookie('change-skin') && jQuery.cookie('change-skin') == 'bluenav') {
        scColor1 = '#fff';
    }


    // Sparkline
    jQuery('#sidebar-chart').sparkline([4, 3, 3, 1, 4, 3, 2, 2, 3, 10, 9, 6], {
        type: 'bar',
        height: '30px',
        barColor: scColor1
    });

    jQuery('#sidebar-chart2').sparkline([1, 3, 4, 5, 4, 10, 8, 5, 7, 6, 9, 3], {
        type: 'bar',
        height: '30px',
        barColor: '#D9534F'
    });

    jQuery('#sidebar-chart3').sparkline([5, 9, 3, 8, 4, 10, 8, 5, 7, 6, 9, 3], {
        type: 'bar',
        height: '30px',
        barColor: '#1CAF9A'
    });

    jQuery('#sidebar-chart4').sparkline([4, 3, 3, 1, 4, 3, 2, 2, 3, 10, 9, 6], {
        type: 'bar',
        height: '30px',
        barColor: scColor1
    });

    jQuery('#sidebar-chart5').sparkline([1, 3, 4, 5, 4, 10, 8, 5, 7, 6, 9, 3], {
        type: 'bar',
        height: '30px',
        barColor: '#F0AD4E'
    });


    // Minimize Button in Panels
    jQuery('.minimize').click(function () {
        var t = jQuery(this);
        var p = t.closest('.panel');
        if (!jQuery(this).hasClass('maximize')) {
            p.find('.panel-body, .panel-footer').slideUp(200);
            t.addClass('maximize');
            t.html('&plus;');
        } else {
            p.find('.panel-body, .panel-footer').slideDown(200);
            t.removeClass('maximize');
            t.html('&minus;');
        }
        return false;
    });


    // Add class everytime a mouse pointer hover over it
    jQuery('.nav-bracket > li').hover(function () {
        jQuery(this).addClass('nav-hover');
    }, function () {
        jQuery(this).removeClass('nav-hover');
    });


    // Menu Toggle
    jQuery('.menutoggle').click(function () {

        var body = jQuery('body');
        var bodypos = body.css('position');

        if (bodypos != 'relative') {

            if (!body.hasClass('leftpanel-collapsed')) {
                body.addClass('leftpanel-collapsed');
                jQuery('.nav-bracket ul').attr('style', '');

                jQuery(this).addClass('menu-collapsed');

            } else {
                body.removeClass('leftpanel-collapsed chat-view');
                jQuery('.nav-bracket li.active ul').css({display: 'block'});

                jQuery(this).removeClass('menu-collapsed');

            }
        } else {

            if (body.hasClass('leftpanel-show'))
                body.removeClass('leftpanel-show');
            else
                body.addClass('leftpanel-show');

            adjustmainpanelheight();
        }

    });

    // Chat View
    jQuery('#chatview').click(function () {

        var body = jQuery('body');
        var bodypos = body.css('position');

        if (bodypos != 'relative') {

            if (!body.hasClass('chat-view')) {
                body.addClass('leftpanel-collapsed chat-view');
                jQuery('.nav-bracket ul').attr('style', '');

            } else {

                body.removeClass('chat-view');

                if (!jQuery('.menutoggle').hasClass('menu-collapsed')) {
                    jQuery('body').removeClass('leftpanel-collapsed');
                    jQuery('.nav-bracket li.active ul').css({display: 'block'});
                } else {

                }
            }

        } else {

            if (!body.hasClass('chat-relative-view')) {

                body.addClass('chat-relative-view');
                body.css({left: ''});

            } else {
                body.removeClass('chat-relative-view');
            }
        }

    });

    reposition_topnav();
    reposition_searchform();

    jQuery(window).resize(function () {

        if (jQuery('body').css('position') == 'relative') {

            jQuery('body').removeClass('leftpanel-collapsed chat-view');

        } else {

            jQuery('body').removeClass('chat-relative-view');
            jQuery('body').css({left: '', marginRight: ''});
        }


        reposition_searchform();
        reposition_topnav();

    });


    /* This function will reposition search form to the left panel when viewed
     * in screens smaller than 767px and will return to top when viewed higher
     * than 767px
     */
    function reposition_searchform() {
        if (jQuery('.searchform').css('position') == 'relative') {
            jQuery('.searchform').insertBefore('.leftpanelinner .userlogged');
        } else {
            jQuery('.searchform').insertBefore('.header-right');
        }
    }


    /* This function allows top navigation menu to move to left navigation menu
     * when viewed in screens lower than 1024px and will move it back when viewed
     * higher than 1024px
     */
    function reposition_topnav() {
        if (jQuery('.nav-horizontal').length > 0) {

            // top navigation move to left nav
            // .nav-horizontal will set position to relative when viewed in screen below 1024
            if (jQuery('.nav-horizontal').css('position') == 'relative') {

                if (jQuery('.leftpanel .nav-bracket').length == 2) {
                    jQuery('.nav-horizontal').insertAfter('.nav-bracket:eq(1)');
                } else {
                    // only add to bottom if .nav-horizontal is not yet in the left panel
                    if (jQuery('.leftpanel .nav-horizontal').length == 0)
                        jQuery('.nav-horizontal').appendTo('.leftpanelinner');
                }

                jQuery('.nav-horizontal').css({display: 'block'})
                    .addClass('nav-pills nav-stacked nav-bracket');

                jQuery('.nav-horizontal .children').removeClass('dropdown-menu');
                jQuery('.nav-horizontal > li').each(function () {

                    jQuery(this).removeClass('open');
                    jQuery(this).find('a').removeAttr('class');
                    jQuery(this).find('a').removeAttr('data-toggle');

                });

                if (jQuery('.nav-horizontal li:last-child').has('form')) {
                    jQuery('.nav-horizontal li:last-child form').addClass('searchform').appendTo('.topnav');
                    jQuery('.nav-horizontal li:last-child').hide();
                }

            } else {
                // move nav only when .nav-horizontal is currently from leftpanel
                // that is viewed from screen size above 1024
                if (jQuery('.leftpanel .nav-horizontal').length > 0) {

                    jQuery('.nav-horizontal').removeClass('nav-pills nav-stacked nav-bracket')
                        .appendTo('.topnav');
                    jQuery('.nav-horizontal .children').addClass('dropdown-menu').removeAttr('style');
                    jQuery('.nav-horizontal li:last-child').show();
                    jQuery('.searchform').removeClass('searchform').appendTo('.nav-horizontal li:last-child .dropdown-menu');
                    jQuery('.nav-horizontal > li > a').each(function () {

                        jQuery(this).parent().removeClass('nav-active');

                        if (jQuery(this).parent().find('.dropdown-menu').length > 0) {
                            jQuery(this).attr('class', 'dropdown-toggle');
                            jQuery(this).attr('data-toggle', 'dropdown');
                        }

                    });
                }

            }

        }
    }


    // Sticky Header
    if (jQuery.cookie('sticky-header'))
        jQuery('body').addClass('stickyheader');

    // Sticky Left Panel
    if (jQuery.cookie('sticky-leftpanel')) {
        jQuery('body').addClass('stickyheader');
        jQuery('.leftpanel').addClass('sticky-leftpanel');
    }

    // Left Panel Collapsed
    if (jQuery.cookie('leftpanel-collapsed')) {
        jQuery('body').addClass('leftpanel-collapsed');
        jQuery('.menutoggle').addClass('menu-collapsed');
    }

    // Changing Skin
    var c = jQuery.cookie('change-skin');
    var cssSkin = 'css/style.' + c + '.css';
    if (jQuery('body').css('direction') == 'rtl') {
        cssSkin = '../css/style.' + c + '.css';
        jQuery('html').addClass('rtl');
    }
    if (c) {
        jQuery('head').append('<link id="skinswitch" rel="stylesheet" href="' + cssSkin + '" />');
    }

    // Changing Font
    var fnt = jQuery.cookie('change-font');
    if (fnt) {
        jQuery('head').append('<link id="fontswitch" rel="stylesheet" href="css/font.' + fnt + '.css" />');
    }

    // Check if leftpanel is collapsed
    if (jQuery('body').hasClass('leftpanel-collapsed'))
        jQuery('.nav-bracket .children').css({display: ''});


    // Handles form inside of dropdown
    jQuery('.dropdown-menu').find('form').click(function (e) {
        e.stopPropagation();
    });


    // This is not actually changing color of btn-primary
    // This is like you are changing it to use btn-orange instead of btn-primary
    // This is for demo purposes only
    var c = jQuery.cookie('change-skin');
    if (c && c == 'greyjoy') {
        $('.btn-primary').removeClass('btn-primary').addClass('btn-orange');
        $('.rdio-primary').addClass('rdio-default').removeClass('rdio-primary');
        $('.text-primary').removeClass('text-primary').addClass('text-orange');
    }


    jQuery.fn.alert_msg = function (text, type) {
        jQuery.gritter.add({
            title: "执行结果",
            text: text,
            //class_name: 'growl-' + (type == 'success' ? 'success' : 'danger'),
            class_name: 'growl-success',
            image: '/assets/images/screen.png',
            sticky: false,
            time: ''
        });
        return false;
    };

    jQuery.fn.check_msg = function (opt) {
        jQuery('#msg_body').html(opt.msg);
        jQuery('#myModal').modal('show');
        jQuery('#check_true').off('click').on('click', function () {
            opt.success && opt.success();
            jQuery('#myModal').modal('hide');
        });
        jQuery("#check_false").off("click").on("click", function () {
            opt.cancel && opt.cancel();
            jQuery('#myModal').modal('hide');
        });
    };

    jQuery.fn.error_msg = function (text) {
        jQuery.gritter.add({
            title: "很抱歉",
            text: text,
            class_name: 'growl-danger',
            image: '/assets/images/screen.png',
            sticky: false,
            time: ''
        });
        return false;
    };

    jQuery.fn.select_all = function (name, type) {
        if (type == "all") {
            jQuery('[name=' + name + ']').each(function (index, oCheckbox) {
                jQuery(oCheckbox).prop('checked', true);
            });
        } else {
            jQuery('[name=' + name + ']').each(function (index, oCheckbox) {
                jQuery(oCheckbox).prop('checked', !jQuery(oCheckbox).prop('checked'));
            });
        }
    };


    jQuery.fn.loadTemplate = function (path) {
        var template = "";
        $.ajax({
            type: "GET",
            url: path,
            async: false,
            success: function (data) {
                template = data;
            }
        });
        return template;
    };
    jQuery.fn.codeState = function (code, opt) {
        if (!code) return;
        if (code == 200) {
            if (opt[200] && typeof opt[200] == "string") {
                jQuery.fn.alert_msg(opt[200]);
            } else {
                if (opt[200] && typeof opt[200] == "function") {
                    opt[200]();
                } else {
                    jQuery.fn.alert_msg('操作成功！');
                }
            }
        }
        if (code == 500) {
            if (opt[500] && typeof opt[500] == "string") {
                jQuery.fn.error_msg(opt[500]);
                return;
            } else {
                opt[500] ? opt[500]() : jQuery.fn.error_msg('服务器异常,请刷新后重新尝试！');
            }

        }
        if (code == 501) {
            if (opt[501] && typeof opt[501] == "string") {
                jQuery.fn.error_msg(opt[501]);
                return;
            } else {
                opt[501] ? opt[501]() : jQuery.fn.error_msg('数据值不能为空,请检查后重新操作！');
            }
        }
        if (code == 502) {
            if (opt[502] && typeof opt[502] == "string") {
                jQuery.fn.error_msg(opt[502]);
                return;
            }
            opt[502] ? opt[502]() : jQuery.fn.error_msg('请求异常,请重新尝试操作！');
        }
        if (code == 503) {
            if (opt[503] && typeof opt[503] == "string") {
                jQuery.fn.error_msg(opt[503]);
                return;
            }
            opt[503] ? opt[503]() : jQuery.fn.error_msg('数据库中已存在当前值,不能重复操作！');
        }
        if (code == 505) {
            if (opt[505] && typeof opt[505] == "string") {
                jQuery.fn.error_msg(opt[505]);
                return;
            }
            opt[505] ? opt[505]() : jQuery.fn.error_msg('系统不允许您注册两次！');
        }
    };


    jQuery.fn.export_contract = function (id) {
        console.log(id);
        jQuery.fn.alert_msg("导出合同功能待开发!")
    };
    jQuery.fn.export_task = function (id) {
        console.log(id);
        jQuery.fn.alert_msg("导出任务书功能待开发!")
    };
    jQuery.fn.export_sample = function (id) {
        console.log(id);
        jQuery.fn.alert_msg("导出样品清单功能待开发!")
    };
    jQuery.fn.export_delivery = function (id) {
        console.log(id);
        jQuery.fn.alert_msg("导出交接联单功能待开发!")
    };
    jQuery.fn.export_inspection = function (id) {
        console.log(id);
        jQuery.fn.alert_msg("导出送检单功能待开发!")
    };

    //执行自动调整高度,2秒执行一次 
    setInterval(function () {
        adjustmainpanelheight();
    }, 2000);
});


//// Analytics Code
//(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
//(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
//m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
//})(window,document,'script','//www.google-analytics.com/analytics.js','ga');

//ga('create', 'UA-40361841-2', 'auto');
//ga('send', 'pageview');
