define(['lodash'], function(_) {
    return _.map([
        'branchListDirective',
        'requiredTipDirective',
        'buttonDirective',
        'resizableDirective'
    ], function(item) {
        return 'directive/' + item;
    });
});