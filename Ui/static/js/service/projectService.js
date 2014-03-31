define(['angular'], function() {
    return ['$resource', function($resource) {
        var info = null;
        var res = $resource(
            '/project/:type',
            {},
            {
                _read: {method: 'GET', params: {type: 'info', method: 'get'}}
//                update: {method: 'POST', params: {type: 'info', method: 'put'}},
//                create: {method: 'POST', params: {type: 'info', method: 'post'}},
//                delete: {method: 'POST', params: {type: 'info', method: 'delete'}}
            }
        );

        res.read = function(callback) {
            if (info) {
                callback({data:info});
            } else {
                res._read(function(res) {
                    info = res.data;
                    callback(res);
                });
            }
        };

        return res;
    }];
});