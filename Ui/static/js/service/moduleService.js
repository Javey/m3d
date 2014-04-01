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
                    delete: {method: 'POST', params: {method: 'delete'}},
                    test: {method: 'POST', params: {type: 'test', method: 'post'}}
                }
            );

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