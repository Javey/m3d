define(['angular', 'service/serviceConfig'], function(angular, config) {
    var module = angular.module('m3d.service', []);

    angular.forEach(config, function(value) {
        require([value], function(service) {
            var name = value.split('/').pop().slice(0, -7);
            module.factory(name, service);
        });
    });

    return module;
});