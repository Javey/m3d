define(['angular'], function() {
//    return ['$scope', function($scope) {
////        var res = $resource();
//        console.log($scope);
////        return res;
//    }];
//    return function() {
        return ['$rootScope', function($scope) {
            return $scope;
        }];
//    }
});