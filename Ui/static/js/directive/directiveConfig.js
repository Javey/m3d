define(['lodash'], function(_) {
    return _.map([
        'branchListDirective',
        'requiredTipDirective',
        'buttonDirective',
        'resizableDirective',
        'ngEnterDirective'
    ], function(item) {
        return 'directive/' + item;
    });
});