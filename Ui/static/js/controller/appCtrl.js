/**
 * Created with JetBrains PhpStorm.
 * User: zoujiawei
 * Date: 13-12-10
 * Time: 下午3:15
 * To change this template use File | Settings | File Templates.
 */

define(['angular'], function() {
    return ['$scope', 'project', function($scope, project) {
        project.read(function(res) {
            $scope.projectInfo = res.data;
        });
    }];
});