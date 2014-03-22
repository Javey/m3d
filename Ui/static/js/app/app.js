define([
    'angular',
    'app/route',
    'angularUi',
    'angularResource',
    'angularRoute',
    'notify',
    'terminal',
    'service/service',
    'controller/controller',
    'directive/directive'
], function(angular, route) {
    return angular.module('m3d', [
        'm3d.service',
        'm3d.controller',
        'm3d.directive',
        'ngResource',
        'ngRoute',
        'ui.bootstrap',
        'm3d.notify',
        'm3d.terminal'
    ])
        .config(['$httpProvider', function(provider) {
            provider.defaults.headers.post['Content-Type'] = 'application/x-www-form-urlencoded; charset=UTF-8';
            provider.defaults.transformRequest = function(data) {
                if (angular.isObject(data)) {
                    return $.param(data);
                }
                return data;
            }
        }])
        .config(route)
        // basename
        .filter('basename', function() {
            return function(input) {
                return input ? input.split('/').reverse()[0] : input;
            }
        });
});