/**
 * Created with JetBrains PhpStorm.
 * Description: 展示svn分支列表
 * User: zoujiawei
 * Date: 13-12-18
 * Time: 上午11:52
 * To change this template use File | Settings | File Templates.
 */

define(['lodash', 'angular'], function(_) {
    return ['module', 'filterFilter', '$timeout', '$parse', function(module, filter, $timeout, $parse) {
        return {
            templateUrl: '/static/html/branchlist.html',
            scope: {
                module: '='
            },
            link: function($scope, $elem, $attrs) {
                $scope.cacheBranch = $scope.module.branch;
                $scope.list = null;
                $scope.show = false;
                $scope.filterList = null;

                // 设置列表位置
                var inputDom = $elem.find('input'),
                    listDom = $elem.find('ul');

                listDom.css({
                    top: inputDom.position().top + inputDom.height()
                });

                $scope.focus = function(e) {
                    if (!$scope.list) {
                        module.read({id: $scope.module.id}, function(res) {
                            // 清空数据，让其显示所有可选项
                            $scope.module.branch = '';
                            $scope.list = res.data;
                            $scope.filterList = $scope.list;
                            $scope.show = true;
                        });
                    } else {
                        // 清空数据，让其显示所有可选项
                        $scope.module.branch = '';
                        $scope.show = true;
                    }
                    // 通知ctrl，该input已被污染
                    $scope.$emit('branchList:dirty', $scope.module.id);
                };

                $scope.blur = function() {
                    $scope.show = false;
                    if (!$scope.module.branch) {
                        $scope.module.branch = $scope.cacheBranch;
                    } else if (!_.indexOf($scope.list, $scope.module.branch) > -1) {
                        $scope.module.branch = $scope.filterList[0] || $scope.list[0];
                        $scope.cacheBranch = $scope.module.branch;
                    }
                };

                $scope.select = function(branch) {
                    $scope.module.branch = branch;
                };

                $scope.$watch('module.branch', function(newValue) {
                    $scope.filterList = filter($scope.list, newValue);
                });

                $scope.smartSelect = function($event) {
                    // $root$scope:inprog: $apply already in progress error.
                    // http://stackoverflow.com/questions/18389527/angularjs-submit-on-blur-and-blur-on-keypress
                    if ($event.keyCode === 13) {
                        $timeout(function() {$event.target.blur();}, 0);
                    }
                };

                $scope.$watch('cacheBranch', function (newValue, oldValue) {
                    if (newValue !== oldValue) {
                        $scope.$emit('branchList:change', $scope.module.id, newValue, oldValue);
                    }
                });

                /**
                 * 新增了分支
                 */
                $scope.$on('add:branch', function(e, moduleId) {
                    if (moduleId && moduleId === $scope.module.id) {
                        console.log('update');
                        $scope.list = null;
                    }
                });
            }
        }
    }];
});