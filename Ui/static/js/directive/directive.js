define(['angular', 'directive/directiveConfig'], function(angular, config) {
    var module = angular.module('m3d.directive', []);

    angular.forEach(config, function(value) {
        require([value], function(directive) {
            var name = value.split('/').pop().slice(0, -9);
            module.directive(name, directive);
        });
    });

    return module;
});