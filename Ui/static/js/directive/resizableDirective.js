/**
 * Created with JetBrains PhpStorm. 调整宽高
 * User: zoujiawei
 * Date: 14-2-19
 * Time: 下午6:14
 * To change this template use File | Settings | File Templates.
 */

define(['angular'], function(angular) {
    return function() {
        return {
            restrict: 'EA',
            link: function(scope, elem, attrs) {
                var dragDom = $('<div class="drag-line"></div>');
                elem.prepend(dragDom);

                var initY = 0,
                    resizing = false,
                    maxHeight = 0,
                    $body = $('body');

                dragDom.on('mousedown', function(e) {
                    e.preventDefault();
                    initY = e.clientY;
                    resizing = true;
                    maxHeight = $body.height();

                    $(document)
                        .on('mousemove', move)
                        .on('mouseup', mouseup);
                });

                function move(e) {
                    if (resizing) {
                        var delY = e.clientY - initY,
                            height = elem.height() - delY;

                        height = height > maxHeight ? maxHeight : height;
                        height = height < 30 ? 30 : height;

                        elem.height(height);
                        initY = e.clientY;
                    }
                }

                function mouseup(e) {
                    if (resizing) {
                        resizing = false;
                        $(document)
                            .off('mousemove')
                            .off('mouseup');
                    }
                }

            }
        }
    }
});