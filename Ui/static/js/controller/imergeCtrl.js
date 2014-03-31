/**
 * Created with JetBrains PhpStorm.
 * User: zoujiawei
 * Date: 14-3-14
 * Time: 下午4:30
 * To change this template use File | Settings | File Templates.
 */

define(['angular', 'lodash'], function(angular, _) {
    return ['$scope', 'imerge', '$routeParams', 'notify', '$timeout', 'terminal', '$rootScope',
        function($scope, imerge, $routeParams, notify, $timeout, terminal, $rootScope) {
            $scope.test = 'good';
            $scope.types = null;
            $scope.images = null;
            $scope.params = $routeParams;
            $scope.curImage = {};

            function load() {
                imerge.getTypes(function(res) {
                    $scope.types = res.data;
                    $scope.curType = $routeParams.typeId || ($scope.types && $scope.types[0]);
                    imerge.getImages({type: $scope.curType}, function(res) {
                        $scope.images = res.data;
                    });
                });
            }

            load();

            $scope.select = function(image) {
                imerge.read({type: $scope.curType, image: image}, function(res) {
                    $scope.curImage.name = image;
                    $scope.curImage.attr = res.data;
                });
            };

            $scope.remove = function(image) {
                imerge.delete({type: $scope.curType, image: image}, function(res) {
                    if (res.errorCode === 200) {
                        // 从images中删除
                        index = _.indexOf($scope.images, image);
                        $scope.images.splice(index, 1);
                        // 刷新大图
                        $scope.random = new Date().getTime();
                        if (image === $scope.curImage.name) {
                            $scope.curImage = {};
                        }
                        notify.open({
                            template: '移除成功！'
                        });
                    }
                });
            };

            $scope.add = function(image) {
                imerge.create({type: $scope.curType, image: image}, function(res) {
                    if (res.errorCode === 200) {
                        $scope.images.unshift(image);
                        $scope.select(image);
                        $scope.random = new Date().getTime();
                        notify.open({
                            template: '添加成功'
                        });
                    } else {
                        notify.open({
                            template: '添加失败<br />' + res.data,
                            type: 'error',
                            sticky: true
                        });
                    }
                });
            };

            $scope.autoMerge = function() {
                var ter = terminal.open({
                    title: '自动合图'
                });
                imerge.auto(function(res) {
                    if (res.log) {
                        ter.write(res.data);
                    } else {
                        if (res.errorCode === 200) {
                            $rootScope.$broadcast('imerge:change');
                            load();
                            notify.open({
                                template: '合图完成！'
                            });
                        } else {
                            notify.open({
                                template: '合图失败!<br/>' + res.data,
                                type: 'error',
                                sticky: true
                            })
                        }
                    }
                });
            };

            $scope.test = function() {
                console.log($scope);
            };

            var timer = null;
            $scope.$watch('search', function (newValue) {
                $timeout.cancel(timer);
                timer = $timeout(function() {
                    if (newValue) {
                        imerge.hint({key: newValue}, function(res) {
                            console.log(res.data);
                            $scope.hint = res.data;
                        });
                    } else {
                        $scope.hint = null;
                    }
                }, 300);
            });

            $scope.$watch('curImage', function(newValue, oldValue) {
                if (oldValue && newValue && newValue.name && newValue.name === oldValue.name) {
                    imerge.update({type: $scope.curType, image: $scope.curImage}, function(res) {
                        if (res.errorCode === 200) {
                            // 刷新大图
                            $scope.random = new Date().getTime();
                        }
                    });
                }
            }, true);
        }
    ];
});