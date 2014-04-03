/**
 * Created with JetBrains PhpStorm.
 * User: zoujiawei
 * Date: 14-3-14
 * Time: 下午4:36
 * To change this template use File | Settings | File Templates.
 */

define(['angular', 'lib/common', 'lodash'], function(angular, common, _) {
    return ['$resource', '$routeParams', '$rootScope', function ($resource, $routeParams, $rootScope) {
        var types = null, // 缓存大图类型
            curSite = $routeParams.siteId,
            curMod = $routeParams.moduleId,
            params = {
                site: function() {
                    return $routeParams.siteId;
                },
                module: function() {
                    return $routeParams.moduleId;
                }
            };

        function getParams(obj) {
            return _.extend({}, params, obj);
        }

        var res = $resource(
            '/imerge/:resource',
            {},
            {
                _getTypes: {method: 'GET', params: getParams({resource: 'type'})},
                getImages: {method: 'GET', params: getParams({resource: 'image'})},
                read: {method: 'GET', params: getParams({resource: 'config'})},
                update: {method: 'POST', params: getParams({resource: 'config', method: 'put'})},
                delete: {method: 'POST', params: getParams({resource: 'config', method: 'delete'})},
                create: {method: 'POST', params: getParams({resource: 'config', method: 'post'})},
                hint: {method: 'GET', params: getParams({resource: 'hint'})}
            }
        );

        res.getTypes = function (callback) {
            if (types && curSite === $routeParams.siteId && curMod === $routeParams.moduleId) {
                callback({errorCode: 200, data: types});
            } else {
                curSite = $routeParams.siteId;
                curMod = $routeParams.moduleId;
                res._getTypes(function (res) {
                    callback(res);
                });
            }
        };

        $rootScope.$on('imerge:change', function () {
            types = null;
        });

        res.auto = function (loading, complete) {
            common.streamAjax({
                method: 'get',
                url: '/imerge/auto?site=' + $routeParams.siteId + '&module=' + $routeParams.moduleId,
                loading: loading,
                complete: complete
            });
        };

        return res;
    }];
});