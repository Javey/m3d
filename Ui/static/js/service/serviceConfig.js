define(['lodash'], function(_) {
    return _.map([
        'siteService',
        'moduleService',
        'imergeService',
        'projectService'
    ], function(item) {
        return 'service/' + item;
    });
});