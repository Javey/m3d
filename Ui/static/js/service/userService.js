/**
 * Created with JetBrains PhpStorm.
 * User: zoujiawei
 * Date: 14-4-1
 * Time: 下午4:30
 * To change this template use File | Settings | File Templates.
 */

define(['angular'], function(angular) {
    return ['$resource', function($resource) {
        var info = null;
        var res = $resource(
            '/user/:type',
            {},
            {
                _read: {method: 'GET', params: {method: 'get'}},
//                update: {method: 'POST', params: {type: 'info', method: 'put'}},
                create: {method: 'POST', params: {method: 'post'}},
                delete: {method: 'POST', params: {method: 'delete'}}
            }
        );

        res.read = function(callback) {
            if (info) {
                callback({data:info});
            } else {
                info = {
                    to: [],
                    from: []
                };
                res._read(function(res) {
                    var data = res.data;
                    angular.forEach(data, function(user) {
                        info[user.type || 'to'].push(user);
                    });
                    callback({data:info});
                });
            }
        };

        return res;
    }];
});
