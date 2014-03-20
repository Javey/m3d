define(['lodash'], function(_) {
    return _.map([
        'siteService',
        'moduleService',
        'confirmService',
        'imergeService'
    ], function(item) {
        return 'service/' + item;
    });
});