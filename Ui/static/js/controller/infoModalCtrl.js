/**
 * Created with JetBrains PhpStorm.
 * User: zoujiawei
 * Date: 14-4-3
 * Time: 下午4:14
 * To change this template use File | Settings | File Templates.
 */

define(function() {
    return ['$scope', '$modalInstance', 'modalData', function($scope, $modal, data) {
        $scope.data = data;

        $scope.cancel = function() {
            $modal.close(0);
        };

        $scope.ok = function() {
            $modal.close(1);
        };

        $scope.dismiss = function() {
            $modal.dismiss();
        }
    }];
});