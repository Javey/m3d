/**
 * Created with JetBrains PhpStorm.
 * User: zoujiawei
 * Date: 14-3-14
 * Time: 下午3:42
 * To change this template use File | Settings | File Templates.
 */

define(['angular', 'angularRoute'], function(angular) {
    return ['$routeProvider', '$locationProvider', function($routeProvider, $locationProvider) {
        $routeProvider
//            .when('/', {
//                templateUrl: '/static/html/index.html'
////                resolve: {
////                    delay: function($q, $timeout) {
////                        var delay = $q.defer();
////                        $timeout(delay.resolve, 1000);
////                        return delay.promise;
////                    }
////                }
//            })
            .when('/imerge/:siteId/:moduleId/:typeId?', {
                templateUrl: '/static/html/imerge.html',
                controller: 'ImergeCtrl'
            })
            .when('/:siteName?', {
                templateUrl: '/static/html/index.html'
//                reloadOnSearch: false
            })
            .otherwise({
                redirectTo: '/'
            });

//        $locationProvider.html5Mode(true);
    }];
});