define(['lodash'], function(_) {
    return _.map([
        'siteService',
        'moduleService',
        'imergeService',
        'projectService',
        'userService'
    ], function(item) {
        return 'service/' + item;
    });
});