define(function() {
    return function() {
        return {
            require: 'ngModel',
            link: function(scope, elem, attrs, ctrl) {
                var $errorTip = $('<span class="error-tip">Required!</span>').insertAfter(elem);
                console.log(ctrl.$render);
                ctrl.$render = function() {
                    if (ctrl.$dirty && ctrl.$error.required) {
                        $errorTip.show();
                    } else {
                        $errorTip.hide();
                    }
                };
                scope.$watch('ctrl.$dirty', function() {
                    console.log('gg');
                });
                scope.$watch('ctrl.$error.required', function() {
                    console.log('aaa');
                });
            }
        };
    };
});