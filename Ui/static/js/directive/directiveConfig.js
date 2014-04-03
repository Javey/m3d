define(['lodash'], function(_) {
    return _.map([
        'branchListDirective',
        'requiredTipDirective',
        'buttonDirective',
        'resizableDirective',
        'ngEnterDirective',
        'ngImgLoadDirective'
    ], function(item) {
        return 'directive/' + item;
    });
});