define(['angular', 'controller/controllerConfig'], function(angular, config) {
    var module = angular.module('m3d.controller', []);

    angular.forEach(config, function(value) {
        require([value], function(controller) {
            var name = value.split('/').pop();
            name = name.substring(0, 1).toUpperCase() + name.substr(1);
            module.controller(name, controller);
        });
    });

    return module;
});