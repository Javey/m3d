/**
 * Created with JetBrains PhpStorm.
 * User: zoujiawei
 * Date: 13-12-10
 * Time: 下午2:48
 * To change this template use File | Settings | File Templates.
 */

require.config({
    baseUrl: '/static/js',
    paths: {
        jquery: 'lib/jquery',
        angular: 'lib/angular-min',
        angularResource: 'lib/angular-resource',
        angularUi: 'lib/angular-ui',
        angularRoute: 'lib/angular-route',
        notify: 'lib/notify',
        terminal: 'lib/terminal',
        lodash: 'lib/lodash'
    },
    shim: {
        angular: {
            deps: ['jquery'],
            exports: 'angular'
        },
        angularUi: {
            deps: ['angular']
        },
        angularResource: {
            deps: ['angular']
        },
        angularRoute: {
            deps: ['angular']
        },
        notify: {
            deps: ['angular']
        },
        terminal: {
            deps: ['angular']
        }
    }
//    urlArgs: 'v=' + (new Date()).getTime() // debug
});

require([
    'lodash',
    'angular',
    'app/app',
    'directive/directiveConfig',
    'service/serviceConfig',
    'controller/controllerConfig'
], function( _, angular, app, directiveConfig, serviceConfig, controllerConfig) {
    require(_.union(directiveConfig, serviceConfig, controllerConfig), function() {
        angular.bootstrap(document, ['m3d']);
    });
});
