define(['angular'], function() {
    return ['$scope', 'site', 'module', 'notify', 'terminal', function($scope, site, module, notify, terminal) {
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
                        type: 'error'
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
                        type: 'error'
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
            var ter = terminal.open({
                title: '编译'
            });
            module.compile({
                site: $scope.info.name,
                module: mod
            }, function(res) {
                if (res.log) {
                    ter.write(res.data);
                } else {
//                    console.log(res);
                    notify.open({
                        template: '编译完成<br />' + res.data
                    });
                }
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