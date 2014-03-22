/**
 * Created with JetBrains PhpStorm.
 * User: zoujiawei
 * Date: 13-12-12
 * Time: 下午5:38
 * To change this template use File | Settings | File Templates.
 */

define(['angular'], function() {
    return ['$resource', function($resource) {
        var res = $resource(
            '/site/:type',
            {},
            {
                query: {method: 'GET', params: {type: 'name'}},
                addSite: {method: 'POST', params: {type: 'name', method: 'post'}},
                deleteSite: {method: 'POST', params: {type: 'name', method: 'delete'}},
                refreshSite: {method: 'POST', params: {type: 'name', method: 'put'}},
                read: {method: 'GET', params: {type: 'info', method: 'get'}, cache: false},
                update: {method: 'POST', params: {type: 'info', method: 'put'}},
                create: {method: 'POST', params: {type: 'info', method: 'post'}},
                delete: {method: 'POST', params: {type: 'info', method: 'delete'}}
            }
        );

        return res;
    }];
});