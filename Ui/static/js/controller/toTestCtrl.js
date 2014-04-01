/**
 * Created with JetBrains PhpStorm.
 * User: zoujiawei
 * Date: 14-4-1
 * Time: 下午4:12
 * To change this template use File | Settings | File Templates.
 */

define(['lib/common'], function(common) {
    return ['$scope', '$modalInstance', 'mod', 'user', 'notify', 'module', function($scope, $modal, mod, user, notify, module) {
        $scope.users = null;
        $scope.info = {
            to: '',
            from: '',
            modules: mod
        };
        $scope.to = null;
        $scope.from = null;

        user.read(function(res) {
            $scope.users = res.data;
        });

        $scope.cancel = function() {
            $modal.close();
        };

        $scope.addUser = function(user, type) {
            toArray = $scope.info[type] || '';
            toArray = toArray.split(';');
            toArray.pop();
            if (_.lastIndexOf(toArray, user.email) < 0) {
                toArray.push(user.email);
            }
            $scope.info[type] = toArray.join(',') + ',';
        };

        $scope.ok = function() {
            common.validateForm($scope, $scope.form);
            if ($scope.form.$valid) {
                module.test($scope.info, function(res) {
                    if (res.errorCode === 200) {
                        $modal.close();
                        notify.open({
                            template: '提测成功！'
                        });
                    } else {
                        notify.open({
                            template: '发送邮件出现错误！',
                            type: 'error',
                            sticky: true
                        });
                    }
                    console.log(res);
                });
            }
        };

        $scope.$watch('info.to', function (newValue) {
            if (newValue) {
                $scope.to = newValue.split(',').pop();
            }
        }, true);
        $scope.$watch('info.from', function (newValue) {
            if (newValue) {
                $scope.from = newValue.split(',').pop();
            }
        }, true);

        $scope.test = function() {
            console.log($scope);
        }
    }];
});