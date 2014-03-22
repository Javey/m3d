/**
 * Created with JetBrains PhpStorm.
 * User: zoujiawei
 * Date: 13-12-17
 * Time: 下午7:46
 * To change this template use File | Settings | File Templates.
 */
define(['lodash', 'lib/common', 'angular'], function(_, common) {
    return ['$resource', '$rootScope', function($resource, $rootScope) {
        var modules = null, // 缓存modules，因为使用比较频繁

            res = $resource(
                '/module/:type',
                {},
                {
                    read: {method: 'GET', params: {type: 'branches'}},
                    _readAll: {method: 'GET', params: {method: 'get'}},
                    add: {method: 'POST', params: {method: 'put'}},
                    delete: {method: 'POST', params: {method: 'delete'}}
                }
            );

//        var streamAjax = (function () {
//            var defaultOptions = {
//                url: '',
//                data: {},
//                method: 'post',
//                loading: angular.noop,
//                complete: angular.noop
//            };
//            return function(options) {
//                options = $.extend(defaultOptions, options);
//                options.method = options.method.toUpperCase();
//                options.data = $.param(options.data);
//                if (options.method === 'GET') {
//                    options.url += (options.url.indexOf('?') > -1 ? '&' : '?') + options.data;
//                    options.data = null;
//                }
//                var xhr = new XMLHttpRequest(),
//                    prevResponse = '';
//                xhr.onreadystatechange = function() {
//                    if (xhr.readyState === 3) {
//                        var newResponse = xhr.responseText.substring(prevResponse.length);
//                        prevResponse = xhr.responseText;
//                        newResponse = newResponse.split('EOF');
//                        _.each(newResponse, function(value) {
//                            if (value) {
//                                console.log(value);
//                                value = $.parseJSON(value);
//                                options.loading(value);
//                            }
//                        });
//                    } else if (xhr.readyState === 4) {
//                        options.complete(prevResponse);
//                    }
//                };
//                xhr.open(options.method.toUpperCase(), options.url, true);
//                xhr.setRequestHeader("Content-type","application/x-www-form-urlencoded");
//                xhr.send(options.data);
//            };
//        })();

        res.readAll = function(callback) {
            if (modules) {
                callback({data: modules});
            } else {
                res._readAll(function(res) {
                    modules = res.data;
                    callback(res);
                });
            }
        };
        $rootScope.$on('module:change', function() {
            modules = null;
        });

        res.checkout = function(data, loading, complete) {
            common.streamAjax({
                data: data,
                url: '/module/branches?method=post',
                loading: loading,
                complete: complete
            });
        };

        res.compile = function(data, loading, complete) {
            common.streamAjax({
                method: 'get',
                data: data,
                url: '/process',
                loading: loading,
                complete: complete
            })
        };

        return res;
    }];
});