define(function() {
    return function() {
        return {
            restrict: 'A',
            scope: {
                isAjax: '@button'
            },
            link: function(scope, elem) {
                var html = elem.html();
                scope.$watch('isAjax', function(isAjax, old) {
                    if (isAjax !== old) {
                        if (isAjax === 'true') {
                            elem.html('请稍后...').addClass('disable');
                        } else {
                            elem.html(html).removeClass('disable');
                        }
                    }
                });
            }
        };
    };
});