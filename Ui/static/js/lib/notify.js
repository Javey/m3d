/**
 * Created with JetBrains PhpStorm. 通知组件
 * User: zoujiawei
 * Date: 14-2-13
 * Time: 下午4:24
 * To change this template use File | Settings | File Templates.
 */

angular.module('m3d.notify', [])
    .directive('notifyWindow', ['notifyStack', function(notifyStack) {
        return {
            restrict: 'EA',
            scope: {
                instance: '@'
            },
            template:
                '<div class="notify-window {{type}}"> \
                    <div class="head"> \
                        <div class="title">{{title}}</div> \
                    </div> \
                    <div class="close ion-ios7-close-empty" ng-click="close()"></div> \
                    <div class="body" ng-transclude></div> \
                </div>',
            replace: true,
            transclude: true,
            link: function(scope, elem, attrs) {
                scope.title = attrs.title;
                scope.type = attrs.type;

                scope.close = function() {
                    notifyStack.close(scope.instance);
                }
            }
        }
    }])
    .factory('notifyStack', ['$$stackedMap', '$compile', '$document', '$timeout', function($$stackedMap, $compile, $document, $timeout) {
        var openedNotify = $$stackedMap.createNew(),
            containerDom = null,
            bodyDom = $document.find('body');

        function removeNotify(notifyInstance) {
            var notifyWindow = openedNotify.get(notifyInstance).value;
            openedNotify.remove(notifyInstance);
            notifyWindow.dom
                .animate({
                    opacity: 0
                })
                .slideUp(function() {
                    notifyWindow.dom.remove();
                    if (!openedNotify.length()) {
                        containerDom.remove();
                        containerDom = null;
                    }
                });
            notifyWindow.scope.$destroy();
        }

        var notifyStack = {
            open: function(notifyInstance, notify) {
                var opt = notify.options;
                openedNotify.add(notifyInstance, {
                    deferred: notify.deferred,
                    scope: notify.scope
                });

                if (!containerDom) {
                    containerDom = angular.element('<div class="notify"></div>');
                    bodyDom.append(containerDom);
                }
                var notifyDom = angular.element('<div notify-window></div>');
//                notifyDom.attr('window-class', )
                notifyDom.attr('title', opt.title);
                notifyDom.attr('type', opt.type);
                notifyDom.attr('instance', notifyInstance);
                notifyDom.html(notify.content);
                notifyDom = $compile(notifyDom)(notify.scope);
                openedNotify.top().value.dom = notifyDom;
                containerDom.append(notifyDom);

                // 自动关闭
                if (!opt.sticky) {
                    notifyInstance.timer = $timeout(function() {
                        notifyStack.close(notifyInstance);
                    }, opt.duration);
                }
            },

            close: function(notifyInstance, result) {
                $timeout.cancel(notifyInstance.timer);
                var notify = openedNotify.get(notifyInstance);
                if (notify) {
                    notify.value.deferred.resolve(result);
                    removeNotify(notifyInstance);
                }
            },

            getTop: function() {
                return openedNotify.top();
            }
        };

        return notifyStack;
    }])
    .provider('notify', function() {
        return {
            options: {
                title: 'Notice',
                type: 'normal', // normal/error/warn
                sticky: false, // 是否一直显示
                duration: 3000 // 自动隐藏的时间
            },

            $get: ['$q', '$http', '$rootScope', 'notifyStack', function($q, $http, $rootScope, notifyStack) {
                var self = this;
                return {
                    open: function(options) {
                        options = angular.extend({}, self.options, options);

                        var resultDeferred = $q.defer(),
                            openedDeferred = $q.defer(),
                            notifyInstance = {
                                result: resultDeferred.promise,
                                opened: openedDeferred.promise,
                                close: function(result) {
                                    notifyStack.close(notifyInstance, result);
                                }
                            };

                        function getTemplatePromise() {
                            return options.template ? $q.when(options.template) :
                                $http.get(options.templateUrl).then(function(result) {
                                    return result.data;
                                });
                        }

                        var templatePromise = getTemplatePromise();
                        templatePromise.then(function(tpl) {
                            var notifyScope = (options.scope || $rootScope).$new();
                            notifyStack.open(notifyInstance, {
                                scope: notifyScope,
                                deferred: resultDeferred,
                                content: tpl,
                                options: options
                            });

                            openedDeferred.resolve(true);
                        }, function(reason) {
                            openedDeferred.reject(false);
                            resultDeferred.reject(reason);
                        });

                        return notifyInstance;
                    }
                }
            }]
        }
    });