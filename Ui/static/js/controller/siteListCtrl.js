define(['angular'], function() {
    return ['$scope', 'site', '$rootScope', 'notify', '$routeParams', '$location',
        function($scope, site, $rootScope, notify, $routeParams, $location) {
        $scope.list = [];
        $scope.curSite = null;

        $scope.updateList = function() {
            site.query(function(resource) {
                $scope.list = resource.data;
                var localSite = localStorage.getItem('curSite');
                // 是否存在list中
                if (!~_.indexOf($scope.list, localSite)) {
                    localSite = null;
                }
                $scope.curSite = $scope.curSite || $routeParams.siteName || localSite || resource.data[0];
            });
        };

        $scope.changeSite = function(name) {
            $scope.curSite = name;
        };

        $scope.$watch('curSite', function(newValue, oldValue) {
            if (newValue) {
                localStorage.setItem('curSite', newValue);
                $rootScope.$broadcast('change:site', newValue, oldValue);
            }
        });

        $scope.navClass = function(name) {
            return {
                actived: $scope.curSite === name
            };
        };

        $scope.delete = function(name) {
            site.deleteSite({name: name}, function(res) {
                if (res.errorCode === 200) {
                    var index = _.indexOf($scope.list, name);
                    $scope.list.splice(index, 1);
                    if (name === $scope.curSite) {
                        $scope.curSite = $scope.list[0];
                    }

                    notify.open({
                        template: '删除成功<br />服务器将在3s后重启'
                    });
                }
            });
        };

        $scope.updateList();

        $scope.$on('add:site', function() {
            $scope.updateList();
        });
    }];
});