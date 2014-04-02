define(['lodash', 'angular'], function(_) {
    return ['$scope', 'site', 'module', 'notify', 'terminal', '$modal', function($scope, site, module, notify, terminal, $modal) {
        // 数据缓存
        var cache = {};
        $scope.info = null;
//        $scope.allModulesInfo = null;
        $scope.editable = false; // 是否处于编辑状态

        var info;

        $scope.$on('change:site', function(e, name) {
            if (name) {
                if (cache[name]) {
                    $scope.info = cache[name];
                } else {
                    info = site.read({name: name}, function(res) {
                        cache[name] = res.data;
                        $scope.info = cache[name];
                    });
                }
            }
        });

        $scope.test = function() {
            console.log('good');
//            $scope.info.id = 1000;
            console.log($scope.info);
        };

        function save() {
            site.update($scope.info, function(res) {
                if (res.errorCode === 200) {
                    notify.open({
                        template: $scope.info.name + '环境已更新'
                    });
                } else {
                    notify.open({
                        template: $scope.info.name + '环境更新失败<br />错误信息：' + (res.data || 'Nothing'),
                        type: 'error',
                        sticky: true
                    });
                }
            });
        }

        $scope.save = function() {
            $scope.editable = false;
            var modules = [];
            angular.forEach($scope.info.modules, function(value) {
                if (!value.isOther) {
                    modules.push(value);
                }
            });
            $scope.info.modules = modules;
            save();
        };

        /**
         * 更新配置，用于添加模块等操作后，重建环境
         */
        $scope.refresh = function() {
            var info = angular.copy($scope.info);
            var modules = [];
            angular.forEach(info.modules, function(value) {
                if (!value.isOther) {
                    modules.push(value);
                }
            });
            info.modules = modules;
            site.refreshSite(info, function(res) {
                if (res.errorCode === 200) {
                    notify.open({
                        template: $scope.info.name + '环境重建成功！'
                    });
                } else {
                    notify.open({
                        template: $scope.info.name + '环境重建失败<br />错误信息：' + (res.data || 'Nothing'),
                        type: 'error',
                        sticky: true
                    });
                }
            });
        };

        $scope.delete = function(id) {
            var module = _.find($scope.info.modules, function(module) {
                return module.id === id;
            });
            module.isOther = true;
        };

        $scope.add = function(id) {
            console.log(id);
            console.log($scope.info);
            var module = _.find($scope.info.modules, function(module) {
                return module.id === id;
            });
            module.isOther = false;
            console.log($scope.info);
        };

        $scope.edit = function() {
            $scope.editable = true;
//            if (!$scope.allModulesInfo) {
                module.readAll(function(res) {
//                    $scope.allModulesInfo = res.data;
                    modifySite(res.data);
                });
//            } else {
//                modifySite();
//            }
        };

        $scope.compile = function(mod) {
            var isIncre = confirm('是否进行增量编译');
            var ter = terminal.open({
                title: '编译'
            });
            module.compile({
                site: $scope.info.name,
                module: mod,
                isIncre: isIncre
            }, function(res) {
                if (res.errorCode === 200) {
                    if (res.log) {
                        ter.write(res.data);
                    } else {
                        notify.open({
                            template: '编译完成<br />' + res.data
                        });
                    }
                } else {
                    var template = '编译终止<br />' + res.data;
                    if (res.errorCode === 400) {
                        template += '<br />请将该<a href="/admin/m3d" title="m3d.php配置文件" target="_blank"> 配置文件 </a>进行相应配置后，放入源码根目录并命名为"m3d.php"';
                    }
                    notify.open({
                        template: template,
                        type: 'error',
                        sticky: true
                    });
                }
            });
        };

        $scope.toTest = function(modId) {
            var rdModule = _.find($scope.info.modules, function(module) {
                    return !module.fe;
                }),
                feModule = _.find($scope.info.modules, function(module) {
                    return module.id === modId;
                });
            require(['controller/toTestCtrl'], function(ctrl) {
                $modal.open({
                    templateUrl: '/static/html/toTest.html',
                    controller: ctrl,
                    backdrop: 'static',
                    windowClass: 'to-test',
                    resolve: {
                        mod: function() {
                            return {
                                rd: rdModule,
                                fe: feModule
                            };
                        }
                    }
                });
            });
        };

        $scope.$on('branchList:change', function() {
            // 如果处于编辑状态，则不立即保存
            if (!$scope.editable) {
                save();
            }
        });

        $scope.$on('module:add', function() {
            $scope.allModulesInfo = null;
        });

        function modifySite(modules) {
            var modulesObj = {},
                otherModules = [];
            angular.forEach($scope.info.modules, function(value) {
                modulesObj[value.id] = true;
            });
            angular.forEach(modules, function(value) {
                if (!modulesObj[value.id]) {
                    value.branch = 'trunk';
                    value.isOther = true;
                    otherModules.push(value);
                }
            });
            $scope.info.modules = $scope.info.modules.concat(otherModules);
        }
    }];
});