/**
 * Created with JetBrains PhpStorm.
 * User: zoujiawei
 * Date: 14-3-17
 * Time: 下午3:45
 * To change this template use File | Settings | File Templates.
 */

define(['lodash', 'jquery'], function(_, $) {
    return {
        streamAjax : (function () {
            var defaultOptions = {
                url: '',
                data: {},
                method: 'post',
                loading: angular.noop,
                complete: angular.noop
            };
            return function(options) {
                options = $.extend({}, defaultOptions, options);
                options.method = options.method.toUpperCase();
                options.data = $.param(options.data);
                if (options.method === 'GET') {
                    options.url += (options.url.indexOf('?') > -1 ? '&' : '?') + options.data;
                    options.data = null;
                }
                var xhr = new XMLHttpRequest(),
                    prevResponse = '';
                xhr.onreadystatechange = function() {
                    if (xhr.readyState === 3) {
                        var newResponse = xhr.responseText.substring(prevResponse.length);
                        prevResponse = xhr.responseText;
                        newResponse = newResponse.split('EOF');
                        _.each(newResponse, function(value) {
                            if (value) {
                                console.log(value);
                                value = $.parseJSON(value);
                                options.loading(value);
                            }
                        });
                    } else if (xhr.readyState === 4) {
                        options.complete(prevResponse);
                    }
                };
                xhr.open(options.method.toUpperCase(), options.url, true);
                xhr.setRequestHeader("Content-type","application/x-www-form-urlencoded");
                xhr.send(options.data);
            };
        })(),

        /**
         * 手动验证表单
         * @param $scope
         * @param ngForm
         * @returns {boolean}
         */
        validateForm: function($scope, ngForm) {
            if (ngForm.$valid) {
                return true;
            } else {
                ngForm.$dirty = true;
                for (var i in ngForm) {
                    if (ngForm[i] && ngForm[i].hasOwnProperty && ngForm[i].hasOwnProperty('$dirty')) {
                        ngForm[i].$setDirty();
                    }
                }
            }
            return true;
        }
    };
});