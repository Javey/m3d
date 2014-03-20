define(['lodash'], function(_) {
    return _.map([
        'appCtrl',
        'mainPanelCtrl',
        'siteListCtrl',
        'siteInfoCtrl',
        'branchCtrl',
        'imergeCtrl'
    ], function(item) {
        return 'controller/' + item;
    });
});