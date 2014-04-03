/**
 * Created with JetBrains PhpStorm.
 * User: zoujiawei
 * Date: 14-4-3
 * Time: 下午5:38
 * To change this template use File | Settings | File Templates.
 */

define(['jquery'], function($) {
    return function() {
        return function(scope, element, attrs) {
            var img = element.find('img'),
                loading = $('<div class="loading"></div>').appendTo(element);
            img.hide();
            img.on('load', function() {
                loading.hide();
                img.show();
            });
        }
    };
});