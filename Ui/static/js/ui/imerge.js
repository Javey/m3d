$(function() {
    // $.param反函数
    $.deparam = function(str) {
        var ret = {};
        if (typeof str === 'string') {
            str = str.split('&');
            $.each(str, function(index, value) {
                value = value.split('=');
                ret[value[0]] = value[1];
            });
        }
        return ret;
    };

    var global = {};

    (function() {
        var searchObj = $.deparam(location.search.substring(1));
        global.site = searchObj.site || '';
        global.module = searchObj.module || '';
    })();

    var $aside = $('aside'),
        $window = $(window),
        top = 100,

        positionAside = function() {
            if ($window.scrollTop() >= top) {
                $aside.css({
                    position: 'fixed',
                    top: 0
                });
            } else {
                $aside.css({
                    position: 'absolute',
                    top: top
                });
            }
        };

    $window.on('scroll', function() {
        positionAside();
    });

    positionAside();

    // 添加小图
    var $newImage = $('#new_image');
    $newImage.on('input', function() {
        var data = {
            key: $newImage.val()
        };
        data = $.extend(data, global);
        $.getJSON('/imerge/hint?' + $.param(data), function(res) {
            console.log(res);
        });
        console.log($newImage.val());
    });
});