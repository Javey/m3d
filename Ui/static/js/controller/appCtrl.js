/**
 * Created with JetBrains PhpStorm.
 * User: zoujiawei
 * Date: 13-12-10
 * Time: 下午3:15
 * To change this template use File | Settings | File Templates.
 */

define(['angular'], function() {
    return ['$scope', 'project', '$rootScope', function($scope, project, $rootScope) {
        project.read(function(res) {
            $rootScope.projectInfo = res.data;
        });
    }];
});